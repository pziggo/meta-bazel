SUMMARY = "Open-source build and test tool"
DESCRIPTION = "Bazel is an open-source build and test tool similar to Make, \
Maven, and Gradle. It uses a human-readable, high-level build language. Bazel \
supports projects in multiple languages and builds outputs for multiple \
platforms. Bazel supports large codebases across multiple repositories, and \
large numbers of users."
HOMEPAGE = "https://bazel.build/"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

PROVIDES = "bazel-native"

SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${PV}-${BUILD_OS}-${BUILD_ARCH};name=bazel_${BUILD_OS}_${BUILD_ARCH}"
SRC_URI[bazel_linux_x86_64.sha256sum] = "4f0e14764a60375855e59bafb1de26f5189f6d34a65587c8d6dc499e57a8a8f0"
SRC_URI[bazel_linux_arm64.sha256sum] = "72eadf8e48f60fbb956e18aad7c5a6ebe3554bc158ffca4c6850b353f932c575"

S = "${WORKDIR}"

inherit native

do_configure[noexec] = "1"
do_compile[noexec] = "1"

INHIBIT_SYSROOT_STRIP = "1"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${S}/bazel-${PV}-${BUILD_OS}-${BUILD_ARCH} ${D}${bindir}/bazel
}
