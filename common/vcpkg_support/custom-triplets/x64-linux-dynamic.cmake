# from https://learn.microsoft.com/en-us/vcpkg/users/examples/overlay-triplets-linux-dynamic

set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE dynamic) # This changed from static to dynamic

set(VCPKG_CMAKE_SYSTEM_NAME Linux)

set(VCPKG_BUILD_TYPE release)
