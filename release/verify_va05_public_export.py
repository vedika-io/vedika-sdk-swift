#!/usr/bin/env python3
"""Validate a fetched public package, never a substitute source-only receipt."""

import argparse
import hashlib
import json
from pathlib import Path
import re


def verify(root: Path, dump: Path, manifest: Path) -> dict:
    expected = json.loads(manifest.read_text())
    package = json.loads(dump.read_text())
    products = expected.get("products", {expected["product"]: expected["module"]})
    for name, module in products.items():
        product = next((p for p in package["products"] if p["name"] == name), None)
        if product is None or product["targets"] != [module]:
            raise ValueError(f"public package lacks the {name} product")
    symbols = []
    for name, entry in expected["files"].items():
        payload = (root / name).read_bytes()
        if hashlib.sha256(payload).hexdigest() != entry["sha256"]:
            raise ValueError(f"source digest mismatch: {name}")
        source = payload.decode()
        for symbol in entry["symbols"]:
            if not re.search(r"\bpublic\s+(?:final\s+)?(?:class|struct|enum|actor)\s+" + re.escape(symbol) + r"\b", source):
                raise ValueError(f"missing public declaration: {symbol}")
            symbols.append(symbol)
    bridge = (root / "Sources/VedikaSDK/RoomCapture/RoomPlanCaptureController.swift").read_text()
    if "public static func toCaptureSession(" not in bridge:
        raise ValueError("RoomPlan bridge is not exported across modules")
    for filename in expected.get("apple_test_files", ["CaptureOutboxTests.swift", "RelocalizationTests.swift", "NativeAttestationTests.swift"]):
        if not (root / "Tests/VedikaRoomCaptureTests" / filename).is_file():
            raise ValueError(f"missing packaged test: {filename}")
    if not (root / "Tests/VedikaRoomCaptureTests/Resources/attestation-vectors.json").is_file():
        raise ValueError("missing packaged attestation vectors")
    for name in expected.get("test_resources", []):
        if not (root / "Tests/VedikaRoomCaptureTests/Resources" / name).is_file():
            raise ValueError(f"missing packaged contract fixture: {name}")
    if header := expected.get("sdk_version_header"):
        if f'"{header}"' not in (root / "Sources/VedikaSDK/VedikaClient.swift").read_text():
            raise ValueError("SDK version header does not match the export")
    return {"result": "PASS", "version": expected["version"], "product": expected["product"],
            "symbols": symbols, "compilation": "requires separate Apple consumer proof",
            "physical_acceptance": "not measured"}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", required=True, type=Path)
    parser.add_argument("--dump-package", required=True, type=Path)
    parser.add_argument("--manifest", type=Path, default=Path(__file__).with_name("va05-public-export.json"))
    args = parser.parse_args()
    print(json.dumps(verify(args.root, args.dump_package, args.manifest), indent=2))
