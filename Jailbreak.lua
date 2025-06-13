-- Utilities
local HttpGet = game.HttpGet or function(t,u) return game:HttpGet(u) end

-- Fetch and load modules
local modules = {
    autoFarm = HttpGet(game, 'https://yourcdn.com/autoFarm.lua'),
    combat = HttpGet(game, 'https://yourcdn.com/combat.lua'),
    serverHop = HttpGet(game, 'https://yourcdn.com/serverHop.lua'),
}
-- Run each module
for name, code in pairs(modules) do
    local ok, func = pcall(loadstring, code)
    if ok and type(func) == 'function' then
        func()
    else
        warn("Failed loading:", name, func)
    end
end

-- Basic GUI (example, you could use Rayfield or another lib)
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0,200,0,150)
frame.Position = UDim2.new(0,10,0,10)

local function addToggle(text, callback, yOffset)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,0,0,30)
    btn.Position = UDim2.new(0,0,0, yOffset)
    btn.Text = text
    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        callback(toggled)
        btn.BackgroundColor3 = toggled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
    end)
end

-- Add toggles for each module
addToggle("Auto‑Farm", function(on)
    -- assume autoFarm module defines toggleAutoFarm(bool)
    if modules.autoFarm then modules.autoFarm.toggle(on) end
end, 0)
addToggle("Combat Assist", function(on)
    if modules.combat then modules.combat.toggle(on) end
end, 40)
addToggle("Server Hop", function(on)
    if modules.serverHop then modules.serverHop.toggle(on) end
end, 80)
