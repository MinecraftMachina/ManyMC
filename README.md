<p align="center">
    <img width="256" heigth="256" src="logo.svg">
    <h1 align="center">ManyMC</h1>
    <p align="center">
        A familiar Minecraft Launcher with native support for macOS arm64 (M1)
    </p>
</p>

---

> ### ⚠️ This is an UNOFFICIAL project. DO NOT report any issues to the MultiMC team. ONLY raise issues in THIS repository.

## Supported versions

All stable Minecraft versions from `1.6.4` to `1.18` have been tested and work great. Fabric, Forge, and OptiFine also work across all versions. Even huge modpacks like All the Mods 6 run perfectly!

## Community

Come join the official Discord to get support and test beta versions with better performance! Link is here: https://discord.gg/CcFxPaDnjv

## Install

1. Make sure you have an `arm64` native version of `Java 17` or above installed. For example, [Azul OpenJDK 17 arm64](https://www.azul.com/downloads/?version=java-17-lts&os=macos&architecture=arm-64-bit&package=jdk).

2. Download the [latest release](https://github.com/MinecraftMachina/ManyMC/releases/latest/download/ManyMC.zip) of ManyMC and extract it.

3. The first time only, do not double-click on the app, but instead right-click on it and press `Open`, then `Open` again.

4. As you go through the initial setup, make sure you select your `arm64` native version of Java. To verify this, at the Java selection window, click on the green checkmark on the right side - it should mention `aarch64`, like:
   ```
   Java test succeeded!
   Platform reported: aarch64
   Java version reported: 17.0.1
   ```

That's all! Everything will work like normal, and it will be fully optimized for your platform.

If you prefer, click the image below for an unofficial video tutorial:

[![](https://img.youtube.com/vi/At5nF5i8oTg/0.jpg)](https://www.youtube.com/watch?v=At5nF5i8oTg)

## Known issues

- Using text-to-speech will result in a crash
  - No current workaround

## Troubleshooting

- Minecraft updates are lagging behind MultiMC
  - To force an update of the Minecraft metadata, [visit this link](https://pull.git.ci/process/MinecraftMachina/meta-multimc-arm64)
- OptiFine doesn't work
  - To fix, install one of the two combinations below:
    - Forge + OptiFine
    - Fabric + [OptiFabric](https://www.curseforge.com/minecraft/mc-mods/optifabric) + OptiFine
- Minecraft `1.16` and before crash on boot
  - To fix, install an `arm64` native version of `Java 8` (i.e. [Azul OpenJDK 8 arm64](https://www.azul.com/downloads/?version=java-8-lts&os=macos&architecture=arm-64-bit&package=jdk)). Set your instance in ManyMC to use this version

## How does it work

Minecraft is almost entirely written in Java, which means that as long as you have a native arm64 Java installed, you can almost run Minecraft natively without special work. The exception are some libraries like LWJGL, which have platform-specific binaries. However, since most of the libraries are open-source, they can be re-built or hacked to work.

At the time of writing there is no official arm64 launcher, be it third or first party. However, the amazing MultiMC can be easily compiled to run on arm64. To comply with MultiMC's licensing, this unofficial build was rebranded as ManyMC. In order to make ManyMC use the modified libraries, we create a neat custom [meta package](https://github.com/MinecraftMachina/meta-multimc-arm64/).

## Building

> ⚠️ This will only work on macOS. Tested on:
- macOS 12.0.1 arm64
- macOS 12.1 arm64

1. Clone the source and subrepos:

   ```
   git clone --recursive https://github.com/MinecraftMachina/ManyMC.git
   ```

2. Install dependencies:

   ```bash
   brew install qt@5 cmake
   ```
   
   (You will also need an arm64 JDK, such as [azul](https://www.azul.com/downloads/?version=java-8-lts&os=macos&architecture=arm-64-bit&package=jdk))

2. Install [XCode](https://xcodereleases.com/) and [set it up](https://stackoverflow.com/a/9329325) to the point where you can build things from a terminal. 

3. Ensure that `JAVA_HOME` points to Java 8:

   ```bash
   export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
   ```

4. Run a build (you may have to set `DLauncher_EMBED_SECRETS` to `OFF`):

   ```bash
   mkdir build
   cd build
   cmake \
      -DCMAKE_C_COMPILER=/usr/bin/clang \
      -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX:PATH="$(dirname $PWD)/dist/" \
      -DCMAKE_PREFIX_PATH="/opt/homebrew/opt/qt@5/" \
      -DQt5_DIR="/opt/homebrew/opt/qt@5/" \
      -DLauncher_LAYOUT=mac-bundle \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=10.7 \
      -DLauncher_META_URL="https://minecraftmachina.github.io/meta-multimc-arm64/" \
      -DLauncher_EMBED_SECRETS=ON \
      ..
   make -j$(sysctl -n hw.physicalcpu) install
   cd ../dist
   chmod -R u+w .
   find . -depth -exec codesign -f -s - {} \;
   ```
   
   You may experience an error that fails your build:
   
   ```
   error: Source option 6 is no longer supported. Use 7 or later.
   error: Target option 6 is no longer supported. Use 7 or later.
   ```
   
   This is most likely caused by `/usr/libexec/java_home` using `/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home` instead of a JDK you installed. To fix this, you will likely need to set `JAVA_HOME` manually to wherever zulu8 is if you didn't use Homebrew:
   
   ```bash
   export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/"
   ```
