![GitHub commit activity](https://img.shields.io/github/commit-activity/m/lnx00/Lmaobox-Library)
![GitHub Release Date](https://img.shields.io/github/release-date/lnx00/Lmaobox-Library)
![GitHub all releases](https://img.shields.io/github/downloads/lnx00/Lmaobox-Library/total)

# LNX's Lmaobox Library (lnxLib)

An Utility Library for the Lmaobox Lua API.
It provides a set of useful functions and classes to make your life easier when writing scripts for Lmaobox.

Use the [Lmaobox Annotations](https://github.com/lnx00/Lmaobox-Annotations) for full annotation support when developing with this library.

## Installation

[![](https://img.shields.io/badge/Download-Latest-blue?style=for-the-badge&logo=github)](https://github.com/lnx00/Lmaobox-Library/releases/latest/)

To install this library, download the latest release from the [releases page](https://github.com/lnx00/Lmaobox-Library/releases/latest/) and copy the `lnxLib.lua` file to your `%localappdata%` folder.

_Optionally, you can also download the minified version of the library `lnxLib.min.lua`. Make sure to rename the file to `lnxLib.lua` before copying it to your `%localappdata%` folder!_

## Usage

Read the [wiki](https://github.com/lnx00/Lmaobox-Library/wiki) for documentation and installation/usage instructions.

## Features

- [x] IO Helpers (Create, Write and Mofify files)
- [x] Config Helper (Easily save and load options for your script)
- [x] Key Helper (Easily check key states)
- [x] Wrappers (Extends the existing TF2 Entity classes)
- [x] Custom Console Commands
- [x] Timer & Delayed Calls
- [x] UI Notifications
- [x] Helpers & Utilities
- [x] Texture Generator (Gradients, etc.)
- [x] New data structures
- ... and more!

## Building

To pack and deploy this library, you need to have NodeJS installed.

Install the required dependencies with `npm install`.
Then, run `Bundle.bat` to build the library or `BundleAndDeploy.bat` to build and deploy the library to the `%localappdata%` folder.

*Special thanks to [LewdDeveloper](https://github.com/LewdDeveloper) for helping with optimization and giving good advice!*
