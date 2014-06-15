
-- evaluates the relative include path
local project_path = iif(project().location, project().location, project().basedir)
local include_relative = path.getrelative(project_path, os.getcwd()) .. "/include/"

-- adds $(ProjectDir) if using visual studio so intellisense works
include_relative = iif(string.find(_ACTION, "vs20"), "$(ProjectDir)", "") .. include_relative

includedirs (include_relative)

configuration { "windows" }
    libdirs (os.getcwd() .. "/lib/win32/")

configuration { "x32", "Debug" }
    links ("/Win32/Debug/libogg_static")
configuration { "x32", "Release" }
    links ("/Win32/Release/libogg_static")
configuration { "x64", "Debug" }
    links ("/x64/Debug/libogg_static")
configuration { "x64", "Release" }
    links ("/x64/Release/libogg_static")
configuration {}
