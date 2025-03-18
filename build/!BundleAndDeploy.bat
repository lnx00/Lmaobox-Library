@echo off

node bundle.js
move /Y ".\out\LmaoLib.lua" "%localappdata%"
pause