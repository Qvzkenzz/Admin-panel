-- LocalScript_AdminPanel.lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local KickEvent = ReplicatedStorage:WaitForChild("KickPlayer")
local BanEvent = ReplicatedStorage:WaitForChild("BanPlayer")

local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminPanelGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local BUTTON_COLOR = Color3.fromRGB(40, 40, 40)
local BUTTON_HOVER = Color3.fromRGB(60, 60, 60)
local TEXT_COLOR = Color3.fromRGB(230, 230, 230)
local BACKGROUND_COLOR = Color3.fromRGB(20, 20, 20)
local ACCENT_COLOR = Color3.fromRGB(0, 170, 255)

local miniButton = Instance.new("TextButton")
miniButton.Name = "MiniButton"
miniButton.Size = UDim2.new(0, 50, 0, 50)
miniButton.Position = UDim2.new(0, 20, 0, 20)
miniButton.BackgroundColor3 = BUTTON_COLOR
miniButton.Text = "Admin"
miniButton.TextColor3 = TEXT_COLOR
miniButton.TextScaled = true
miniButton.Font = Enum.Font.GothamBold
miniButton.Parent = screenGui
miniButton.AutoButtonColor = false

miniButton.MouseEnter:Connect(function()
    miniButton.BackgroundColor3 = BUTTON_HOVER
end)
miniButton.MouseLeave:Connect(function()
    miniButton.BackgroundColor3 = BUTTON_COLOR
end)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0, 20, 0, 80)
mainFrame.BackgroundColor3 = BACKGROUND_COLOR
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Admin Panel"
title.Font = Enum.Font.GothamBold
title.TextColor3 = TEXT_COLOR
title.TextScaled = true
title.Parent = mainFrame

local playerList = Instance.new("ScrollingFrame")
playerList.Name = "PlayerList"
playerList.Size = UDim2.new(1, -20, 1, -130)
playerList.Position = UDim2.new(0, 10, 0, 50)
playerList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
playerList.BorderSizePixel = 0
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ScrollBarThickness = 6
playerList.Parent = mainFrame

local playerListCorner = Instance.new("UICorner")
playerListCorner.CornerRadius = UDim.new(0, 10)
playerListCorner.Parent = playerList

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 6)
listLayout.Parent = playerList

local selectedPlayerName = nil
local selectedButton = nil

local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(1, -20, 0, 60)
buttonContainer.Position = UDim2.new(0, 10, 1, -70)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainFrame

local banButton = Instance.new("TextButton")
banButton.Name = "BanButton"
banButton.Size = UDim2.new(0.45, 0, 1, 0)
banButton.Position = UDim2.new(0, 0, 0, 0)
banButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
banButton.Text = "Ban"
banButton.TextColor3 = TEXT_COLOR
banButton.Font = Enum.Font.GothamBold
banButton.TextScaled = true
banButton.AutoButtonColor = false
banButton.Visible = false
banButton.Parent = buttonContainer

banButton.MouseEnter:Connect(function()
    banButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
end)
banButton.MouseLeave:Connect(function()
    banButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
end)

local kickButton = Instance.new("TextButton")
kickButton.Name = "KickButton"
kickButton.Size = UDim2.new(0.45, 0, 1, 0)
kickButton.Position = UDim2.new(0.55, 0, 0, 0)
kickButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
kickButton.Text = "Kick"
kickButton.TextColor3 = TEXT_COLOR
kickButton.Font = Enum.Font.GothamBold
kickButton.TextScaled = true
kickButton.AutoButtonColor = false
kickButton.Visible = false
kickButton.Parent = buttonContainer

kickButton.MouseEnter:Connect(function()
    kickButton.BackgroundColor3 = Color3.fromRGB(255, 160, 20)
end)
kickButton.MouseLeave:Connect(function()
    kickButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
end)

miniButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

local function clearSelection()
    if selectedButton then
        selectedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
    selectedPlayerName = nil
    selectedButton = nil
    banButton.Visible = false
    kickButton.Visible = false
end

local function selectPlayer(button, playerName)
    clearSelection()
    selectedPlayerName = playerName
    selectedButton = button
    button.BackgroundColor3 = ACCENT_COLOR
    banButton.Visible = true
    kickButton.Visible = true
end

local function populatePlayers()
    for _, child in pairs(playerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    clearSelection()
    local count = 0
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.BackgroundColor3 = BUTTON_COLOR
            btn.TextColor3 = TEXT_COLOR
            btn.Text = plr.Name
            btn.Font = Enum.Font.Gotham
            btn.TextScaled = true
            btn.AutoButtonColor = false
            btn.Parent = playerList
            btn.Name = plr.UserId
            
            btn.MouseEnter:Connect(function()
                if btn ~= selectedButton then
                    btn.BackgroundColor3 = BUTTON_HOVER
                end
            end)
            btn.MouseLeave:Connect(function()
                if btn ~= selectedButton then
                    btn.BackgroundColor3 = BUTTON_COLOR
                end
            end)
            
            btn.MouseButton1Click:Connect(function()
                selectPlayer(btn, plr.Name)
            end)
            count = count + 1
        end
    end
    playerList.CanvasSize = UDim2.new(0, 0, 0, count * 36)
end

populatePlayers()

Players.PlayerAdded:Connect(populatePlayers)
Players.PlayerRemoving:Connect(populatePlayers)

kickButton.MouseButton1Click:Connect(function()
    if selectedPlayerName then
        KickEvent:FireServer(selectedPlayerName)
        clearSelection()
    end
end)

banButton.MouseButton1Click:Connect(function()
    if selectedPlayerName then
        BanEvent:FireServer(selectedPlayerName)
        clearSelection()
    end
end)
