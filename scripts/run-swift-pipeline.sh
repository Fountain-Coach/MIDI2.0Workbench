#!/usr/bin/env bash
set -euo pipefail

# Run static extractor, codegen, verify, then Swift build/tests with a local module cache.

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
PKG_DIR="$ROOT_DIR/swift/Midi2Swift"

echo "[1/6] Extracting static contract and vectors…"
node "$ROOT_DIR/scripts/extract-static.js"

echo "[2/6] Generating Swift sources…"
node "$ROOT_DIR/scripts/codegen-swift.js"

echo "[3/6] Generating Swift tests…"
node "$ROOT_DIR/scripts/codegen-swift-tests.js"

echo "[4/6] Generating Profiles/PE catalogs…"
node "$ROOT_DIR/scripts/codegen-profiles.js"

echo "[5/6] Verifying contract and coverage…"
node "$ROOT_DIR/scripts/verify-contract.js"

echo "[6/6] Building and testing Swift package…"
mkdir -p "$PKG_DIR/.clangModuleCache"
export MODULE_CACHE_DIR="$PKG_DIR/.clangModuleCache"
export CLANG_MODULE_CACHE_PATH="$PKG_DIR/.clangModuleCache"

pushd "$PKG_DIR" >/dev/null
swift build
swift test
popd >/dev/null

echo "All done."

