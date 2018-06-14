
def _clojure_binary_impl(ctx):
    output_jar = ctx.outputs.jar
    build_output = output_jar.path + ".build_output"

    clojure_compile = "(set! *compile-path* \\\"%s\\\") (compile '%s)" % (build_output, ctx.attr.main_class)

    cmd = "rm -rf %s\n" % build_output
    cmd += "mkdir -p %s\n" % build_output
    
    clj_paths = []

    for srcfile in ctx.files.srcs:
        dirpath = build_output + "/" + srcfile.dirname
        cmd += "mkdir -p %s\n" % dirpath
        cmd += "cp %s %s\n" % (srcfile.path, dirpath)
    
    cmd += "export JAVA_HOME=external/local_jdk\n"
    cmd += "export JAVA_CLASSPATH=%s\n" % ":".join([jar.path for jar in ctx.files._clojure_jars] + [build_output])
    cmd += "java -cp $JAVA_CLASSPATH clojure.main -e \"%s\"\n" % clojure_compile
    cmd += "find %s -name '*.class' | sed 's:^%s/::' > %s/class_list\n" % (
        build_output,
        build_output,
        build_output,
    )
    cmd += "root=`pwd`\n"
    cmd += "cd %s; $root/%s Cc ../%s @class_list\n" % (
        build_output,
        ctx.executable._zipper.path,
        output_jar.basename,
    )
    cmd += "cd $root\n"

    print(cmd)

    ctx.action(
        inputs = (
            ctx.files.srcs
            + ctx.files._clojure_jars
            + ctx.files._jdk
            + ctx.files._zipper
        ),
        outputs = [output_jar],
        mnemonic = "Clojurec",
        command = "set -e;" + cmd,
        use_default_shell_env = True,
    )

_clojure_binary_attrs = {
    "main_class": attr.string(mandatory=True),
    "srcs": attr.label_list(allow_files = [".clj"]),
    "_clojure_jars": attr.label_list(default=[
        Label("@org_clojure//jar"),
        Label("@org_clojure_spec_alpha//jar"),
        Label("@org_clojure_core_specs_alpha//jar"),
    ]),
    "_jdk": attr.label(
        default = Label("//tools/defaults:jdk"),
    ),
    "_zipper": attr.label(
        default = Label("@bazel_tools//tools/zip:zipper"),
        executable = True,
        single_file = True,
        cfg = "host",
    ),
}

_clojure_binary_outputs = {
    "jar": "%{name}.jar",
}

clojure_binary = rule(
    implementation = _clojure_binary_impl,
    attrs = _clojure_binary_attrs,
    outputs = _clojure_binary_outputs,
    # executable = True,
    fragments = ["java"],
)
