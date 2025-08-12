-- ServerScript_AdminCommands.lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local KickEvent = Instance.new("RemoteEvent")
KickEvent.Name = "KickPlayer"
KickEvent.Parent = ReplicatedStorage

local BanEvent = Instance.new("RemoteEvent")
BanEvent.Name = "BanPlayer"
BanEvent.Parent = ReplicatedStorage

local bannedUsers = {} -- Simple ban list by username (you can improve)

BanEvent.OnServerEvent:Connect(function(adminPlayer, targetName)
    if targetName and typeof(targetName) == "string" then
        print(adminPlayer.Name .. " wants to ban " .. targetName)
        bannedUsers[targetName] = true
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer then
            targetPlayer:Kick("You have been banned.")
        end
    end
end)

KickEvent.OnServerEvent:Connect(function(adminPlayer, targetName)
    if targetName and typeof(targetName) == "string" then
        print(adminPlayer.Name .. " wants to kick " .. targetName)
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer then
            targetPlayer:Kick("You have been kicked.")
        end
    end
end)

-- Prevent banned players from joining
Players.PlayerAdded:Connect(function(plr)
    if bannedUsers[plr.Name] then
        plr:Kick("You
