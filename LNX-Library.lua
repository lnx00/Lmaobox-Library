local __bundle_require, __bundle_loaded, __bundle_register, __bundle_modules = (function(superRequire)
	local loadingPlaceholder = {[{}] = true}

	local register
	local modules = {}

	local require
	local loaded = {}

	register = function(name, body)
		if not modules[name] then
			modules[name] = body
		end
	end

	require = function(name)
		local loadedModule = loaded[name]

		if loadedModule then
			if loadedModule == loadingPlaceholder then
				return nil
			end
		else
			if not modules[name] then
				if not superRequire then
					local identifier = type(name) == 'string' and '\"' .. name .. '\"' or tostring(name)
					error('Tried to require ' .. identifier .. ', but no such module has been registered')
				else
					return superRequire(name)
				end
			end

			loaded[name] = loadingPlaceholder
			loadedModule = modules[name](require, loaded, register, modules)
			loaded[name] = loadedModule
		end

		return loadedModule
	end

	return require, loaded, register, modules
end)(require)
__bundle_register("__root", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[ Globals ]]

-- Get the current folder for relative require
LIB_PATH = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
require("Library/Extensions")

--[[ Main ]]

---@class Main
---@field public TF2 TF2
---@field public UI UI
local Main = {
    TF2 = require("Library/TF2/TF2"),
    UI = require("Library/UI/UI"),
    Utils = require("Library/Utils/Utils"),
    Enums = require("Library/Enums"),
}

---@return number
function Main.GetVersion()
    return 0.2
end

--[[ Callbacks ]]

---@param userCmd UserCmd
local function OnCreateMove(userCmd)
    Main.TF2._OnCreateMove(userCmd)
end

local function OnDraw()
    Main.TF2._OnDraw()
    Main.UI._OnDraw()
end

callbacks.Unregister("CreateMove", "LBL_CreateMove")
callbacks.Register("CreateMove", "LBL_CreateMove", OnCreateMove)

callbacks.Unregister("Draw", "LBL_Draw")
callbacks.Register("Draw", "LBL_Draw", OnDraw)

--[[ Debugging ]]

-- Unloads the entire library. Useful for debugging
function UnloadLib()
    -- Unload unbundles files
    for name, pck in pairs(package.loaded) do
        if name:find("Lmaobox-Library", 1, true) then
            printc(195, 55, 20, 255, "Unloading: " .. name)
            package.loaded[name] = nil
        end
    end

    -- Unload bundle
    package.loaded['LNX-Library'] = nil

    printc(230, 65, 25, 255, "Lmaobox-Library unloaded.")
end

-- Library loaded
printc(75, 210, 55, 255, "Lmaobox-Library v" .. Main.GetVersion() .. " loaded.")
Main.UI.Notify.Simple("Library Loaded", "Version: " .. Main.GetVersion())

return Main
end)
__bundle_register("Library/Enums", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Enums
]]

---@class Enums
local Enums = { }

--[[ Generic Enums ]]

-- File Attributes
Enums.FileAttribute = {
    FILE_ATTRIBUTE_ARCHIVE = 0x20,
    FILE_ATTRIBUTE_COMPRESSED = 0x800,
    FILE_ATTRIBUTE_DEVICE = 0x40,
    FILE_ATTRIBUTE_DIRECTORY = 0x10,
    FILE_ATTRIBUTE_ENCRYPTED = 0x4000,
    FILE_ATTRIBUTE_HIDDEN = 0x2,
    FILE_ATTRIBUTE_INTEGRITY_STREAM = 0x8000,
    FILE_ATTRIBUTE_NORMAL = 0x80,
    FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = 0x2000,
    FILE_ATTRIBUTE_NO_SCRUB_DATA = 0x20000,
    FILE_ATTRIBUTE_OFFLINE = 0x1000,
    FILE_ATTRIBUTE_READONLY = 0x1,
    FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS = 0x400000,
    FILE_ATTRIBUTE_RECALL_ON_OPEN = 0x40000,
    FILE_ATTRIBUTE_REPARSE_POINT = 0x400,
    FILE_ATTRIBUTE_SPARSE_FILE = 0x200,
    FILE_ATTRIBUTE_SYSTEM = 0x4,
    FILE_ATTRIBUTE_TEMPORARY = 0x100,
    FILE_ATTRIBUTE_VIRTUAL = 0x10000,
    FILE_ATTRIBUTE_PINNED = 0x80000,
    FILE_ATTRIBUTE_UNPINNED = 0x100000,
    INVALID_FILE_ATTRIBUTES = 0xFFFFFFFF
}

Enums.HexColor = {
    Red = 0xFF0000,
    Green = 0x00FF00,
    Blue = 0x0000FF,
    Yellow = 0xFFFF00,
    Cyan = 0x00FFFF,
    Magenta = 0xFF00FF,
    White = 0xFFFFFF,
    Black = 0x000000,
    Orange = 0xFFA500,
    Brown = 0xA52A2A,
    Gray = 0x808080,
}

--[[ TF2 Enums ]]

Enums.ObserverMode = {
    None = 0,
    Deathcam = 1,
    FreezeCam = 2,
    Fixed = 3,
    FirstPerson = 4,
    ThirdPerson = 5,
    PointOfInterest = 6,
    FreeRoaming = 7
}

Enums.SignonState = {
    None = 0,
    Challenge = 1,
    Connected = 2,
    New = 3,
    Prespawn = 4,
    Spawn = 5,
    Full = 6,
    ChangeLevel = 7
}

