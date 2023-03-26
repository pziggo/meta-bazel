# meta-bazel

Integration of bazel and bazel based projects to OE-core

## Dependencies

This layer depends on:

    URI: git://git.yoctoproject.org/poky
    branch: kirkstone

The bazel based projects must depend on [bazel-toolchains-yocto](https://github.com/pziggo/bazel-toolchains-yocto) and add a `local_yocto_toolchain()` entry to their WORKSPACE file.

    local_yocto_toolchain(
        name = "yocto-local",
    )
