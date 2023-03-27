@echo off

:runTests
cls
lua54 Test.lua
pause
goto runTests
