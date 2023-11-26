workspace "GameEngine"
	architecture "x64"

	configurations {
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "GameEngine"
	location "GameEngine"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files {
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs {
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"
		cppdialect "c++17"
		staticruntime "On"
		systemversion "latest"

		defines {
			"GE_PLATFORM_WINDOWS",
			"GE_BUILD_DLL",
			"_WINDLL"
		}

		postbuildcommands {
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" ..outputdir .. "/Game")
		}

	filter "configurations:Debug"
		defines "GE_DEBUG"
		symbols "On"
		
	filter "configurations:Release"
		defines "GE_RELEASE"
		optimize "On"
		
	filter "configurations:Dist"
		defines "GE_DEBUG"
		optimize "On"

project "Game"
	location "Game"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files {
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs {
		"GameEngine/vendor/spdlog/include",
		"GameEngine/src"
	}

	links {
		"GameEngine"
	}

	filter "system:windows"
		cppdialect "c++17"
		staticruntime "On"
		systemversion "latest"

		defines {
			"GE_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "GE_DEBUG"
		symbols "On"
		
	filter "configurations:Release"
		defines "GE_RELEASE"
		optimize "On"
		
	filter "configurations:Dist"
		defines "GE_DEBUG"
		optimize "On"