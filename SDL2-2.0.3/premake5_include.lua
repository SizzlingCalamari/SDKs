
if copy_sdl_dll then
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
    libdirs (os.getcwd() .. "/lib/win32/")

configuration { "x32" }
    links { "/x86/SDL2", "/x86/SDL2main", "/x86/SDL2test" }
configuration { "x64" }
    links { "/x64/SDL2", "/x64/SDL2main", "/x64/SDL2test" }

local copy_path = ""
configuration { "windows", "x32" }
    if copy_sdl_dll then
        copy_path = (path.translate("copy " .. os.getcwd() .. "/lib/win32/x86/SDL2.dll " .. target_dir .. "/SDL2.dll"))
    end
    postbuildcommands (copy_path)
configuration { "windows", "x64" }
    if copy_sdl_dll then
        copy_path = (path.translate("copy " .. os.getcwd() .. "/lib/win32/x64/SDL2.dll " .. target_dir .. "/SDL2.dll"))
    end
    postbuildcommands (copy_path)
configuration {}