return Enums
end)
__bundle_register("Library/Utils/Utils", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class Utils
local Utils = {
    Conversion = require("Library/Utils/Conversion"),
    IO = require("Library/Utils/IO"),
    Misc = require("Library/Utils/Misc"),
    KeyHelper = require("Library/Utils/KeyHelper"),
    Timer = require("Library/Utils/Timer"),
    Config = require("Library/Utils/Config"),
}

return Utils
end)
__bundle_register("Library/Utils/Config", function(require, _LOADED, __bundle_register, __bundle_modules)
---@type IO
local IO = require("Library/Utils/IO")

---@type Json
local Json = require("Library/Libs/dkjson")

---@class Config
---@field private _Name string
---@field private _Content table
---@field public AutoSave boolean
---@field public AutoLoad boolean
local Config = {
    _Name = "",
    _Content = { },
    AutoSave = true,
    AutoLoad = false
}
Config.__index = Config
setmetatable(Config, Config)

local ConfigExtension = ".cfg"
local ConfigFolder = IO.GetWorkDir() .. "/Configs/"

---@return Config
function Config.new(name)
    ---@type self
    local self = setmetatable({ }, Config)
    self._Name = name
    self._Content = { }
    self.AutoSave = true
    self.AutoLoad = false

    self:Load()

    return self
end

---@return string
function Config:GetPath()
    if not IO.Exists(ConfigFolder) then
        filesystem.CreateDirectory(ConfigFolder)
    end

    return ConfigFolder .. self._Name .. ConfigExtension
end

function Config:Load()
    local configPath = self:GetPath()
    if not IO.Exists(configPath) then return end

    local content = IO.ReadFile(self:GetPath())
    self._Content = Json.decode(content, 1, nil)
end

function Config:Delete()
    local configPath = self:GetPath()
    if not IO.Exists(configPath) then return end

    IO.DeleteFile(configPath)
    self._Content = { }
end

function Config:Save()
    local content = Json.encode(self._Content, { indent = true })
    IO.WriteFile(self:GetPath(), content)
end

---@param key string
---@param value any
function Config:SetValue(key, value)
    if self.AutoLoad then self:Load() end
    self._Content[key] = value
    if self.AutoSave then self:Save() end
end

---@generic T
---@param key string
---@param default T
---@return T
function Config:GetValue(key, default)
    if self.AutoLoad then self:Load() end
    local value =  self._Content[key]
    if value == nil then return default end

    return value
end

return Config
end)
__bundle_register("Library/Libs/dkjson", function(require, _LOADED, __bundle_register, __bundle_modules)
-- Module options:
local register_global_module_table = false
local global_module_name = 'json'

--[==[

David Kolf's JSON module for Lua 5.1 - 5.4

Version 2.6


For the documentation see the corresponding readme.txt or visit
<http://dkolf.de/src/dkjson-lua.fsl/>.

You can contact the author by sending an e-mail to 'david' at the
domain 'dkolf.de'.


Copyright (C) 2010-2021 David Heiko Kolf

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

--]==]

-- global dependencies:
local pairs, type, tostring, tonumber, getmetatable, setmetatable, rawset =
      pairs, type, tostring, tonumber, getmetatable, setmetatable, rawset
local error, require, pcall, select = error, require, pcall, select
local floor, huge = math.floor, math.huge
local strrep, gsub, strsub, strbyte, strchar, strfind, strlen, strformat =
      string.rep, string.gsub, string.sub, string.byte, string.char,
      string.find, string.len, string.format
local strmatch = string.match
local concat = table.concat

---@class Json
local json = { version = "dkjson 2.6" }

local jsonlpeg = {}

if register_global_module_table then
  _G[global_module_name] = json
end

local _ENV = nil -- blocking globals in Lua 5.2 and later

pcall (function()
  -- Enable access to blocked metatables.
  -- Don't worry, this module doesn't change anything in them.
  --local debmeta = require "debug".getmetatable
  --if debmeta then getmetatable = debmeta end
end)

json.null = setmetatable ({}, {
  __tojson = function () return "null" end
})

local function isarray (tbl)
  local max, n, arraylen = 0, 0, 0
  for k,v in pairs (tbl) do
    if k == 'n' and type(v) == 'number' then
      arraylen = v
      if v > max then
        max = v
      end
    else
      if type(k) ~= 'number' or k < 1 or floor(k) ~= k then
        return false
      end
      if k > max then
        max = k
      end
      n = n + 1
    end
  end
  if max > 10 and max > arraylen and max > n * 2 then
    return false -- don't create an array with too many holes
  end
  return true, max
end

local escapecodes = {
  ["\""] = "\\\"", ["\\"] = "\\\\", ["\b"] = "\\b", ["\f"] = "\\f",
  ["\n"] = "\\n",  ["\r"] = "\\r",  ["\t"] = "\\t"
}

local function escapeutf8 (uchar)
  local value = escapecodes[uchar]
  if value then
    return value
  end
  local a, b, c, d = strbyte (uchar, 1, 4)
  a, b, c, d = a or 0, b or 0, c or 0, d or 0
  if a <= 0x7f then
    value = a
  elseif 0xc0 <= a and a <= 0xdf and b >= 0x80 then
    value = (a - 0xc0) * 0x40 + b - 0x80
  elseif 0xe0 <= a and a <= 0xef and b >= 0x80 and c >= 0x80 then
    value = ((a - 0xe0) * 0x40 + b - 0x80) * 0x40 + c - 0x80
  elseif 0xf0 <= a and a <= 0xf7 and b >= 0x80 and c >= 0x80 and d >= 0x80 then
    value = (((a - 0xf0) * 0x40 + b - 0x80) * 0x40 + c - 0x80) * 0x40 + d - 0x80
  else
    return ""
  end
  if value <= 0xffff then
    return strformat ("\\u%.4x", value)
  elseif value <= 0x10ffff then
    -- encode as UTF-16 surrogate pair
    value = value - 0x10000
    local highsur, lowsur = 0xD800 + floor (value/0x400), 0xDC00 + (value % 0x400)
    return strformat ("\\u%.4x\\u%.4x", highsur, lowsur)
  else
    return ""
  end
end

local function fsub (str, pattern, repl)
  -- gsub always builds a new string in a buffer, even when no match
  -- exists. First using find should be more efficient when most strings
  -- don't contain the pattern.
  if strfind (str, pattern) then
    return gsub (str, pattern, repl)
  else
    return str
  end
end

local function quotestring (value)
  -- based on the regexp "escapable" in https://github.com/douglascrockford/JSON-js
  value = fsub (value, "[%z\1-\31\"\\\127]", escapeutf8)
  if strfind (value, "[\194\216\220\225\226\239]") then
    value = fsub (value, "\194[\128-\159\173]", escapeutf8)
    value = fsub (value, "\216[\128-\132]", escapeutf8)
    value = fsub (value, "\220\143", escapeutf8)
    value = fsub (value, "\225\158[\180\181]", escapeutf8)
    value = fsub (value, "\226\128[\140-\143\168-\175]", escapeutf8)
    value = fsub (value, "\226\129[\160-\175]", escapeutf8)
    value = fsub (value, "\239\187\191", escapeutf8)
    value = fsub (value, "\239\191[\176-\191]", escapeutf8)
  end
  return "\"" .. value .. "\""
end
json.quotestring = quotestring

local function replace(str, o, n)
  local i, j = strfind (str, o, 1, true)
  if i then
    return strsub(str, 1, i-1) .. n .. strsub(str, j+1, -1)
  else
    return str
  end
end

-- locale independent num2str and str2num functions
local decpoint, numfilter

local function updatedecpoint ()
  decpoint = strmatch(tostring(0.5), "([^05+])")
  -- build a filter that can be used to remove group separators
  numfilter = "[^0-9%-%+eE" .. gsub(decpoint, "[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0") .. "]+"
end

updatedecpoint()

local function num2str (num)
  return replace(fsub(tostring(num), numfilter, ""), decpoint, ".")
end

local function str2num (str)
  local num = tonumber(replace(str, ".", decpoint))
  if not num then
    updatedecpoint()
    num = tonumber(replace(str, ".", decpoint))
  end
  return num
end

local function addnewline2 (level, buffer, buflen)
  buffer[buflen+1] = "\n"
  buffer[buflen+2] = strrep ("  ", level)
  buflen = buflen + 2
  return buflen
end

function json.addnewline (state)
  if state.indent then
    state.bufferlen = addnewline2 (state.level or 0,
                           state.buffer, state.bufferlen or #(state.buffer))
  end
end

local encode2 -- forward declaration

local function addpair (key, value, prev, indent, level, buffer, buflen, tables, globalorder, state)
  local kt = type (key)
  if kt ~= 'string' and kt ~= 'number' then
    return nil, "type '" .. kt .. "' is not supported as a key by JSON."
  end
  if prev then
    buflen = buflen + 1
    buffer[buflen] = ","
  end
  if indent then
    buflen = addnewline2 (level, buffer, buflen)
  end
  buffer[buflen+1] = quotestring (key)
  buffer[buflen+2] = ":"
  return encode2 (value, indent, level, buffer, buflen + 2, tables, globalorder, state)
end

local function appendcustom(res, buffer, state)
  local buflen = state.bufferlen
  if type (res) == 'string' then
    buflen = buflen + 1
    buffer[buflen] = res
  end
  return buflen
end

local function exception(reason, value, state, buffer, buflen, defaultmessage)
  defaultmessage = defaultmessage or reason
  local handler = state.exception
  if not handler then
    return nil, defaultmessage
  else
    state.bufferlen = buflen
    local ret, msg = handler (reason, value, state, defaultmessage)
    if not ret then return nil, msg or defaultmessage end
    return appendcustom(ret, buffer, state)
  end
end

function json.encodeexception(reason, value, state, defaultmessage)
  return quotestring("<" .. defaultmessage .. ">")
end

encode2 = function (value, indent, level, buffer, buflen, tables, globalorder, state)
  local valtype = type (value)
  local valmeta = getmetatable (value)
  valmeta = type (valmeta) == 'table' and valmeta -- only tables
  local valtojson = valmeta and valmeta.__tojson
  if valtojson then
    if tables[value] then
      return exception('reference cycle', value, state, buffer, buflen)
    end
    tables[value] = true
    state.bufferlen = buflen
    local ret, msg = valtojson (value, state)
    if not ret then return exception('custom encoder failed', value, state, buffer, buflen, msg) end
    tables[value] = nil
    buflen = appendcustom(ret, buffer, state)
  elseif value == nil then
    buflen = buflen + 1
    buffer[buflen] = "null"
  elseif valtype == 'number' then
    local s
    if value ~= value or value >= huge or -value >= huge then
      -- This is the behaviour of the original JSON implementation.
      s = "null"
    else
      s = num2str (value)
    end
    buflen = buflen + 1
    buffer[buflen] = s
  elseif valtype == 'boolean' then
    buflen = buflen + 1
    buffer[buflen] = value and "true" or "false"
  elseif valtype == 'string' then
    buflen = buflen + 1
    buffer[buflen] = quotestring (value)
  elseif valtype == 'table' then
    if tables[value] then
      return exception('reference cycle', value, state, buffer, buflen)
    end
    tables[value] = true
    level = level + 1
    local isa, n = isarray (value)
    if n == 0 and valmeta and valmeta.__jsontype == 'object' then
      isa = false
    end
    local msg
    if isa then -- JSON array
      buflen = buflen + 1
      buffer[buflen] = "["
      for i = 1, n do
        buflen, msg = encode2 (value[i], indent, level, buffer, buflen, tables, globalorder, state)
        if not buflen then return nil, msg end
        if i < n then
          buflen = buflen + 1
          buffer[buflen] = ","
        end
      end
      buflen = buflen + 1
      buffer[buflen] = "]"
    else -- JSON object
      local prev = false
      buflen = buflen + 1
      buffer[buflen] = "{"
      local order = valmeta and valmeta.__jsonorder or globalorder
      if order then
        local used = {}
        n = #order
        for i = 1, n do
          local k = order[i]
          local v = value[k]
          if v ~= nil then
            used[k] = true
            buflen, msg = addpair (k, v, prev, indent, level, buffer, buflen, tables, globalorder, state)
            prev = true -- add a seperator before the next element
          end
        end
        for k,v in pairs (value) do
          if not used[k] then
            buflen, msg = addpair (k, v, prev, indent, level, buffer, buflen, tables, globalorder, state)
            if not buflen then return nil, msg end
            prev = true -- add a seperator before the next element
          end
        end
      else -- unordered
        for k,v in pairs (value) do
          buflen, msg = addpair (k, v, prev, indent, level, buffer, buflen, tables, globalorder, state)
          if not buflen then return nil, msg end
          prev = true -- add a seperator before the next element
        end
      end
      if indent then
        buflen = addnewline2 (level - 1, buffer, buflen)
      end
      buflen = buflen + 1
      buffer[buflen] = "}"
    end
    tables[value] = nil
  else
    return exception ('unsupported type', value, state, buffer, buflen,
      "type '" .. valtype .. "' is not supported by JSON.")
  end
  return buflen
end

function json.encode (value, state)
  state = state or {}
  local oldbuffer = state.buffer
  local buffer = oldbuffer or {}
  state.buffer = buffer
  updatedecpoint()
  local ret, msg = encode2 (value, state.indent, state.level or 0,
                   buffer, state.bufferlen or 0, state.tables or {}, state.keyorder, state)
  if not ret then
    error (msg, 2)
  elseif oldbuffer == buffer then
    state.bufferlen = ret
    return true
  else
    state.bufferlen = nil
    state.buffer = nil
    return concat (buffer)
  end
end

local function loc (str, where)
  local line, pos, linepos = 1, 1, 0
  while true do
    pos = strfind (str, "\n", pos, true)
    if pos and pos < where then
      line = line + 1
      linepos = pos
      pos = pos + 1
    else
      break
    end
  end
  return "line " .. line .. ", column " .. (where - linepos)
end

local function unterminated (str, what, where)
  return nil, strlen (str) + 1, "unterminated " .. what .. " at " .. loc (str, where)
end

local function scanwhite (str, pos)
  while true do
    pos = strfind (str, "%S", pos)
    if not pos then return nil end
    local sub2 = strsub (str, pos, pos + 1)
    if sub2 == "\239\187" and strsub (str, pos + 2, pos + 2) == "\191" then
      -- UTF-8 Byte Order Mark
      pos = pos + 3
    elseif sub2 == "//" then
      pos = strfind (str, "[\n\r]", pos + 2)
      if not pos then return nil end
    elseif sub2 == "/*" then
      pos = strfind (str, "*/", pos + 2)
      if not pos then return nil end
      pos = pos + 2
    else
      return pos
    end
  end
end

local escapechars = {
  ["\""] = "\"", ["\\"] = "\\", ["/"] = "/", ["b"] = "\b", ["f"] = "\f",
  ["n"] = "\n", ["r"] = "\r", ["t"] = "\t"
}

local function unichar (value)
  if value < 0 then
    return nil
  elseif value <= 0x007f then
    return strchar (value)
  elseif value <= 0x07ff then
    return strchar (0xc0 + floor(value/0x40),
                    0x80 + (floor(value) % 0x40))
  elseif value <= 0xffff then
    return strchar (0xe0 + floor(value/0x1000),
                    0x80 + (floor(value/0x40) % 0x40),
                    0x80 + (floor(value) % 0x40))
  elseif value <= 0x10ffff then
    return strchar (0xf0 + floor(value/0x40000),
                    0x80 + (floor(value/0x1000) % 0x40),
                    0x80 + (floor(value/0x40) % 0x40),
                    0x80 + (floor(value) % 0x40))
  else
    return nil
  end
end

local function scanstring (str, pos)
  local lastpos = pos + 1
  local buffer, n = {}, 0
  while true do
    local nextpos = strfind (str, "[\"\\]", lastpos)
    if not nextpos then
      return unterminated (str, "string", pos)
    end
    if nextpos > lastpos then
      n = n + 1
      buffer[n] = strsub (str, lastpos, nextpos - 1)
    end
    if strsub (str, nextpos, nextpos) == "\"" then
      lastpos = nextpos + 1
      break
    else
      local escchar = strsub (str, nextpos + 1, nextpos + 1)
      local value
      if escchar == "u" then
        value = tonumber (strsub (str, nextpos + 2, nextpos + 5), 16)
        if value then
          local value2
          if 0xD800 <= value and value <= 0xDBff then
            -- we have the high surrogate of UTF-16. Check if there is a
            -- low surrogate escaped nearby to combine them.
            if strsub (str, nextpos + 6, nextpos + 7) == "\\u" then
              value2 = tonumber (strsub (str, nextpos + 8, nextpos + 11), 16)
              if value2 and 0xDC00 <= value2 and value2 <= 0xDFFF then
                value = (value - 0xD800)  * 0x400 + (value2 - 0xDC00) + 0x10000
              else
                value2 = nil -- in case it was out of range for a low surrogate
              end
            end
          end
          value = value and unichar (value)
          if value then
            if value2 then
              lastpos = nextpos + 12
            else
              lastpos = nextpos + 6
            end
          end
        end
      end
      if not value then
        value = escapechars[escchar] or escchar
        lastpos = nextpos + 2
      end
      n = n + 1
      buffer[n] = value
    end
  end
  if n == 1 then
    return buffer[1], lastpos
  elseif n > 1 then
    return concat (buffer), lastpos
  else
    return "", lastpos
  end
end

local scanvalue -- forward declaration

local function scantable (what, closechar, str, startpos, nullval, objectmeta, arraymeta)
  local len = strlen (str)
  local tbl, n = {}, 0
  local pos = startpos + 1
  if what == 'object' then
    setmetatable (tbl, objectmeta)
  else
    setmetatable (tbl, arraymeta)
  end
  while true do
    pos = scanwhite (str, pos)
    if not pos then return unterminated (str, what, startpos) end
    local char = strsub (str, pos, pos)
    if char == closechar then
      return tbl, pos + 1
    end
    local val1, err
    val1, pos, err = scanvalue (str, pos, nullval, objectmeta, arraymeta)
    if err then return nil, pos, err end
    pos = scanwhite (str, pos)
    if not pos then return unterminated (str, what, startpos) end
    char = strsub (str, pos, pos)
    if char == ":" then
      if val1 == nil then
        return nil, pos, "cannot use nil as table index (at " .. loc (str, pos) .. ")"
      end
      pos = scanwhite (str, pos + 1)
      if not pos then return unterminated (str, what, startpos) end
      local val2
      val2, pos, err = scanvalue (str, pos, nullval, objectmeta, arraymeta)
      if err then return nil, pos, err end
      tbl[val1] = val2
      pos = scanwhite (str, pos)
      if not pos then return unterminated (str, what, startpos) end
      char = strsub (str, pos, pos)
    else
      n = n + 1
      tbl[n] = val1
    end
    if char == "," then
      pos = pos + 1
    end
  end
end

scanvalue = function (str, pos, nullval, objectmeta, arraymeta)
  pos = pos or 1
  pos = scanwhite (str, pos)
  if not pos then
    return nil, strlen (str) + 1, "no valid JSON value (reached the end)"
  end
  local char = strsub (str, pos, pos)
  if char == "{" then
    return scantable ('object', "}", str, pos, nullval, objectmeta, arraymeta)
  elseif char == "[" then
    return scantable ('array', "]", str, pos, nullval, objectmeta, arraymeta)
  elseif char == "\"" then
    return scanstring (str, pos)
  else
    local pstart, pend = strfind (str, "^%-?[%d%.]+[eE]?[%+%-]?%d*", pos)
    if pstart then
      local number = str2num (strsub (str, pstart, pend))
      if number then
        return number, pend + 1
      end
    end
    pstart, pend = strfind (str, "^%a%w*", pos)
    if pstart then
      local name = strsub (str, pstart, pend)
      if name == "true" then
        return true, pend + 1
      elseif name == "false" then
        return false, pend + 1
      elseif name == "null" then
        return nullval, pend + 1
      end
    end
    return nil, pos, "no valid JSON value at " .. loc (str, pos)
  end
end

local function optionalmetatables(...)
  if select("#", ...) > 0 then
    return ...
  else
    return {__jsontype = 'object'}, {__jsontype = 'array'}
  end
end

function json.decode (str, pos, nullval, ...)
  local objectmeta, arraymeta = optionalmetatables(...)
  return scanvalue (str, pos, nullval, objectmeta, arraymeta)
end

return json


end)
__bundle_register("Library/Utils/IO", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Filesystem Utils
]]

