import importlib.util
import json
from pathlib import Path
import shutil
import tempfile
import unittest

MODULE = Path(__file__).with_name("verify_va05_public_export.py")
SPEC = importlib.util.spec_from_file_location("public_export", MODULE)
EXPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(EXPORT)
PACKAGE = MODULE.parent.parent


class ExportTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.receipt = json.loads(MODULE.with_name("va05-public-export.json").read_text())
        files = list(self.receipt["files"])
        files += ["Sources/VedikaSDK/RoomCapture/RoomPlanCaptureController.swift"]
        files += ["Tests/VedikaRoomCaptureTests/" + f for f in self.receipt["apple_test_files"]]
        files += ["Tests/VedikaRoomCaptureTests/Resources/" + f for f in
                  self.receipt["test_resources"] + ["attestation-vectors.json"]]
        for name in files:
            target = self.root / name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(PACKAGE / name, target)
        self.manifest = self.root / "receipt.json"
        self.manifest.write_text(json.dumps(self.receipt))
        self.dump = self.root / "package.json"
        self.products = [{"name": name, "targets": [target]}
                         for name, target in self.receipt["products"].items()]
        self.write_dump()

    def write_dump(self):
        self.dump.write_text(json.dumps({"products": self.products}))

    def verify(self):
        return EXPORT.verify(self.root, self.dump, self.manifest)

    def test_both_public_products_and_source_digests(self):
        self.assertEqual(self.verify()["result"], "PASS")
        self.assertEqual(self.verify()["version"], "1.4.0")

    def test_missing_sdk_product_fails(self):
        self.products = [p for p in self.products if p["name"] != "VedikaSDK"]
        self.write_dump()
        with self.assertRaisesRegex(ValueError, "lacks the VedikaSDK product"):
            self.verify()

    def test_changed_remedy_source_fails(self):
        path = self.root / "Sources/VedikaRoomCapture/RemedyFloorOverlay.swift"
        path.write_text(path.read_text() + "\n// Changed exported source\n")
        with self.assertRaisesRegex(ValueError, "source digest mismatch"):
            self.verify()

    def test_missing_acceptance_fixture_fails(self):
        (self.root / "Tests/VedikaRoomCaptureTests/Resources/native-1.4.0-contract.json").unlink()
        with self.assertRaisesRegex(ValueError, "missing packaged contract fixture"):
            self.verify()


if __name__ == "__main__":
    unittest.main()
