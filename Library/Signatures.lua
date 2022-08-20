--[[
    Lmaobox Signatures for EmmyLua/Luanalysis
    DO NOT INCLUDE THESE WHEN RELEASING!
]]

print("You tried to run the Signatures file. This was a very bad idea!")
do return end

---@param r number
---@param g number
---@param b number
---@param a number
---@param msg string
function printc(r, g, b, a, msg, ...) end

---@param scriptFile string
function LoadScript(scriptFile) end

---@param scriptFile string
function UnloadScript(scriptFile) end

---@return string
function GetScriptName() return nil end

---[[ EulerAngles ]]
---@class EulerAngles
---@field x number
---@field y number
---@field z number
local EulerAngles = { }

---@param pitch number
---@param yaw number
---@param roll number
---@return EulerAngles
function EulerAngles(pitch, yaw, roll) return nil end

---@return table<number>
function EulerAngles:Unpack() return nil end

function EulerAngles:Clear() end

function EulerAngles:Normalize() end

---@return Vector3
function EulerAngles:Forward() return nil end

---@return Vector3
function EulerAngles:Right() return nil end

---@return Vector3
function EulerAngles:Up() return nil end

--[[ Vector3 ]]
---@class Vector3
---@field x number
---@field y number
---@field z number
local Vector3 = { }

---@overload fun(x: number, y: number, z: number)
---@return Vector3
function Vector3() return nil end

---@return table<number>
function Vector3:Unpack() return nil end

---@return number
function Vector3:Length() return nil end

---@return number
function Vector3:LengthSqr() return nil end

---@return number
function Vector3:Length2D() return nil end

---@return number
function Vector3:Length2DSqr() return nil end

---@param vec Vector3
---@return number
function Vector3:Dot(vec) return nil end

---@param vec Vector3
---@return Vector3
function Vector3:Cross(vec) return nil end

function Vector3:Clear() return nil end

function Vector3:Normalize() return nil end

---@return Vector3
function Vector3:Right() return nil end

---@return Vector3
function Vector3:Up() return nil end

---@return EulerAngles
function Vector3:Angles() return nil end

---[[ Trace ]]
---@class Trace
---@field fraction number
---@field entity Entity
---@field plane Vector3
---@field contents number
---@field hitbox number
---@field hitgroup number
---@field allsolid boolean
---@field startsolid boolean
---@field startpos Vector3
---@field endpos Vector3
local Trace = {}

--[[ UserCmd ]]
---@class UserCmd
---@field command_number number
---@field tick_count number
---@field viewangles EulerAngles
---@field forwardmove number
---@field sidemove number
---@field upmove number
---@field buttons number
---@field impulse number
---@field weaponselect number
---@field weaponsubtype number
---@field random_seed number
---@field mousedx number
---@field mousedy number
---@field hasbeenpredicted boolean
---@field sendpacket boolean
local UserCmd = { }

---@param pitch
---@param yaw
---@param roll
function UserCmd:SetViewAngles(pitch, yaw, roll) end

---@return table<number>
function UserCmd:GetViewAngles() return nil end

---@param sendPacket boolean
function UserCmd:SetSendPacket(sendPacket) end

---@return boolean
function UserCmd:GetSendPacket() return nil end

---@param buttons number
function UserCmd:SetButtons(buttons) end

---@return number
function UserCmd:GetButtons() return nil end

---@param factor number
function UserCmd:SetForwardMove(factor) end

---@return number
function UserCmd:GetForwardMove() return nil end

---@param factor number
function UserCmd:SetSideMove(factor) end

---@return number
function UserCmd:GetSideMove() return nil end

---@param factor number
function UserCmd:SetUpMove(factor) end

---@return number
function UserCmd:GetUpMove() return nil end

--[[ Entity ]]
---@class Entity
local Entity = { }

---@return boolean
function Entity:IsValid() return nil end

---@return string
function Entity:GetName() return nil end

---@return string
function Entity:GetClass() return nil end

---@return number
function Entity:GetIndex() return nil end

---@return number
function Entity:GetTeamNumber() return nil end

---@return Vector3
function Entity:GetAbsOrigin() return nil end

---@param vec Vector3
function Entity:SetAbsOrigin(vec) end

---@return boolean
function Entity:IsWeapon() return nil end

---@return boolean
function Entity:IsPlayer() return nil end

