clojure_jar = "https://repo1.maven.org/maven2/org/clojure/clojure/1.9.0/clojure-1.9.0.jar"
spec_jar = "http://central.maven.org/maven2/org/clojure/spec.alpha/0.1.143/spec.alpha-0.1.143.jar"
core_spec_jar = "http://central.maven.org/maven2/org/clojure/core.specs.alpha/0.1.24/core.specs.alpha-0.1.24.jar"

leiningen_jar = "https://github.com/technomancy/leiningen/releases/download/2.8.1/leiningen-2.8.1-standalone.zip"

def clj_repositories():

    native.maven_jar(
        name = "org_clojure",
        artifact = "org.clojure:clojure:1.9.0",
    )
    native.maven_jar(
        name = "org_clojure_spec_alpha",
        artifact = "org.clojure:spec.alpha:0.1.143",
    )
    native.maven_jar(
        name = "org_clojure_core_specs_alpha",
        artifact = "org.clojure:core.specs.alpha:0.1.24",
    )