---@class IO
local IO = { }
local WorkDir = engine.GetGameDir() .. "/../LNXF/"

-- Reads a file and returns its contents
---@param path string
---@return any
function IO.ReadFile(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

-- Writes the given content to the given file path
---@param path string
---@param content any
---@return boolean
function IO.WriteFile(path, content)
    local file = io.open(path, "wb") -- w write mode and b binary mode
    if not file then return false end
    file:write(content)
    file:close()
    return true
end

-- Deletes the file at the given path
---@param path string
function IO.DeleteFile(path)
    os.remove(path)
end

-- Returns whether the given file/directory exists
---@param path string
---@return boolean
function IO.Exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

-- Returns the working directory
---@return string
function IO.GetWorkDir()
    if not IO.Exists(WorkDir) then
        filesystem.CreateDirectory(WorkDir)
    end

    return WorkDir
end

return IO
end)
__bundle_register("Library/Utils/Timer", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class Timer
---@field private _LastTime number
local Timer = {
    _LastTime = 0
}
Timer.__index = Timer
setmetatable(Timer, Timer)

---@return Timer
function Timer.new()
    ---@type self
    local self = setmetatable({ }, Timer)
    self._LastTime = 0

    return self
end

---@param delta number
---@return boolean
function Timer:_Check(delta)
    return globals.CurTime() - self._LastTime >= delta
end

---@param interval number
---@return boolean
function Timer:Run(interval)
    if (self:_Check(interval)) then
        self._LastTime = globals.CurTime()
        return true
    end

    return false
end

return Timer
end)
__bundle_register("Library/Utils/KeyHelper", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class KeyHelper
---@field public Key number
---@field public _LastState boolean
local KeyHelper = {
    Key = 0,
    _LastState = false
}
KeyHelper.__index = KeyHelper
setmetatable(KeyHelper, KeyHelper)

---@param key number
---@return KeyHelper
function KeyHelper.FromKey(key)
    ---@type self
    local self = setmetatable({ }, KeyHelper)
    self.Key = key
    self._LastState = false

    return self
end

-- Is the button currently down?
---@return boolean
function KeyHelper:Down()
    local isDown = input.IsButtonDown(self.Key)
    self._LastState = isDown
    return isDown
end

-- Was the button just pressed? This will only be true once.
---@return boolean
function KeyHelper:Pressed()
    local shouldCheck = self._LastState == false
    return self:Down() and shouldCheck
end

-- Was the button just released? This will only be true once.
---@return boolean
function KeyHelper:Released()
    local shouldCheck = self._LastState == true
    return self:Down() == false and shouldCheck
end

return KeyHelper
end)
__bundle_register("Library/Utils/Misc", function(require, _LOADED, __bundle_register, __bundle_modules)
local Misc = { }

-- Sanitizes a given string
function Misc.Sanitize(str)
    str:gsub("%s", "")
    str:gsub("%%", "%%%%")
    return str
end

return Misc
end)
__bundle_register("Library/Utils/Conversion", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Conversion Utils
]]

