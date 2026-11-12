# Sakura Social Hub

A Japanese-inspired, two-storey Roblox social hangout starter project.

## What's included
- Procedural building generator in `src/ServerScriptService/SakuraHubBuilder.server.lua`
- Two-storey lounge, café counter, shoji-inspired windows, balcony, stairs, lanterns, sakura garden and pond
- Rojo project mapping in `default.project.json`
- GitHub Actions workflow to build an `.rbxlx` place file and save it as a downloadable workflow artifact

## Important limitations
- This repository is source code, not a running Roblox Studio session.
- You can edit the files from an iPhone browser, but Roblox Studio itself is not available on iOS.
- Voice chat is Roblox's built-in feature. It cannot be granted by a script: eligible players must meet Roblox's age/verification and regional requirements.
- The workflow below builds a place file. Publishing it to an existing Roblox place requires a Creator Dashboard API key, Universe ID, Place ID, and GitHub repository secrets. Do not put API keys in source files.

## Build from GitHub Actions
1. Upload this project to a GitHub repository.
2. Open the repository's **Actions** tab.
3. Run **Build Roblox place**.
4. Download the `SakuraSocialHub-place` artifact from the completed workflow run.

The generated `.rbxlx` still needs to be opened/tested in Roblox Studio or published through the supported Open Cloud place publishing API. Review it in Studio before making it public.

## Voice chat setup
For a place that supports voice:
1. In Creator Dashboard, keep the maximum player count at 100 or fewer.
2. In Studio, open **File > Experience Settings > Communication** and enable **Voice Chat** if it is not already enabled.
3. Publish the experience.
4. Players must independently be eligible and opt in to voice chat. See Roblox's official voice chat documentation.

Official docs:
- https://create.roblox.com/docs/chat/voice-chat
- https://create.roblox.com/docs/cloud/guides/usage-place-publishing
- https://create.roblox.com/docs/projects/place-files
