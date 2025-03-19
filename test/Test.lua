package.path = package.path .. ";../?.lua;MockApi/?.lua"

local lu = require("luaunit")
local mockAPI = require("MockApi.MockAPI.MockAPI")

-- Mock required functions
Mockagne.when(engine.GetGameDir()).thenAnswer("Test")
Mockagne.when(globals.RealTime()).thenAnswer(0)

---@type LmaoLib
local lib = require("build/out/LmaoLib")
print("Testing LmaoLib version: " .. lib.version())

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

--[[ Key Values Tests]]
BeginSection("Key Values Tests")
local keyvalues = lib.utils.kv

Test("Serialize empty table", function()
    local kv = keyvalues.serialize("Test", {})
    lu.assertEquals(kv, "\"Test\"\n{\n\n}")
end)

Test("Serialize simple table", function()
    local kv = keyvalues.serialize("Test", {
        ["a"] = "one"
    })
    lu.assertEquals(kv, "\"Test\"\n{\n\t\"a\"\t\"one\"\n}")
end)

Test("Deserialize empty table", function ()
    local kv = "\"Test\"\n{\n\n}"
    local name, data = keyvalues.deserialize(kv)
    lu.assertEquals(name, "Test")
    lu.assertEquals(data, {})
end)

Test("Deserialize simple table", function ()
    local kv = "\"Test\"\n{\n\t\"a\"\t\"one\"\n}"
    local name, data = keyvalues.deserialize(kv)
    lu.assertEquals(name, "Test")
    lu.assertEquals(data, {
        ["a"] = "one"
    })
end)

Test("Serialize and Deserialize", function ()
    local name = "Test"
    local data = {
        ["a"] = "one",
        ["b"] = "two",
        ["c"] = "three"
    }

    local kv = keyvalues.serialize(name, data)
    local name2, data2 = keyvalues.deserialize(kv)

    lu.assertEquals(name, name2)
    lu.assertEquals(data, data2)
end)

--[[ Math Tests ]]
BeginSection("Math Tests")
local mathx = lib.utils.mathx

-- Test NormalizeAngle
Test("NormalizeAngle does not change 180", function()
    local angle = mathx.norm_angle(180)
    lu.assertEquals(angle, 180)
end)

-- Test RemapValClamped
Test("RemapValClamped maps 0 to 0", function()
    local remap = mathx.remap_clamp(0, 0, 1, 0, 1)
    lu.assertEquals(remap, 0)
end)

-- Test PositionAngles
Test("PositionAngles between the same vectors is 0", function()
    local angles = mathx.vec_angle(Vector3(0, 0, 0), Vector3(0, 0, 0))
    lu.assertEquals(angles, EulerAngles(0, 0, 0))
end)

-- Test AngleFov
Test("AngleFov between the same vectors is 0", function()
    local fov = mathx.angle_fov(EulerAngles(0, 0, 0), EulerAngles(0, 0, 0))
    lu.assertEquals(fov, 0)
end)

--[[ Conversion Tests ]]
BeginSection("Conversion Tests")
local conversion = lib.utils.conversion

-- Test ID3_to_ID64 (As integer)
Test("ID3_to_ID64 converts a valid ID3 (Integer) to ID64", function()
    local id64 = conversion.id3_to_id64(123456789)
    lu.assertEquals(tostring(id64), "76561198083722517")
end)

-- Test ID3_to_ID64 (As string)
Test("ID3_to_ID64 converts a valid ID3 (String) to ID64", function()
    local id64 = conversion.id3_to_id64("[U:1:123456789]")
    lu.assertEquals(tostring(id64), "76561198083722517")
end)

-- Test ID64_to_ID3
Test("ID64_to_ID3 converts a valid ID64 to ID3", function()
    local id3 = conversion.id64_to_id3(76561198083722517)
    lu.assertEquals(id3, "[U:1:123456789]")
end)

-- Test Hex_to_RGB
Test("Hex_to_RGB converts a valid hex to RGB", function()
    local r, g, b = conversion.hex_to_rgb("41fa05")
    lu.assertEquals(r, 65)
    lu.assertEquals(g, 250)
    lu.assertEquals(b, 5)
end)

-- Test RGB_to_Hex
Test("RGB_to_Hex converts a valid RGB to hex", function()
    local hex = conversion.rgb_to_hex(20, 70, 180)
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

--[[ EntityUtils Tests ]]
BeginSection("EntityUtils Tests")

-- Extrapolate
Test("Extrapolate is correct", function ()
    -- Arrange
    local entity = Mockagne.getMock("Entity")
    Mockagne.when(entity:GetAbsOrigin()).thenAnswer(Vector3(3, 2, 1))
    Mockagne.when(entity:EstimateAbsVelocity()).thenAnswer(Vector3(1, 2, 3))

    -- Act
    local result = lib.tf2.entityutil.extrapolate(entity, 2)

    -- Assert
    lu.assertEquals(result, Vector3(5, 6, 7))
end)

-- Equals
Test("Equals is correct", function ()
    -- Arrange
    local entity1 = Mockagne.getMock("Entity")
    Mockagne.when(entity1:GetIndex()).thenAnswer(1)

    local entity2 = Mockagne.getMock("Entity")
    Mockagne.when(entity2:GetIndex()).thenAnswer(1)

    -- Act
    local result = lib.tf2.entityutil.equals(entity1, entity2)

    -- Assert
    lu.assertTrue(result)
end)