local Conversion = { }

-- Converts a given SteamID 3 to SteamID 64 [Credits: Link2006]
function Conversion.ID3_to_ID64(steamID3)
    if not steamID3:match("(%[U:1:%d+%])") and not tonumber(steamID3) then
        return false, "Invalid SteamID"
    end

    if tonumber(steamID3) then
        -- XXX format
        return tostring(tonumber(steamID3) + 0x110000100000000)
    else
        -- [U:1:XXX] format
        return tostring(tonumber(steamID3:match("%[U:1:(%d+)%]")) + 0x110000100000000)
    end
end

-- Converts a given SteamID 64 to a SteamID 3 [Credits: Link2006]
function Conversion.ID64_to_ID3(steamID64)
    if not tonumber(steamID64) then
        return false, "Invalid SteamID"
    end

    steamID = tonumber(steamID64)
    if (steamID - 0x110000100000000) < 0 then
        return false, "Not a SteamID64"
    end

    return ("[U:1:%d]"):format(steamID - 0x110000100000000)
end

-- Converts a given Hex Color to RGB
---@param pHex string
---@return table<number>
function Conversion.Hex_to_RGB(pHex)
    local r = tonumber(string.sub(pHex, 1, 2), 16)
    local g = tonumber(string.sub(pHex, 3, 4), 16)
    local b = tonumber(string.sub(pHex, 5, 6), 16)
    return { r, g, b }
