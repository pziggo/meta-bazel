DEPENDS:prepend = "bazel-native "

BAZEL_OUTPUT_USER_ROOT = "${WORKDIR}/bazel"
BAZEL_OUTPUT_BASE = "${WORKDIR}/build"

OEBAZEL_STARTUP_OPTIONS ?= ""
OEBAZEL_STARTUP_OPTIONS:append = " --output_user_root=${BAZEL_OUTPUT_USER_ROOT}"
OEBAZEL_STARTUP_OPTIONS:append = " --output_base=${BAZEL_OUTPUT_BASE}"

OEBAZEL_FLAGS ?= "-s"
OEBAZEL_TARGET ?= "//..."
OEBAZEL_REPO_NAME ?= "yocto-local"

bazel_do_configure() {
    BAZELRC="${WORKDIR}"/bazelrc
    cat > ${BAZELRC} <<EOF
common --repository_cache=${DL_DIR}/bazel

build --verbose_failures
#build --spawn_strategy=standalone
#build --genrule_strategy=standalone
build --jobs=${@oe.utils.parallel_make(d, False)}
build --strip=never
build --incompatible_enable_cc_toolchain_resolution

build --action_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1

build --repo_env=CC="${CC}"
build --repo_env=CFLAGS="${CFLAGS}"
build --repo_env=CXX="${CXX}"
build --repo_env=CXXFLAGS="${CXXFLAGS}"
build --repo_env=LDFLAGS="${LDFLAGS}"
build --repo_env=OECORE_NATIVE_SYSROOT="${STAGING_DIR_NATIVE}"
build --repo_env=OECORE_TARGET_ARCH="${TARGET_ARCH}"
build --repo_env=OECORE_TARGET_OS="${TARGET_OS}"
build --repo_env=SDKTARGETSYSROOT="${STAGING_DIR_HOST}"
build --repo_env=TARGET_PREFIX="${TARGET_PREFIX}"
build --repo_env=UNINATIVE_LOADER="${UNINATIVE_LOADER}"

build --platforms=@${OEBAZEL_REPO_NAME}//bazel:platform-target
build --extra_toolchains=@${OEBAZEL_REPO_NAME}//bazel/toolchain:cc-toolchain-target
EOF
}
do_configure[cleandirs] = "${BAZEL_OUTPUT_USER_ROOT} ${BAZEL_OUTPUT_BASE}"
OEBAZEL_STARTUP_OPTIONS:append = " --bazelrc=${WORKDIR}/bazelrc"

bazel_do_compile()  {
    bazel ${OEBAZEL_STARTUP_OPTIONS} \
        build \
        ${OEBAZEL_FLAGS} \
        ${OEBAZEL_TARGET}
}

EXPORT_FUNCTIONS do_configure do_compile