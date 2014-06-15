
-- evaluates the relative include path
local project_path = iif(project().location, project().location, project().basedir)
local include_relative = path.getrelative(project_path, os.getcwd()) .. "/include"

-- adds $(ProjectDir) if using visual studio so intellisense works
include_relative = iif(string.find(_ACTION, "vs20"), "$(ProjectDir)", "") .. include_relative

includedirs (include_relative)

configuration { "windows" }
    libdirs (os.getcwd() .. "/lib/win32/")

configuration { "x32", "Debug" }
    links ("OALWrapper_x32_debug")
configuration { "x32", "Release" }
    links ("OALWrapper_x32_release")
configuration { "x64", "Debug" }
    links ("OALWrapper_x64_debug")
configuration { "x64", "Release" }
    links ("OALWrapper_x64_release")
configuration {}