end

-- Converts a given RGB Color to Hex
---@param pRGB table<number>
---@return string
function Conversion.RGB_to_Hex(pRGB)
    local r = string.format("%x", pRGB[1])
    local g = string.format("%x", pRGB[2])
    local b = string.format("%x", pRGB[3])
    return r .. g .. b
end

-- Converts a given HSV Color to RGB
function Conversion.HSVtoRGB(h, s, v)
    local r, g, b

    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);

    i = i % 6

    if i == 0 then
        r, g, b = v, t, p
    elseif i == 1 then
        r, g, b = q, v, p
    elseif i == 2 then
        r, g, b = p, v, t
    elseif i == 3 then
        r, g, b = p, q, v
    elseif i == 4 then
        r, g, b = t, p, v
    elseif i == 5 then
        r, g, b = v, p, q
    end

    return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

-- Converts a given RGB Color to HSV
function Conversion.RGBtoHSV(r, g, b)
    r, g, b = r / 255, g / 255, b / 255
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, v
    v = max

    local d = max - min
    if max == 0 then
        s = 0
    else
        s = d / max
    end

    if max == min then
        h = 0
    else
        if max == r then
            h = (g - b) / d
            if g < b then
                h = h + 6
            end
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end

    return h, s, v
end

return Conversion
end)
__bundle_register("Library/UI/UI", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class UI
---@field public Fonts Fonts
---@field public Textures Textures
---@field public Notify Notify
local UI = {
    Fonts = require("Library/UI/Fonts"),
    Textures = require("Library/UI/Textures"),
    Notify = require("Library/UI/Notify")
}

function UI._OnDraw()
    UI.Notify._OnDraw()
end

return UI
end)
__bundle_register("Library/UI/Notify", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    UI Notifications

    A notification can have the following attributes:
    Title, Content, Duration
]]

