#pragma once

#ifdef GE_PLATFORM_WINDOWS

	extern GameEngine::Application* GameEngine::CreateApplication();

	int main(int argc, char** argv) 
	{
		GameEngine::Log::Init();
		GE_CORE_WARN("Initialized log!");
		int a = 5;
		GE_INFO("hello! Var={0}", a);
		
		auto game = GameEngine::CreateApplication();
		game->Run();
		delete game;
	}

#endif