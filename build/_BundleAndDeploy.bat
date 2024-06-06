@echo off

node bundle.js
move /Y "LmaoLib.lua" "%localappdata%"
pause