---@type Fonts
local Fonts = require("Library/UI/Fonts")

local Size = { W = 300, H = 60 }
local Offset = { X = 10, Y = 10 }
local Padding = { X = 10, Y = 10 }

---@class Notify
---@field private Width number
---@field private Height number
---@field private Notifications table
---@field private CurrentID number
local Notify = {
    Notifications = { },
    CurrentID = 0
}

---@param data table
function Notify.Push(data)
    assert(type(data) == "table", "Notify.Push: data must be a table")

    -- Set the ID if it's not set
    if not data.ID then
        data.ID = Notify.CurrentID
    end

    -- Set default duration if not set
    if not data.Duration then
        data.Duration = 3
    end

   data.StartTime = globals.RealTime()
    table.insert(Notify.Notifications, data)
    Notify.CurrentID = Notify.CurrentID + 1

    return data.ID
end

function Notify.Alert(title)
    Notify.Push({
        Title = title
    })
end

---@param title string
---@param msg string
function Notify.Simple(title, msg)
    return Notify.Push({
        Title = title,
        Content = msg
    })
end

---@param id number
function Notify.Pop(id)
    for i, notification in pairs(Notify.Notifications) do
        if notification.ID == id then
            Notify.Notifications[i] = nil
            return
        end
    end
end

function Notify._OnDraw()
    local currentY = Offset.Y

    for i, note in pairs(Notify.Notifications) do
        if globals.RealTime() - note.StartTime > note.Duration then
            Notify.Notifications[i] = nil
        else
            local deltaTime = globals.RealTime() - note.StartTime
            local durStep = deltaTime / note.Duration
            local fadeAlpha = math.floor(math.min(255, deltaTime * 4 * 255))

            -- Background
            draw.Color(35, 50, 60, fadeAlpha)
            draw.FilledRect(Offset.X, currentY, Offset.X + Size.W, currentY + Size.H)

            -- Duration indicator
            local barWidth = math.floor(Size.W * durStep)
            draw.Color(255, 255, 255, 150)
            draw.FilledRect(Offset.X, currentY, Offset.X + barWidth, currentY + 5)

            draw.Color(245, 245, 245, fadeAlpha)

            -- Title Text
            draw.SetFont(Fonts.SegoeTitle)
            if note.Title then
                draw.Text(Offset.X + Padding.X, currentY + Padding.Y, note.Title)
            end

            -- Content Text
            draw.SetFont(Fonts.Segoe)
            if note.Content then
                draw.Text(Offset.X + Padding.X, currentY + Padding.Y + 20, note.Content)
            end

            currentY = currentY + Size.H + Offset.Y
        end
    end
