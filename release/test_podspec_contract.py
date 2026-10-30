"""VedikaSDK.podspec must describe the package SwiftPM builds, and no source may need SwiftPM's Bundle.module."""
import re
import unittest
from pathlib import Path

PACKAGE = Path(__file__).parent.parent
SOURCES = PACKAGE / "Sources" / "VedikaSDK"
SHIM = SOURCES / "VedikaResourceBundle.swift"


def field(spec, name):
    found = re.search(r"^\s*s\." + re.escape(name) + r"\s*=\s*(.+)$", spec, re.M)
    return found.group(1).strip() if found else None


def problems(spec, sources=SOURCES, package=PACKAGE):
    """Every way `spec` and the Swift sources disagree with the package; an empty list is a pass."""
    found = []
    manifest = (package / "Package.swift").read_text()
    if field(spec, "name") != "'VedikaSDK'":
        found.append("the pod must be named VedikaSDK")
    version = field(spec, "version")
    if not version or not re.fullmatch(r"'\d+\.\d+\.\d+'", version):
        found.append("version must be a plain x.y.z string")
    if ":tag => s.version.to_s" not in (field(spec, "source") or ""):
        found.append("source must be the git tag named by the pod version")
    for platform, short in (("iOS", "ios"), ("macOS", "osx")):
        declared = re.search(r"\." + platform + r"\(\.v(\d+)\)", manifest)
        target = field(spec, f"{short}.deployment_target")
        if not declared or target != f"'{declared.group(1)}.0'":
            found.append(f"{short} deployment target must equal Package.swift's {platform} floor")
    tools = re.search(r"swift-tools-version:(\d+\.\d+)", manifest)
    if not tools or field(spec, "swift_versions") != f"['{tools.group(1)}']":
        found.append("swift_versions must equal the package's swift-tools-version")
    if field(spec, "source_files") != "'Sources/VedikaSDK/**/*.swift'":
        found.append("source_files must be exactly the VedikaSDK target")
    if "VedikaRoomCapture" in re.sub(r"(?m)^\s*#.*$", "", spec).replace("(VedikaRoomCapture)", ""):
        found.append("the pod must not ship VedikaRoomCapture: it imports VedikaSDK, which a merged pod module cannot")
    bundle = re.search(r"resource_bundles\s*=\s*\{\s*'VedikaSDKResources'\s*=>\s*\['([^']+)'\]", spec)
    if not bundle:
        found.append("resource_bundles must name VedikaSDKResources")
    else:
        folder = package / bundle.group(1)
        if bundle.group(1).endswith(("*", "/")) or not (folder / "manifest.json").is_file() or not (folder / "index.html").is_file():
            found.append("the resource bundle must be the VastuRuntime folder itself, with manifest.json and index.html")
    for path in sorted(sources.rglob("*.swift")):
        text = path.read_text()
        code = re.sub(r"(?m)//.*$", "", text)
        if "Bundle.module" in code and path != SHIM:
            found.append(f"{path.name} uses Bundle.module; read Bundle.vedikaResources")
    return found


class PodspecContract(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.spec = (PACKAGE / "VedikaSDK.podspec").read_text()

    def test_the_podspec_matches_the_package(self):
        self.assertEqual(problems(self.spec), [])

    def test_the_shim_reads_bundle_module_only_for_a_swiftpm_build(self):
        text = SHIM.read_text()
        before, _, rest = text.partition("#if SWIFT_PACKAGE\n        return Bundle.module\n        #else")
        self.assertTrue(rest, "Bundle.module must sit alone in the #if SWIFT_PACKAGE branch")
        self.assertNotIn("Bundle.module", re.sub(r"(?m)//.*$", "", before + rest))
        self.assertIn("VedikaSDKResources", rest)

    def test_both_runtime_lookups_go_through_the_shim(self):
        for name in ("VastuRuntimeBundle.swift", "VastuArView.swift"):
            self.assertIn("Bundle.vedikaRuntimeIndex", (SOURCES / name).read_text(), name)

    def test_a_wrong_pod_is_reported(self):
        for before, after, expect in (
            ("'Sources/VedikaSDK/**/*.swift'", "'Sources/**/*.swift'", "source_files"),
            ("s.ios.deployment_target = '15.0'", "s.ios.deployment_target = '14.0'", "ios deployment target"),
            ("s.swift_versions = ['5.9']", "s.swift_versions = ['5.5']", "swift_versions"),
            ("VastuRuntime']", "VastuRuntime/**/*']", "resource bundle"),
            (":tag => s.version.to_s", ":tag => 'main'", "source must be"),
            ("s.name         = 'VedikaSDK'", "s.name         = 'Vedika'", "named VedikaSDK"),
        ):
            spec = self.spec.replace(before, after)
            self.assertNotEqual(spec, self.spec, before)
            self.assertTrue(any(expect in p for p in problems(spec)), (before, problems(spec)))

    def test_a_source_that_reads_bundle_module_is_reported(self):
        import tempfile
        with tempfile.TemporaryDirectory() as tmp:
            sources = Path(tmp) / "Sources" / "VedikaSDK"
            sources.mkdir(parents=True)
            (sources / "Leak.swift").write_text("let b = Bundle.module\n")
            (sources / "Fine.swift").write_text("// Bundle.module is SwiftPM only\nlet b = Bundle.vedikaResources\n")
            got = problems(self.spec, sources=sources)
            self.assertTrue(any("Leak.swift uses Bundle.module" in p for p in got), got)
            self.assertFalse(any("Fine.swift" in p for p in got), got)


if __name__ == "__main__":
    unittest.main()
