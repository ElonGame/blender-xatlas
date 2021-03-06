local THIRDPARTY_DIR = "thirdparty"
local BGFX_DIR = path.join(THIRDPARTY_DIR, "bgfx")
local BIMG_DIR = path.join(THIRDPARTY_DIR, "bimg")
local BX_DIR = path.join(THIRDPARTY_DIR, "bx")
local EIGEN_DIR = path.join(THIRDPARTY_DIR, "eigen")
local EMBREE_DIR = path.join(THIRDPARTY_DIR, "embree3")
local ENKITS_DIR = path.join(THIRDPARTY_DIR, "enkiTS")
local GLFW_DIR = path.join(THIRDPARTY_DIR, "glfw")
local IGL_DIR = path.join(THIRDPARTY_DIR, "libigl")
local MIMALLOC_DIR = path.join(THIRDPARTY_DIR, "mimalloc")
local NATIVEFILEDIALOG_DIR = path.join(THIRDPARTY_DIR, "nativefiledialog")
local OIDN_DIR = path.join(THIRDPARTY_DIR, "oidn")
local OPENFBX_DIR = path.join(THIRDPARTY_DIR, "OpenFBX")

project "xatlas-blender"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++11"
	exceptionhandling "Off"
	rtti "Off"
	warnings "Extra"
	sanitizer()
	files "xatlas-blender.cpp"	
	includedirs(THIRDPARTY_DIR)
	links { "stb_image_write", "tiny_obj_loader", "xatlas" }
	filter "action:vs*"
		files "xatlas.natvis"
		postbuildcommands {
			'xcopy /y \"$(ProjectDir)$(OutDir)$(TargetName)$(TargetExt)\" \"$(ProjectDir)..\\..\\..\\addons\\blender_xatlas\\xatlas\"'
		}
	filter "system:linux"
		links { "pthread" }

group "thirdparty"

project "bgfx"
	kind "StaticLib"
	language "C++"
	cppdialect "C++14"
	exceptionhandling "Off"
	rtti "Off"
	sanitizer()
	defines	{ "__STDC_FORMAT_MACROS" }
	files
	{
		path.join(BGFX_DIR, "include/bgfx/**.h"),
		path.join(BGFX_DIR, "src/*.cpp"),
		path.join(BGFX_DIR, "src/*.h")
	}
	excludes
	{
		path.join(BGFX_DIR, "src/amalgamated.cpp")
	}
	includedirs
	{
		path.join(BX_DIR, "include"),
		path.join(BIMG_DIR, "include"),
		path.join(BIMG_DIR, "3rdparty"),
		path.join(BIMG_DIR, "3rdparty/astc-codec/include"),
		path.join(BIMG_DIR, "3rdparty/iqa/include"),
		path.join(BGFX_DIR, "include"),
		path.join(BGFX_DIR, "3rdparty"),
		path.join(BGFX_DIR, "3rdparty/dxsdk/include"),
		path.join(BGFX_DIR, "3rdparty/khronos")
	}
	filter "configurations:Debug"
		defines "BGFX_CONFIG_DEBUG=1"
	filter "action:vs*"
		defines { "_CRT_SECURE_NO_WARNINGS" }
		includedirs { path.join(BX_DIR, "include/compat/msvc") }
		excludes
		{
			path.join(BGFX_DIR, "src/glcontext_glx.cpp"),
			path.join(BGFX_DIR, "src/glcontext_egl.cpp")
		}
	filter { "system:windows", "action:gmake" }
		includedirs { path.join(BX_DIR, "include/compat/mingw") }
		
project "bimg"
	kind "StaticLib"
	language "C++"
	cppdialect "C++14"
	exceptionhandling "Off"
	rtti "Off"
	sanitizer()
	defines
	{
		"BIMG_DECODE_ENABLE=0"
	}
	files
	{
		path.join(BIMG_DIR, "include/bimg/*.h"),
		path.join(BIMG_DIR, "src/*.cpp"),
		path.join(BIMG_DIR, "src/*.h")
	}
	includedirs
	{
		path.join(BX_DIR, "include"),
		path.join(BIMG_DIR, "include")
	}
	filter "action:vs*"
		defines { "_CRT_SECURE_NO_WARNINGS" }
		includedirs { path.join(BX_DIR, "include/compat/msvc") }
	filter { "system:windows", "action:gmake" }
		includedirs { path.join(BX_DIR, "include/compat/mingw") }

project "bx"
	kind "StaticLib"
	language "C++"
	cppdialect "C++14"
	exceptionhandling "Off"
	rtti "Off"
	sanitizer()
	defines	{ "__STDC_FORMAT_MACROS" }
	files
	{
		path.join(BX_DIR, "include/bx/*.h"),
		path.join(BX_DIR, "include/bx/inline/*.inl"),
		path.join(BX_DIR, "include/tinystl/*.h"),
		path.join(BX_DIR, "src/*.cpp")
	}
	excludes
	{
		path.join(BX_DIR, "src/amalgamated.cpp"),
		path.join(BX_DIR, "src/crtnone.cpp")
	}
	includedirs
	{
		path.join(BX_DIR, "3rdparty"),
		path.join(BX_DIR, "include")
	}
	filter "action:vs*"
		defines { "_CRT_SECURE_NO_WARNINGS" }
		includedirs { path.join(BX_DIR, "include/compat/msvc") }
	filter { "system:windows", "action:gmake" }
		includedirs { path.join(BX_DIR, "include/compat/mingw") }

