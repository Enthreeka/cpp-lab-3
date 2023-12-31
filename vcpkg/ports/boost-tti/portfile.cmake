# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/tti
    REF boost-1.83.0
    SHA512 5a134b60981d84858fe55b18c72737ce3c6a6d644972f86db5a465cc28257249c7288e333d14c2c6e8eca21fb3f6c17d74e41dbad6d4806616f230d2bc0c68ae
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
