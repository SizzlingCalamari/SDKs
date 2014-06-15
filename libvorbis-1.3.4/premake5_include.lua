
-- evaluates the relative include path
local project_path = iif(project().location, project().location, project().basedir)
local include_relative = path.getrelative(project_path, os.getcwd()) .. "/include"

-- adds $(ProjectDir) if using visual studio so intellisense works
include_relative = iif(string.find(_ACTION, "vs20"), "$(ProjectDir)", "") .. include_relative

includedirs (include_relative)

configuration { "windows" }
    libdirs (os.getcwd() .. "/lib/win32/")

configuration { "windows", "x32", "Debug" }
    links ("/Win32/Debug/libvorbis_static")
    links ("/Win32/Debug/libvorbisfile")
configuration { "windows", "x32", "Release" }
    links ("/Win32/Release/libvorbis_static")
    links ("/Win32/Release/libvorbisfile")
configuration { "windows", "x64", "Debug" }
    links ("/x64/Debug/libvorbis_static")
    links ("/x64/Debug/libvorbisfile")
configuration { "windows", "x64", "Release" }
    links ("/x64/Release/libvorbis_static")
    links ("/x64/Release/libvorbisfile")
configuration {}
