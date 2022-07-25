--[[
    Lmaobox Signatures for EmmyLua/Luanalysis
    DO NOT INCLUDE THESE WHEN RELEASING!
]]

print("You tried to run the Signatures file. This was a very bad idea!")
do return end

--[[ Vector3 ]]
---@class Vector3
---@field x number
---@field y number
---@field z number
local Vector3 = { }

---[[ EulerAngles ]]
---@class EulerAngles
---@field x number
---@field y number
---@field z number
local EulerAngles = { }

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
---@field public command_number number
---@field public tick_count number
---@field public viewangles EulerAngles
---@field public forwardmove number
---@field public sidemove number
---@field public upmove number
---@field public buttons number
---@field public impulse number
---@field public weaponselect number
---@field public weaponsubtype number
---@field public random_seed number
---@field public mousedx number
---@field public mousedy number
---@field public hasbeenpredicted boolean
---@field public sendpacket boolean
local UserCmd = { }

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

---@return boolean
function Entity:IsWeapon() return nil end

---@return boolean
function Entity:IsPlayer() return nil end

---@return Vector3[][]
function Entity:GetHitboxes() return { } end

-- Entity netvars/props

-- Prop Data Tables

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

---@param id string
---@param callback function
function callbacks.Register(id, callback) end

---@param id string
---@param unique string
---@param callback function
function callbacks.Register(id, unique, callback) end

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

--[[ Steam ]]
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