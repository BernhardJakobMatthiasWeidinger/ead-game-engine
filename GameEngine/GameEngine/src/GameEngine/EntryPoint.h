#pragma once

#ifdef GE_PLATFORM_WINDOWS

	extern GameEngine::Application* GameEngine::CreateApplication();

	int main(int argc, char** argv) 
	{
		auto game = GameEngine::CreateApplication();
		game->Run();
		delete game;
	}

#endif