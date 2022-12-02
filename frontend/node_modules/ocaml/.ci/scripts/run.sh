STAGING="$HOME/foo"
VERSION=$(node -e 'console.log(require("./package.json").version)')

esy i # no need to run esy b here because the test app runs it anyway
# mkdir -p "$script:APP"
npm pack
mkdir -p "$STAGING"
mv ocaml-$VERSION.tgz package.tgz
tar -xf package.tgz -C ${TMPDIR:="$HOME"}
mv "$TMPDIR/package" "$STAGING/esy-ocaml"
cp -R "test-app" "$STAGING"
cd "$STAGING/test-app/"
esy i
esy x hello
