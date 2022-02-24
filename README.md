<p align="center">
    <img width="256" heigth="256" src="wiki/logo.svg">
    <h1 align="center">ManyMC</h1>
    <p align="center">
        A familiar Minecraft Launcher with native support for macOS arm64 (M1)
    </p>
</p>

---
> ### ⚠️ ManyMC is NOT SUPPORTED by the MultiMC team. Only report issues with ManyMC here.
---

## Supported versions

All stable Minecraft versions from `1.6.4` to `1.18` have been tested and work great. Fabric, Forge, and OptiFine also work across all versions. Even huge modpacks like All the Mods 6 run perfectly!

## Community

Come join the official Discord to get support and test beta versions with better performance! Link is here: https://discord.gg/CcFxPaDnjv

## More fixes

Can't sprint and attack at the same time? Or sneak and scroll? These are all old and unfixed Minecraft bugs on macOS. Get rid of them now using our mod [McMouser](https://github.com/MinecraftMachina/McMouser) ([CurseForge](https://www.curseforge.com/minecraft/mc-mods/mcmouser)).

## Install

1. Make sure you have an `arm64` native version of `Java 17` or above installed. For example, [Azul OpenJDK 17 arm64](https://www.azul.com/downloads/?version=java-17-lts&os=macos&architecture=arm-64-bit&package=jdk).

2. Download the [latest release](https://github.com/MinecraftMachina/ManyMC/releases/latest/download/ManyMC.zip) of ManyMC and extract it.
	
	> **:warning: If you are coming from ManyMC Build 4 or before and you want to keep your data, you will have to migrate it. Check out [these release notes for more information](https://github.com/MinecraftMachina/ManyMC/releases/tag/v0.0.5).**
	
3. Start the app. If it gives an error about code signing, one time only, do not double-click on the app, but instead right-click on it and press `Open`, then `Open` again.

4. As you go through the initial setup, make sure to select your `arm64` native version of Java. To verify this, at the Java selection window, make sure the "Architecture" column of your selected version says `aarch64`:
   
   ![](wiki/pic1.png)

That's all! Everything will work like normal, and it will be fully optimized for your platform.

If you prefer, click the image below for an unofficial video tutorial:

[![](https://img.youtube.com/vi/At5nF5i8oTg/0.jpg)](https://www.youtube.com/watch?v=At5nF5i8oTg)

## Troubleshooting

- Minecraft/MultiMC released an update, but I can't see it in ManyMC
  - To force an update of the Minecraft metadata, [visit this link](https://pull.git.ci/process/MinecraftMachina/meta-multimc-arm64)
- OptiFine doesn't work
  - To fix, install one of the two combinations below:
    - Forge + OptiFine
    - Fabric + [OptiFabric](https://www.curseforge.com/minecraft/mc-mods/optifabric) + OptiFine
  - On Minecraft `1.8.9`, you need the latest **preview** version of OptiFine
- Minecraft `1.16` and before crash on boot
  - To fix, install an `arm64` native version of `Java 8` (i.e. [Azul OpenJDK 8 arm64](https://www.azul.com/downloads/?version=java-8-lts&os=macos&architecture=arm-64-bit&package=jdk)). Set your instance in ManyMC to use this version
- Forge crashes on boot
  - Either update it to the latest version, or downgrade to Java build 320 or before

## How does it work

Minecraft is almost entirely written in Java, which means that as long as you have a native arm64 Java installed, you can almost run Minecraft natively without special work. The exception are some libraries like LWJGL, which have platform-specific binaries. However, since most of the libraries are open-source, they can be re-built or hacked to work.

At the time of writing there is no official arm64 launcher, be it third or first party. However, the amazing MultiMC can be easily compiled to run on arm64. To comply with MultiMC's licensing, this unofficial build was rebranded as ManyMC. In order to make ManyMC use the modified libraries, we create a neat custom [meta package](https://github.com/MinecraftMachina/meta-multimc-arm64/).

## Building

> ⚠️ This will only work on macOS. Tested on macOS 12.1 arm64.

1. Install dependencies:

   ```bash
   brew tap homebrew/cask-versions
   brew install zulu8 qt@5 cmake
   ```

2. Install XCode and make sure the command line tools are set up:

   ```bash
   xcode-select -p
   ```

3. Run a build:

   ```bash
   ./build.sh
   ```
   
   - If you have your own secrets, make sure they are placed in a directory named `secrets`.
   - If you get weird Java errors, you may have to manually set your `JAVA_HOME` to the zulu8 you just installed.
