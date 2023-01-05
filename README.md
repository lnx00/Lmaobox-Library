# LNX's Lmaobox Library (LNXlib)

An Utility Library for the Lmaobox Lua API.
It provides a set of useful functions and classes to make your life easier when writing scripts for Lmaobox.

Use the [Lmaobox Annotations](https://github.com/LewdDeveloper/lmaobox-annotation) for full annotation support.

## Installation

To install this library, download the latest release from the [releases page](https://github.com/lnx00/Lmaobox-Library/releases/latest/) and copy the `LNXlib.lua` file to your `%localappdata%` folder.

_Optionally, you can also download the minified version of the library `LNXlib.min.lua`. Make sure to rename the file to `LNXlib.lua` before copying it to your `%localappdata%` folder!_

## Features

- [x] IO Helpers (Create, Write and Mofify files)
- [x] Config Helper (Easily save and load options for your script)
- [x] Key Helper (Easily check key states)
- [x] Wrappers (Extends the existing TF2 Entity classes)
- [x] Timer & Delayed Calls
- [x] UI Notifications
- [x] Helpers & Utilities
- [x] New data structures
- ... and more!

## Building

To build and deploy this library, you need to have NodeJS installed.

Install the required dependencies with `npm install`.
Then, run `Bundle.bat` to build the library or `BundleAndDeploy.bat` to build and deploy the library to the `%localappdata%` folder.

## Upcoming Features

- [ ] Texture Generator (Gradient, Noise, etc.)

## Included Libraries

- [dkjson](http://dkolf.de/src/dkjson-lua.fsl/home)
