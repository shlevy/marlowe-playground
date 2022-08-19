{ runCommand, play-generated, src, diffutils, glibcLocales }:
runCommand "generated-purescript-test"
{
  buildInputs = [ diffutils glibcLocales ];
} ''
  set +e
  echo ${toString src}
  cp -a ${src} expected
  cp -a ${src} actual
  chmod -R +w actual
  rm -rf actual/marlowe-playground-client/generated
  cp -a ${play-generated} actual/marlowe-playground-client/generated
  diff --brief --recursive expected actual
  EXIT_CODE=$?
  if [[ $EXIT_CODE != 0 ]]
  then
    mkdir -p $out/nix-support
    diff -ur expected actual > $out/actual.diff
    echo "file none $out/actual.diff" > $out/nix-support/hydra-build-products
    echo "*** actual found changes that need addressed first"
    echo "*** Please run \`generate-purescript\` and commit changes."

    echo "*** or apply the diff generated by hydra if you don't have nix."
    exit $EXIT_CODE
  else
    echo $EXIT_CODE > $out
  fi
''
