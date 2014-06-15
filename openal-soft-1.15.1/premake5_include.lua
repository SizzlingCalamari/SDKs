
if copy_oal_dll then
    assert(target_dir, "error: set target_dir before including this library")
    assert(path.isabsolute(target_dir), "error: target_dir must be an absolute path")
end

-- evaluates the relative include path
local project_path = iif(project().location, project().location, project().basedir)
local include_relative = path.getrelative(project_path, os.getcwd()) .. "/include"

-- adds $(ProjectDir) if using visual studio so intellisense works
include_relative = iif(string.find(_ACTION, "vs20"), "$(ProjectDir)", "") .. include_relative

includedirs (include_relative)

configuration { "windows" }
    libdirs (os.getcwd() .. "/lib/")

configuration { "windows", "x32" }
    links "/Win32/libOpenAL32.dll.lib"
configuration { "windows", "x64" }
    links "/Win64/libOpenAL32.dll.lib"

local copy_path = ""
configuration { "windows", "x32" }
    if copy_oal_dll then
        copy_path = (path.translate("copy " .. os.getcwd() .. "/lib/Win32/soft_oal.dll " .. target_dir .. "/soft_oal.dll"))
    end
    postbuildcommands (copy_path)
configuration { "windows", "x64" }
    if copy_oal_dll then
        copy_path = (path.translate("copy " .. os.getcwd() .. "/lib/Win64/soft_oal.dll " .. target_dir .. "/soft_oal.dll"))
    end
    postbuildcommands (copy_path)
configuration {}
