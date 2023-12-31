
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO podofo/podofo
    REF "${VERSION}"
    SHA512 674024af031392253bc9ea02e392fa7b4a5c8894f3129e05f27133774ccf8b696e225789e886dedbe90bc2323c318b76e79857453a56d6014d7a5514e3f861a2
    PATCHES
        install-cmake-config.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        fontconfig  CMAKE_REQUIRE_FIND_PACKAGE_Fontconfig
    INVERTED_FEATURES
        fontconfig  CMAKE_DISABLE_FIND_PACKAGE_Fontconfig
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" PODOFO_BUILD_STATIC)

file(REMOVE "${SOURCE_PATH}/cmake/modules/FindOpenSSL.cmake")
file(REMOVE "${SOURCE_PATH}/cmake/modules/FindZLIB.cmake")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DPKG_CONFIG_FOUND=true # enable pc file for shared linkage
        -DPODOFO_BUILD_LIB_ONLY=1
        -DPODOFO_BUILD_STATIC=${PODOFO_BUILD_STATIC}
        -DCMAKE_DISABLE_FIND_PACKAGE_Libidn=ON
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_replace_string( "${CURRENT_PACKAGES_DIR}/share/${PORT}/podofo-config.cmake"
    "# Generated by CMake"
    "include(CMakeFindDependencyMacro)
find_dependency(Freetype)
find_dependency(JPEG)
find_dependency(LibXml2)
find_dependency(OpenSSL)
find_dependency(PNG)
find_dependency(TIFF)
find_dependency(ZLIB)
if(\"${CMAKE_REQUIRE_FIND_PACKAGE_Fontconfig}\")
    find_dependency(Fontconfig)
endif()
\n# Generated by CMake")

vcpkg_cmake_config_fixup()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
