esy i # no need to run esy b here because the test app runs it anyway
# mkdir -p "$script:APP"
mkdir "~/foo"
cp -R . "~/foo"
cp -R "test-app" "~/foo"
cd "~/foo/test-app/"
esy i
esy x hello
