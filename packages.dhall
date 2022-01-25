let mkPackage =
      https://raw.githubusercontent.com/purescript/package-sets/psc-0.13.0-20190626/src/mkPackage.dhall sha256:0b197efa1d397ace6eb46b243ff2d73a3da5638d8d0ac8473e8e4a8fc528cf57

let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.14.4-20211028/packages.dhall sha256:df6486e7fad6dbe724c4e2ee5eac65454843dce1f6e10dc35e0b1a8aa9720b26

in  upstream
  with
    moldy = mkPackage
      [ "prelude", "foldable-traversable", "strings"
      , "console", "psci-support"
      ]
      "https://github.com/liamgoodacre/purescript-moldy.git"
      "v3.0.0"
  with
    polyform = mkPackage
      [ "arrays", "bifunctors", "control", "effect", "either"
      , "enums", "functors", "identity", "invariant", "lists"
      , "maybe", "newtype", "parallel", "partial", "prelude"
      , "profunctor", "psci-support", "quickcheck", "quickcheck-laws"
      , "record", "transformers", "tuples", "typelevel-prelude"
      , "unsafe-coerce", "validation", "variant"
      ]
      "https://github.com/purescript-polyform/polyform.git"
      "d177fa5e04a29babf0f86cf57561ea6bf2317c36"
  with
    markdown = mkPackage
      [ "arrays", "assert", "bifunctors", "console", "const"
      , "control", "datetime", "effect", "either", "enums"
      , "foldable-traversable", "functors", "identity", "integers"
      , "lists", "maybe", "newtype", "parsing", "partial"
      , "precise", "prelude", "psci-support", "strings", "tuples"
      , "unfoldable", "unicode", "validation"
      ]
      "https://github.com/input-output-hk/purescript-markdown"
      "022d8afd0d9e0ef8114da9e9ef5a67d9ffc86a29"
  with
    datetime-iso = mkPackage
      [ "aff", "argonaut", "argonaut-codecs", "argonaut-core", "arrays"
      , "bifunctors", "datetime", "effect", "either", "enums"
      , "foldable-traversable", "maybe", "newtype", "parsing", "partial"
      , "prelude", "psci-support", "spec", "strings", "transformers"
      ]
      "https://github.com/input-output-hk/purescript-datetime-iso"
      "c5b3b5421ae36631b0e2823e1199febd5b209791"
  with
    servant-support = mkPackage
      [ "aff", "affjax", "argonaut", "arrays", "bifunctors", "either"
      , "http-methods", "maybe", "newtype", "nonempty", "prelude"
      , "psci-support", "strings", "transformers", "tuples", "uri"
      ]
      "https://github.com/input-output-hk/purescript-servant-support"
      "010bc7b3ea8e2707a00c23fd510201aabd4eb13f"
  with
    json-helpers = mkPackage
      [ "aff", "argonaut-codecs", "argonaut-core", "arrays", "bifunctors"
      , "contravariant", "control", "effect", "either", "enums"
      , "foldable-traversable", "foreign-object", "maybe", "newtype"
      , "ordered-collections", "prelude", "profunctor", "psci-support"
      , "quickcheck", "record", "spec", "spec-quickcheck", "transformers"
      , "tuples", "typelevel-prelude"
      ]
      "https://github.com/input-output-hk/purescript-bridge-json-helpers.git"
      "60615c36abaee16d8dbe09cdd0e772e6d523d024"
  with
    web-common = mkPackage
      [ "aff", "aff-promise", "affjax", "argonaut", "argonaut-codecs"
      , "argonaut-core", "arrays", "avar", "bifunctors", "bigints"
      , "concurrent-queues", "console", "control", "coroutines"
      , "datetime", "debug", "dom-indexed", "effect", "either"
      , "enums", "exceptions", "filterable", "foldable-traversable"
      , "foreign", "foreign-object", "free", "freeap", "freet"
      , "functions", "gen", "halogen", "halogen-subscriptions"
      , "identity", "integers", "json-helpers", "lists", "markdown"
      , "maybe", "newtype", "nonempty", "nullable", "ordered-collections"
      , "parallel", "prelude", "profunctor", "profunctor-lenses"
      , "psci-support", "quickcheck", "rationals", "servant-support"
      , "spec", "spec-quickcheck", "strings", "tailrec", "transformers"
      , "tuples", "undefinable", "unfoldable", "unsafe-coerce", "uuid"
      , "web-dom", "web-events", "web-html", "web-socket", "web-uievents"
      ]
      "https://github.com/input-output-hk/purescript-web-common"
      "v2.0.1"
