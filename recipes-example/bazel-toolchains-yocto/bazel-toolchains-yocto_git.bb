SUMMARY = "Bazel integration for toolchains as built by the Yocto Project."
HOMEPAGE = "https://github.com/pziggo/bazel-toolchains-yocto"
LICENSE = "Apache-2.0"

LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

SRC_URI = "git://github.com/pziggo/bazel-toolchains-yocto;nobranch=1;protocol=https"

SRCREV = "9eab1bc2f79e93d372e07035b0a8e8ddf088930e"

PV = "r1+git${SRCPV}"

S = "${WORKDIR}/git/tests/e2e"

inherit bazel

BBCLASSEXTEND = "native"
