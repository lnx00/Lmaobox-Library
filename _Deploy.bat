@echo off

node bundle.js
move /Y "LNXlib.lua" "%localappdata%"
pause