end

return Notify
end)
__bundle_register("Library/UI/Fonts", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class Fonts
---@field public Verdana number
---@field public VerdanaTitle number
---@field public Segoe number
---@field public SegoeTitle number
local Fonts = {
    Verdana = draw.CreateFont("Verdana", 14, 510),
    VerdanaTitle = draw.CreateFont("Verdana", 24, 700),
    Segoe = draw.CreateFont("Segoe UI", 14, 510),
    SegoeTitle = draw.CreateFont("Segoe UI", 24, 700),
}

return Fonts
end)
__bundle_register("Library/UI/Textures", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class Textures
local Textures = { }

--[[
    Creates gradients in the RGBA8888 format as RGBA binary data.
    Can be used to draw textures in lmaobox
]]

-- [PERFORMANCE INTENSIVE] Creates a linear gradient (255 pixels or greater)
---@param startColor table<number, number, number, number>
---@param endColor table<number, number, number, number>
---@param size table<number, number>
function Textures.LinearGradient(startColor, endColor, size)
    startColor = startColor or { 0, 0, 0, 255 }
    endColor = endColor or { 255, 255, 255, 255 }
    startColor[4] = startColor[4] or 255
    endColor[4] = endColor[4] or 255
    local width = size[1] or 255
    local height = size[2] or 255

    local data = ""
    local step = { }
    local stepX = (endColor[1] - startColor[1]) / width
    local stepY = (endColor[2] - startColor[2]) / height
    local stepZ = (endColor[3] - startColor[3]) / width
    local stepW = (endColor[4] - startColor[4]) / height
    for i = 0, width - 1 do
        step[1] = startColor[1] + i * stepX
        for j = 0, height - 1 do
            step[2] = startColor[2] + j * stepY
            step[3] = startColor[3] + i * stepZ
            step[4] = startColor[4] + j * stepW
            data = data .. string.char(step[1]) .. string.char(step[2]) .. string.char(step[3]) .. string.char(step[4])
        end
    end

    return data
end

-- [PERFORMANCE INTENSIVE] Creates a circle with a given color
---@param radius number
---@param color table<number, number, number, number>
function Textures.Circle(radius, color)
    color[4] = color[4] or 255

    local data = ""
    local step = { }
    local stepX = 0
    local stepY = 0
    local stepZ = 0
    local stepW = 0
    for i = 0, radius do
        stepX = math.cos(i * math.pi / radius)
        stepY = math.sin(i * math.pi / radius)
        for j = 0, radius do
            stepZ = math.cos(j * math.pi / radius)
            stepW = math.sin(j * math.pi / radius)
            step[1] = math.floor(color[1] * stepX)
            step[2] = math.floor(color[2] * stepY)
            step[3] = math.floor(color[3] * stepZ)
            step[4] = math.floor(color[4] * stepW)

            data = data .. string.char(step[1]) .. string.char(step[2]) .. string.char(step[3]) .. string.char(step[4])
        end
    end

    return data
end

return Textures
end)
__bundle_register("Library/TF2/TF2", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class TF2
---@field public Globals Globals
---@field public EntityCache EntityCache
---@field public WPlayer WPlayer
---@field public WEntity WEntity
---@field public WWeapon WWeapon
local TF2 = {
    Helpers = require("Library/TF2/Helpers"),
    Globals = require("Library/TF2/Globals"),
    EntityCache = require("Library/TF2/EntityCache"),

    WPlayer = require("Library/TF2/Wrappers/WPlayer"),
    WEntity = require("Library/TF2/Wrappers/WEntity"),
    WWeapon = require("Library/TF2/Wrappers/WWeapon"),
}

function TF2.Exit()
    os.exit()
end

function TF2._OnCreateMove(userCmd)
    TF2.Globals._OnCreateMove(userCmd)
end

function TF2._OnDraw()

end

return TF2
end)
__bundle_register("Library/TF2/Wrappers/WWeapon", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Wrapper Class for Wepaon Entities
]]

local WEntity = require("Library/TF2/Wrappers/WEntity")

---@class WWeapon : WEntity
local WWeapon = { }
WWeapon.__index = WWeapon
setmetatable(WWeapon, WEntity)

--[[ Contructors ]]

-- Creates a WWeapon from a given native Entity
---@param entity Entity
---@return WWeapon
function WWeapon.FromEntity(entity)
    assert(entity:IsWeapon(), "WWeapon.FromEntity: entity is not a weapon")

    ---@type self
    local self = setmetatable({ }, WWeapon)
    self.Entity = entity

    return self
end

-- Creates a WWeapon from a given WEntity
---@param wEntity WEntity
---@return WWeapon
function WWeapon.FromWEntity(wEntity)
    return WWeapon.FromEntity(wEntity.Entity)
end

--[[ Wrapper functions ]]

-- Returns if the weapon can shoot
---@param lPlayer any
---@return boolean
function WWeapon:CanShoot(lPlayer)
    if (not WWeapon.Entity) or (self.Entity:IsMeleeWeapon()) then return false end

    local nextPrimaryAttack = self.Entity:GetPropFloat("LocalActiveWeaponData", "m_flNextPrimaryAttack")
    local nextAttack = lPlayer:GetPropFloat("bcc_localdata", "m_flNextAttack")
    if (not nextPrimaryAttack) or (not nextAttack) then return false end

    return (nextPrimaryAttack <= globals.CurTime()) and (nextAttack <= globals.CurTime())
end

return WWeapon
end)
__bundle_register("Library/TF2/Wrappers/WEntity", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Wrapper Class for Entities
]]

---@class WEntity
---@field public Entity Entity
local WEntity = { }
WEntity.__index = WEntity

--[[ Constructors ]]

