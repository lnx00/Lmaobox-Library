@echo off

node bundle.js
move /Y "lnxLib.lua" "%localappdata%"
pause