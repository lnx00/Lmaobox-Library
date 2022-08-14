@echo off

node bundle.js
xcopy "LNX-Library.lua" %localappdata% /Y
pause