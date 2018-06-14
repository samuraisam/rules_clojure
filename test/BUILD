package(default_testonly = 1)

load("//clojure:clojure_binary.bzl", "clojure_binary")

# scala_library(
#     name = "clojure-library",
#     srcs = ["clojure-library.clj"],
#     plugins = ["@org_psywerx_hairyfotr__linter//jar"],
#     deps = [
#         "Exported",
#         "MacroTest",
#         "OtherJavaLib",
#         "OtherLib",
#     ],
# )

clojure_binary(
    name = "clojure_binary",
    srcs = ["clojure_binary.clj"],
    main_class = "test.clojure-binary",
    # print_compile_time = True,
    # deps = [
    #     ":HelloLib",
    #     ":MacroTest",
    # ],
)