---@return Vector3[][]
function Entity:GetHitboxes() return { } end

-- Entity netvars/props

---@param prop string
---@return number
function Entity:GetPropFloat(prop, ...) return nil end

---@param prop string
---@return number
function Entity:GetPropInt(prop, ...) return nil end

---@param prop string
---@return boolean
function Entity:GetPropBool(prop, ...) return nil end

---@param prop string
---@return string
function Entity:GetPropString(prop, ...) return nil end

---@param prop string
---@return Vector3
function Entity:GetPropVector(prop, ...) return nil end

---@param prop string
---@return Entity
function Entity:GetPropEntity(prop, ...) return nil end

-- Prop Data Tables

---@param prop string
---@return number[]
function Entity:GetPropDataTableFloat(prop, ...) return nil end

---@param prop string
---@return number[]
function Entity:GetPropDataTableInt(prop, ...) return nil end

---@param prop string
---@return Entity[]
function Entity:GetPropDataTableEntity(prop, ...) return nil end

-- Player entity methods

-- Weapon entity methods

---@return boolean
function Entity:IsShootingWeapon() return nil end

---@return boolean
function Entity:IsMeleeWeapon() return nil end

---@return boolean
function Entity:IsMedigun() return nil end

---@return boolean
function Entity:CanRandomCrit() return nil end

-- Melee Weapon Methods

-- Medigun methods

-- Weapon Crit Methods

---@return number
function Entity:GetCritTokenBucket() return nil end

--[[ Callbacks ]]
---@class callbacks
callbacks = { }

---@overload fun(id: string, callback: function)
---@overload fun(id: string, unique: string, callback: function)
function callbacks.Register(id, callback) end

---@param id string
---@param unique string
function callbacks.Unregister(id, unique) end

--[[ Draw ]]
---@class draw
draw = { }

---@param r number
---@param g number
---@param b number
---@param a number
function draw.Color(r, g, b, a) end

---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
function draw.Line(x1, y1, x2, y2) end

---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
function draw.FilledRect(x1, y1, x2, y2) end

---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
function draw.OutlinedRect(x1, y1, x2, y2) end

---@param text string
---@return number, number
function draw.GetTextSize(text) return nil end

---@param x number
---@param y number
---@param text string
function draw.Text(x, y, text) end

---@overload fun(name: string, height: number, weight: number)
---@overload fun(name: string, height: number, weight: number, fontFlags: number)
---@return number
function draw.CreateFont(name, height, weight) return nil end

---@param pathTTF string
function draw.AddFontResource(pathTTF) end

---@param font number
function draw.SetFont(font) end

--[[ Entities ]]
---@class entities
entities = { }

---@param class string
---@return Entity[]
function entities.FindByClass(class) return { } end

---@return Entity
function entities.GetLocalPlayer() return nil end

---@param index number
---@return Entity
function entities.GetByIndex(index) return nil end

---@param userID number
---@return Entity
function entities.GetByUserID(userID) return nil end

---@return Entity
function entities.GetPlayerResources() return nil end

--[[ FileSystem ]]
---@class filesystem
filesystem = { }

---@param path string
---@return boolean
function filesystem.CreateDirectory(path) return nil end

---@param path string
---@param callback fun(filename: string, attributes: number)
function filesystem.EnumerateDirectory(path, callback) end

---@param path string
---@return table
function filesystem.GetFileAttributes(path) return nil end

---@param path string
---@param attributes number
function filesystem.SetFileAttributes(path, attributes) end

--[[ Globals ]]
---@class globals
globals = { }

---@return number
function globals.TickInterval() return nil end

---@return number
function globals.TickCount() return nil end

---@return number
function globals.RealTime() return nil end

---@return number
function globals.CurTime() return nil end

---@return number
function globals.FrameCount() return nil end

---@return number
function globals.FrameTime() return nil end

---@return number
function globals.AbsoluteFrameTime() return nil end

---@return number
function globals.MaxClients() return nil end

--[[ Steam ]]
---@class steam
steam = { }

---@return string
function steam.GetSteamID() return nil end

---@return string
function steam.GetPlayerName() return nil end

---@param steamid string
---@return boolean
function steam.IsFriend(steamid) return nil end

---@return table<string>
function steam.GetFriends() return nil end

---@param steamid string
---@return number
function steam.ToSteamID64(steamid) return nil end