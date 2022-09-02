@echo off

node bundle.js
move /Y "LNX-Library.lua" "%localappdata%"
pause