-- Creates a WEntity from a given native Entity
---@param entity Entity
---@return WEntity
function WEntity.FromEntity(entity)
    ---@type self
    local self = setmetatable({ }, WEntity)
    self.Entity = entity

    return self
end

--[[ Wrapper functions ]]

-- Returns the native base entity
function WEntity:Unwrap()
    return self.Entity
end

-- Returns the position of the hitbox as a Vector3
---@param hitbox number
function WEntity:GetHitboxPos(hitbox)
    local hitbox = self.Entity:GetHitboxes()[hitbox]
    if not hitbox then return end

    return (hitbox[1] + hitbox[2]) * 0.5
end

return WEntity
end)
__bundle_register("Library/TF2/Wrappers/WPlayer", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Wrapper Class for Player Entities
]]

local WEntity = require("Library/TF2/Wrappers/WEntity")

---@class WPlayer : WEntity
local WPlayer = {
    Entity = nil
}
WPlayer.__index = WPlayer
setmetatable(WPlayer, WEntity)

--[[ Constructors ]]

-- Creates a WPlayer from a given native Entity
---@param entity Entity
---@return WPlayer
function WPlayer.FromEntity(entity)
    assert(entity:IsPlayer(), "WPlayer.FromEntity: entity is not a player")

    ---@type self
    local self = setmetatable({ }, WPlayer)
    self.Entity = entity

    return self
end

-- Returns a WPlayer of the local player
---@return WPlayer
function WPlayer.GetLocalPlayer()
    return WPlayer.FromEntity(entities.GetLocalPlayer())
end

-- Creates a WPlayer from a given WEntity
---@param wEntity WEntity
---@return WPlayer
function WPlayer.FromWEntity(wEntity)
    return WPlayer.FromEntity(wEntity.Entity)
end

--[[ Wrapper functions ]]

-- Returns whether the player is on the ground
---@return boolean
function WPlayer:IsOnGround()
    local pFlags = self.Entity:GetPropInt("m_fFlags")
    return (pFlags & FL_ONGROUND) == 1
end

-- Returns the active weapon
function WPlayer:GetActiveWeapon()
    return self.Entity:GetPropEntity("m_hActiveWeapon")
end

-- Returns the spectated target
function WPlayer:GetObservedTarget()
    return self.Entity:GetPropEntity("m_hObserverTarget")
end

return WPlayer
end)
__bundle_register("Library/TF2/EntityCache", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Entity List
]]

---@type Globals
local Globals = require("Library/TF2/Globals")

---@type Entity[]
local LastPlayerList = {}

---@type Entity[]
local LastTeamList = {}

---@type Entity[]
local LastEnemyList = {}

local LastCheck = 0

-- Updates the Entity Cache for every UserCmd | TODO: Use FSN?
local function UpdateCache()
    -- Check if we've recently cached the player list
    if Globals.CommandNumber == LastCheck then
        return
    end

    -- Get all Players
    LastCheck = Globals.CommandNumber
    LastPlayerList = entities.FindByClass("CTFPlayer")
    local localPlayer = entities.GetLocalPlayer()
    table.remove(LastPlayerList, localPlayer:GetIndex())

    -- Filter players by team
    for _, player in pairs(LastPlayerList) do
        if player:GetTeamNumber() == localPlayer:GetTeamNumber() then
            table.insert(LastTeamList, player)
        else
            table.insert(LastEnemyList, player)
        end
    end
end

---@class EntityCache
local EntityCache = { }

-- Returns all players in the game
---@return Entity[]
function EntityCache.GetPlayers()
    UpdateCache()
    return LastPlayerList
end

-- Returns all players in your team
---@return Entity[]
function EntityCache.GetTeam()
    UpdateCache()
    return LastTeamList
end

-- Returns all players that are not in your team
---@return Entity[]
function EntityCache.GetEnemies()
    UpdateCache()
    return LastEnemyList
end

return EntityCache
end)
__bundle_register("Library/TF2/Globals", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Global variables for TF2
]]

---@class Globals
---@field public LastCommandNumber number
---@field public CommandNumber number
local Globals = {
    LastCommandNumber = 0,
    CommandNumber = 0
}

-- Updates the global variables
---@param userCmd UserCmd
function Globals._OnCreateMove(userCmd)
    Globals.LastCommandNumber = Globals.CommandNumber
    Globals.CommandNumber = userCmd.command_number
end

return Globals
end)
__bundle_register("Library/TF2/Helpers", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Helpers
]]

local Helpers = { }

---@param userCmd UserCmd
---@param a Vector3
---@param b Vector3
---@return Vector3
function Helpers.ComputeMove(userCmd, a, b)
    local diff = (b - a)
    if diff:Length() == 0 then return Vector3(0, 0, 0) end

    local x = diff.x
    local y = diff.y
    local vSilent = Vector3(x, y, 0)

    local ang = vSilent:Angles()
    local cPitch, cYaw, cRoll = userCmd:GetViewAngles()
    local yaw = math.rad(ang.y - cYaw)
    local pitch = math.rad(ang.x - cPitch)
    local move = Vector3(math.cos(yaw) * 450, -math.sin(yaw) * 450, -math.cos(pitch) * 450)

    return move
end

---@param userCmd UserCmd
---@param localPlayer Entity
---@param destination Vector3
function Helpers.WalkTo(userCmd, localPlayer, destination)
    local localPos = localPlayer:GetAbsOrigin()
    local result = Helpers.ComputeMove(userCmd, localPos, destination)

    pCmd:SetForwardMove(result.x)
    pCmd:SetSideMove(result.y)
end

return Helpers
end)
__bundle_register("Library/Extensions", function(require, _LOADED, __bundle_register, __bundle_modules)
--[[
    Extensions for Lua
]]

function math.clamp(n, low, high)
    return math.min(math.max(n, low), high)
end
end)
return __bundle_require("__root")