project "cgltf"
	kind "StaticLib"
	language "C"
	sanitizer()
	files(path.join(THIRDPARTY_DIR, "cgltf.*"))
	filter "action:vs*"
		defines { "_CRT_SECURE_NO_WARNINGS" }
		
project "enkiTS"
	kind "StaticLib"
	language "C++"
	cppdialect "C++11"
	exceptionhandling "Off"
	rtti "Off"
	sanitizer()
	files(path.join(ENKITS_DIR, "*.*"))

project "glfw"
	kind "StaticLib"
	language "C"
	sanitizer()
	files
	{
		path.join(GLFW_DIR, "include/*.h"),
		path.join(GLFW_DIR, "src/context.c"),
		path.join(GLFW_DIR, "src/egl_context.c"),
		path.join(GLFW_DIR, "src/init.c"),
		path.join(GLFW_DIR, "src/input.c"),
		path.join(GLFW_DIR, "src/monitor.c"),
		path.join(GLFW_DIR, "src/osmesa_context.c"),
		path.join(GLFW_DIR, "src/vulkan.c"),
		path.join(GLFW_DIR, "src/window.c"),
	}
	includedirs { path.join(GLFW_DIR, "include") }
	filter "system:windows"
		defines "_GLFW_WIN32"
		files
		{
			path.join(GLFW_DIR, "src/win32_init.c"),
			path.join(GLFW_DIR, "src/win32_joystick.c"),
			path.join(GLFW_DIR, "src/win32_monitor.c"),
			path.join(GLFW_DIR, "src/win32_thread.c"),
			path.join(GLFW_DIR, "src/win32_time.c"),
			path.join(GLFW_DIR, "src/win32_window.c"),
			path.join(GLFW_DIR, "src/wgl_context.c")
		}
	filter "system:linux"
		defines "_GLFW_X11"
		files
		{
			path.join(GLFW_DIR, "src/glx_context.c"),
			path.join(GLFW_DIR, "src/linux*.c"),
			path.join(GLFW_DIR, "src/posix*.c"),
			path.join(GLFW_DIR, "src/x11*.c"),
			path.join(GLFW_DIR, "src/xkb*.c")
		}
	filter "action:vs*"
		defines { "_CRT_SECURE_NO_WARNINGS" }
	filter {}
	
project "imgui"
	kind "StaticLib"
	language "C++"
	exceptionhandling "Off"
	rtti "Off"
	sanitizer()
	files(path.join(THIRDPARTY_DIR, "imgui/*.*"))
	
project "mimalloc"
	kind "StaticLib"
	language "C"
	sanitizer()
	includedirs(path.join(MIMALLOC_DIR, "include"))
	files(path.join(MIMALLOC_DIR, "src/*.*"))
	excludes
	{
		path.join(MIMALLOC_DIR, "src/alloc-override*"),
		path.join(MIMALLOC_DIR, "src/page-queue.c"),
		path.join(MIMALLOC_DIR, "src/static.c")
	}
	
project "nativefiledialog"
	kind "StaticLib"
	language "C++"
	exceptionhandling "Off"
	rtti "Off"
	sanitizer()
	includedirs(path.join(NATIVEFILEDIALOG_DIR, "include"))
	files(path.join(NATIVEFILEDIALOG_DIR, "nfd_common.*"))
	filter "system:windows"
		files(path.join(NATIVEFILEDIALOG_DIR, "nfd_win.cpp"))
	filter "system:linux"
		files(path.join(NATIVEFILEDIALOG_DIR, "nfd_gtk.c"))
		buildoptions(os.outputof("pkg-config --cflags gtk+-3.0"))
	filter "action:vs*"
		defines { "_CRT_SECURE_NO_WARNINGS" }
	
project "objzero"
	kind "StaticLib"
	language "C"
	cdialect "C99"
	sanitizer()
	files(path.join(THIRDPARTY_DIR, "objzero/objzero.*"))
	
project "OpenFBX"
	kind "StaticLib"
	language "C++"
	cppdialect "C++14"
	exceptionhandling "Off"
	rtti "Off"
	sanitizer()
	files(path.join(OPENFBX_DIR, "*.*"))
	
project "stb_image"
	kind "StaticLib"
	language "C"
	sanitizer()
	files(path.join(THIRDPARTY_DIR, "stb_image.*"))
	
project "stb_image_resize"
	kind "StaticLib"
	language "C"
	sanitizer()
	files(path.join(THIRDPARTY_DIR, "stb_image_resize.*"))
	
project "stb_image_write"
	kind "StaticLib"
	language "C"
	sanitizer()
	files(path.join(THIRDPARTY_DIR, "stb_image_write.*"))
	
project "tiny_obj_loader"
	kind "StaticLib"
	language "C++"
	exceptionhandling "Off"
	rtti "Off"
	sanitizer()
	files(path.join(THIRDPARTY_DIR, "tiny_obj_loader.*"))
