Libraries built with vs2013. Symbols on for all builds.

Debug mode: LTCG off
Release mode: LTCG on

openal-soft and SDL2 are prebuilt from the authors.



Usage: In the premake5.lua for the project using these sdks,
    call the premake5_include.lua files from a project definition scope.
    SDK includes with dll linking have special variables to control
    whether to copy the dll to the output directory.
    SDKs with dll copying enabled must be included with the global variable
    "target_dir" defined in the premake file.

example premake5.lua:

target_dir = path.getabsolute("build/") .. "/"

local sdks_dir = (path.getabsolute("../../SDKs/") .. "/")
local ogg_dir = (sdks_dir .. "libogg-1.3.2/")
local vorbis_dir = (sdks_dir .. "libvorbis-1.3.4/")
local oalwrapper_dir = (sdks_dir .. "OALWrapper/")
local oalsoft_dir = (sdks_dir .. "openal-soft-1.15.1/")
local sdl2_dir = (sdks_dir .. "SDL2-2.0.3/")

solution "asdf"
    -- ...

    project "asdf"
        -- ...

        -- include libogg
        dofile (ogg_dir .. "premake5_include.lua")

        -- include libvorbis
        dofile (vorbis_dir .. "premake5_include.lua")

        -- include OALWrapper
        dofile (oalwrapper_dir .. "premake5_include.lua")

        -- include oalsoft, don't copy the dll over (false by default)
        copy_oal_dll = false
        dofile (oalsoft_dir .. "premake5_include.lua")

        -- include sdl, copy the dll over
        copy_sdl_dll = true
        dofile (sdl2_dir .. "premake5_include.lua")
