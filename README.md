<p align="center">
    <img width="256" heigth="256" src="logo.svg">
    <h1 align="center">ManyMC</h1>
    <p align="center">
        An unofficial build of MultiMC with support for macOS arm64 (M1)
    </p>
</p>

> ### ⚠️ This is an UNOFFICIAL project. DO NOT report any issues to the MultiMC team. ONLY raise issues in THIS repository.

## Supported versions

All stable Minecraft versions from `1.6.4` to `1.18` have been tested and work great. Version `1.5.2` and before will have inverted colors and choppy performance.

## Install

1. Make sure you have an arm64 native version of Java installed. For example, [Azul OpenJDK 17 arm64](https://www.azul.com/downloads/?version=java-17-lts&os=macos&architecture=arm-64-bit&package=jdk).

2. Download the [latest release](https://github.com/MinecraftMachina/ManyMC/releases/latest/download/ManyMC.zip) of this app and extract it.

3. The first time only, do not double-click on the app, but right-click on it and press `Open`, then `Open` again.

4. As you go through the initial setup, make sure you select your arm64 native version of Java. To verify this, at the Java selection window, click on the green checkmark on the right side - it should mention `aarch64`, like:
   ```
   Java test succeeded!
   Platform reported: aarch64
   Java version reported: 17.0.1
   ```

That's all! Everything will work like normal, and it will be fully optimized for your platform.

## Known bugs

- Enabling full screen from the game settings permanently crashes the game
  - To recover, select your instance in ManyMC and click on `Minecraft Folder`. In the folder that opens, edit the file `options.txt` and change `fullscreen:true` to `fullscreen:false`
- Using text-to-speech will result in a crash
  - No current workaround

## How does it work

Minecraft is almost entirely written in Java, which means that as long as you have a native arm64 Java installed, you can almost run Minecraft natively without special work. The exception are some libraries like LWJGL, which have platform-specific binaries. However, since most of the libraries are open-source, they can be re-built or hacked to work.

At the time of writing there is no official arm64 launcher, be it third or first party. However, the amazing MultiMC can be easily compiled to run on arm64. To comply with MultiMC's licensing, this unofficial build was rebranded as ManyMC. In order to make ManyMC use the modified libraries, we create a neat custom [meta package](https://github.com/MinecraftMachina/meta-multimc-arm64/).

## Building

> ⚠️ This will only work on macOS. Tested on macOS 12.0.1 arm64.

1. Install dependencies:

   ```bash
   brew install cask-versions zulu8 qt@5 cmake
   ```

2. Install XCode and set it up to the point where you can build things from a terminal

3. Ensure that `JAVA_HOME` points to Java 8

4. Run:

   ```bash
   git clone --recursive https://github.com/MultiMC/Launcher.git ManyMC
   cd ManyMC
   git reset --hard ffcef673de9fe848a92d23e02a2abed8df16eb9f
   git clone https://github.com/MinecraftMachina/manymc-branding secrets
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
   -DLauncher_META_URL="https://raw.githubusercontent.com/MinecraftMachina/meta-multimc-arm64/master/" \
   -DLauncher_EMBED_SECRETS=ON \
   ..
   make -j$(sysctl -n hw.physicalcpu) install
   cd ../dist
   chmod -R u+w .
   find . -depth -exec codesign -f -s - {} \;
   ```
