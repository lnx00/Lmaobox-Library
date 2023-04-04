package.path = package.path .. ";../?.lua"

local lu = require("luaunit")
local mockAPI = require("MockAPI.MockAPI")

-- Mock required functions
Mockagne.when(engine.GetGameDir()).thenAnswer("Test")
Mockagne.when(globals.RealTime()).thenAnswer(0)

---@type lnxLib
local lnxLib = require("lnxLib.Main")
print("Testing lnxLib version: " .. lnxLib.GetVersion())

local function BeginSection(name)
    print(string.format("\n== %s ==", name))
end

local function PrintResult(name, success)
    if success then
        print(string.format("[+] %s", name))
    else
        print(string.format("[-] %s", name))
    end
end

local function Test(name, func)
    local success, err = pcall(func)
    PrintResult(name, success)

    if not success then
        print(err)
    end
end

--[[ Math Tests ]]
BeginSection("Math Tests")
local math = lnxLib.Utils.Math

-- Test NormalizeAngle
Test("NormalizeAngle does not change 180", function()
    local angle = math.NormalizeAngle(180)
    lu.assertEquals(angle, 180)
end)

-- Test RemapValClamped
Test("RemapValClamped maps 0 to 0", function()
    local remap = math.RemapValClamped(0, 0, 1, 0, 1)
    lu.assertEquals(remap, 0)
end)

-- Test PositionAngles
Test("PositionAngles between the same vectors is 0", function()
    local angles = math.PositionAngles(Vector3(0, 0, 0), Vector3(0, 0, 0))
    lu.assertEquals(angles, EulerAngles(0, 0, 0))
end)

-- Test AngleFov
Test("AngleFov between the same vectors is 0", function()
    local fov = math.AngleFov(EulerAngles(0, 0, 0), EulerAngles(0, 0, 0))
    lu.assertEquals(fov, 0)
end)

--[[ Conversion Tests ]]
BeginSection("Conversion Tests")
local conversion = lnxLib.Utils.Conversion

-- Test ID3_to_ID64 (As integer)
Test("ID3_to_ID64 converts a valid ID3 (Integer) to ID64", function()
    local id64 = conversion.ID3_to_ID64(123456789)
    lu.assertEquals(tostring(id64), "76561198083722517")
end)

-- Test ID3_to_ID64 (As string)
Test("ID3_to_ID64 converts a valid ID3 (String) to ID64", function()
    local id64 = conversion.ID3_to_ID64("[U:1:123456789]")
    lu.assertEquals(tostring(id64), "76561198083722517")
end)

-- Test ID64_to_ID3
Test("ID64_to_ID3 converts a valid ID64 to ID3", function()
    local id3 = conversion.ID64_to_ID3(76561198083722517)
    lu.assertEquals(id3, "[U:1:123456789]")
end)

-- Test Hex_to_RGB
Test("Hex_to_RGB converts a valid hex to RGB", function()
    local r, g, b = conversion.Hex_to_RGB("41fa05")
    lu.assertEquals(r, 65)
    lu.assertEquals(g, 250)
    lu.assertEquals(b, 5)
end)

-- Test RGB_to_Hex
Test("RGB_to_Hex converts a valid RGB to hex", function()
    local hex = conversion.RGB_to_Hex(20, 70, 180)
    lu.assertEquals(hex, "1446b4")
end)

--[[ Callback Tests ]]
BeginSection("Callback Tests")

-- CreateMove
Test("CreateMove callback is called", function()
    local userCmd = Mockagne.getMock("UserCmd")
    mockAPI:InvokeCallback("CreateMove", userCmd)
end)

-- Draw
Test("Draw callback is called", function()
    mockAPI:InvokeCallback("Draw")
end)

--[[ Globals Tests ]]

Test("Globals are correct", function ()
    local userCmd = Mockagne.getMock("UserCmd")

    userCmd.command_number = 1
    mockAPI:InvokeCallback("CreateMove", userCmd)

    userCmd.command_number = 2
    mockAPI:InvokeCallback("CreateMove", userCmd)

    lu.assertEquals(lnxLib.TF2.Globals.CommandNumber, 2)
    lu.assertEquals(lnxLib.TF2.Globals.LastCommandNumber, 1)
end)
