local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("DarkGG_UI") then CoreGui.DarkGG_UI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DarkGG_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local function AddRainbow(obj)
    task.spawn(function()
        local hue = 0
        while obj.Parent do
            hue = hue + 0.005
            if hue >= 1 then hue = 0 end
            obj.Color = Color3.fromHSV(hue, 1, 1)
            task.wait()
        end
    end)
end

local function makeDraggable(frame)
    local dragToggle, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragToggle = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragToggle then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local KeySystemGui = Instance.new("Frame", ScreenGui)
KeySystemGui.Size = UDim2.new(0, 300, 0, 280)
KeySystemGui.Position = UDim2.new(0.5, -150, 0.5, -140)
KeySystemGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeySystemGui.BorderSizePixel = 0
KeySystemGui.ZIndex = 50

Instance.new("UICorner", KeySystemGui).CornerRadius = UDim.new(0, 16)
local UIStrokeKey = Instance.new("UIStroke", KeySystemGui)
UIStrokeKey.Thickness = 2
AddRainbow(UIStrokeKey)

local KeyTitle = Instance.new("TextLabel", KeySystemGui)
KeyTitle.Size = UDim2.new(1, 0, 0, 45)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "DarkGG Key System"
KeyTitle.TextColor3 = Color3.new(1, 1, 1)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16
KeyTitle.ZIndex = 51

local KeyBox = Instance.new("TextBox", KeySystemGui)
KeyBox.Size = UDim2.new(0.85, 0, 0, 40)
KeyBox.Position = UDim2.new(0.075, 0, 0.20, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyBox.PlaceholderText = "Enter key here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.new(1, 1, 1)
KeyBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
KeyBox.Font = Enum.Font.GothamMedium
KeyBox.TextSize = 14
KeyBox.ZIndex = 51

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 10)

local SubmitBtn = Instance.new("TextButton", KeySystemGui)
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 36)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.37, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SubmitBtn.Text = "CHECK KEY"
SubmitBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 14
SubmitBtn.ZIndex = 51

Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 10)

local CopyKeyBtn = Instance.new("TextButton", KeySystemGui)
CopyKeyBtn.Size = UDim2.new(0.85, 0, 0, 36)
CopyKeyBtn.Position = UDim2.new(0.075, 0, 0.53, 0)
CopyKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CopyKeyBtn.Text = "COPY KEY"
CopyKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CopyKeyBtn.Font = Enum.Font.GothamBold
CopyKeyBtn.TextSize = 13
CopyKeyBtn.ZIndex = 51

Instance.new("UICorner", CopyKeyBtn).CornerRadius = UDim.new(0, 10)

local CopyDiscordBtn = Instance.new("TextButton", KeySystemGui)
CopyDiscordBtn.Size = UDim2.new(0.85, 0, 0, 36)
CopyDiscordBtn.Position = UDim2.new(0.075, 0, 0.69, 0)
CopyDiscordBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CopyDiscordBtn.Text = "COPY DISCORD"
CopyDiscordBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CopyDiscordBtn.Font = Enum.Font.GothamBold
CopyDiscordBtn.TextSize = 13
CopyDiscordBtn.ZIndex = 51

Instance.new("UICorner", CopyDiscordBtn).CornerRadius = UDim.new(0, 10)

makeDraggable(KeySystemGui)

CopyKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://t.me/DarkGGkeys")
        CopyKeyBtn.Text = "COPIED KEY!"
        task.wait(1.5)
        CopyKeyBtn.Text = "COPY KEY"
    end
end)

CopyDiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/h3ttTw5sN")
        CopyDiscordBtn.Text = "COPIED DISCORD!"
        task.wait(1.5)
        CopyDiscordBtn.Text = "COPY DISCORD"
    end
end)

local function getRole(player)
    if not player or not player.Character then return "Innocent" end
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    
    local function check(item)
        if item:IsA("Tool") then
            local n = item.Name:lower()
            if n:find("gun") or n:find("revolver") then return "Sheriff"
            elseif n:find("knife") or n:find("dagger") then return "Murderer" end
        end
    end
    
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            local r = check(item)
            if r then return r end
        end
    end
    
    for _, item in ipairs(char:GetChildren()) do
        local r = check(item)
        if r then return r end
    end
    
    return "Innocent"
end

local PickupBtn = Instance.new("TextButton")
PickupBtn.Name = "PickupGunButton"
PickupBtn.Size = UDim2.new(0, 70, 0, 70)
PickupBtn.Position = UDim2.new(0, 20, 0, 120)
PickupBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PickupBtn.Text = "GET\nGUN"
PickupBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PickupBtn.Font = Enum.Font.GothamBold
PickupBtn.TextSize = 14
PickupBtn.Visible = false
PickupBtn.Parent = ScreenGui

Instance.new("UICorner", PickupBtn).CornerRadius = UDim.new(0, 12)
local UIStrokePickup = Instance.new("UIStroke", PickupBtn)
UIStrokePickup.Thickness = 2
AddRainbow(UIStrokePickup)
makeDraggable(PickupBtn)

local ShootBtn = Instance.new("TextButton")
ShootBtn.Name = "ShootMurdererButton"
ShootBtn.Size = UDim2.new(0, 70, 0, 70)
ShootBtn.Position = UDim2.new(0, 20, 0, 200)
ShootBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ShootBtn.Text = "SHOOT\nMURDER"
ShootBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
ShootBtn.Font = Enum.Font.GothamBold
ShootBtn.TextSize = 13
ShootBtn.Visible = false
ShootBtn.Parent = ScreenGui

Instance.new("UICorner", ShootBtn).CornerRadius = UDim.new(0, 12)
local UIStrokeShoot = Instance.new("UIStroke", ShootBtn)
UIStrokeShoot.Thickness = 2
AddRainbow(UIStrokeShoot)
makeDraggable(ShootBtn)

PickupBtn.MouseButton1Click:Connect(function()
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    local droppedGun = workspace:FindFirstChild("GunDrop", true)
    if droppedGun and droppedGun:IsA("BasePart") then
        local oldCFrame = myHRP.CFrame
        myHRP.CFrame = droppedGun.CFrame
        task.wait(0.1)
        myHRP.CFrame = oldCFrame
    end
end)

ShootBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    
    local gun = char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
    if not gun then return end
    
    if gun.Parent == LocalPlayer.Backpack then
        gun.Parent = char
        task.wait(0.05)
    end
    
    local murdererHRP = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and getRole(p) == "Murderer" and p.Character then
            murdererHRP = p.Character:FindFirstChild("HumanoidRootPart")
            break
        end
    end
    
    if murdererHRP then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, murdererHRP.Position)
        task.wait(0.02)
        gun:Activate()
    end
end)

local ItemValues = {
    ["niks scythe"] = 150000, ["chroma darkbringer"] = 140, ["chroma lightbringer"] = 130,
    ["chroma luger"] = 110, ["chroma gemstone"] = 90, ["chroma heat"] = 85,
    ["chroma fang"] = 80, ["chroma tides"] = 75, ["chroma slasher"] = 70,
    ["chroma deathshard"] = 65, ["chroma saw"] = 60, ["chroma seer"] = 55,
    ["darkbringer"] = 65, ["lightbringer"] = 60, ["luger"] = 75,
    ["icebreaker"] = 125, ["icewing"] = 2, ["batwing"] = 60, ["elderwood scythe"] = 90,
    ["elderwood revolver"] = 85, ["hallowscythe"] = 45, ["hallowgun"] = 35,
    ["candy"] = 180, ["sugar"] = 125, ["red luger"] = 85, ["green luger"] = 80,
    ["pixel"] = 55, ["clockwork"] = 40, ["slasher"] = 35, ["laser"] = 45,
    ["gemstone"] = 25, ["heat"] = 30, ["fang"] = 25, ["tides"] = 25,
    ["deathshard"] = 25, ["saw"] = 15, ["seer"] = 10, ["spider"] = 25,
    ["america"] = 25, ["golden"] = 20, ["blood"] = 15, ["phaser"] = 15,
    ["shadow"] = 12, ["prince"] = 10, ["cowboy"] = 8, ["split"] = 5
}

local function getItemValue(itemName)
    if not itemName then return 0 end
    local cleanName = itemName:lower():gsub("%s+", " ")
    for name, val in pairs(ItemValues) do
        if cleanName:find(name) then return val end
    end
    return 0
end

local Watermark = Instance.new("Frame")
Watermark.Size = UDim2.new(0, 220, 0, 40)
Watermark.Position = UDim2.new(0, 20, 0, 20)
Watermark.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Watermark.BorderSizePixel = 0
Watermark.Visible = false
Watermark.Parent = ScreenGui

Instance.new("UICorner", Watermark).CornerRadius = UDim.new(0, 12)
local UIStrokeWM = Instance.new("UIStroke", Watermark)
UIStrokeWM.Thickness = 2
AddRainbow(UIStrokeWM)

local WatermarkText = Instance.new("TextLabel", Watermark)
WatermarkText.Size = UDim2.new(1, 0, 1, 0)
WatermarkText.BackgroundTransparency = 1
WatermarkText.Text = "DarkGG || tg:darkGGkeys"
WatermarkText.TextColor3 = Color3.new(1, 1, 1)
WatermarkText.Font = Enum.Font.GothamBold
WatermarkText.TextSize = 13

local MainWindow = Instance.new("Frame")
MainWindow.Size = UDim2.new(0, 320, 0, 520)
MainWindow.Position = UDim2.new(0.5, -160, 0.5, -260)
MainWindow.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainWindow.Visible = false
MainWindow.Parent = ScreenGui

Instance.new("UICorner", MainWindow).CornerRadius = UDim.new(0, 16)
local UIStrokeMain = Instance.new("UIStroke", MainWindow)
UIStrokeMain.Thickness = 2
AddRainbow(UIStrokeMain)

local Title = Instance.new("TextLabel", MainWindow)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "DarkGG MM2 Menu"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local TabBar = Instance.new("Frame", MainWindow)
TabBar.Size = UDim2.new(0.9, 0, 0, 35)
TabBar.Position = UDim2.new(0.05, 0, 0, 45)
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 10)

local TabBarLayout = Instance.new("UIListLayout", TabBar)
TabBarLayout.FillDirection = Enum.FillDirection.Horizontal
TabBarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabBarLayout.Padding = UDim.new(0, 5)

local TabsContainer = Instance.new("Folder", MainWindow)

local function CreateTabContent()
    local scroll = Instance.new("ScrollingFrame", TabsContainer)
    scroll.Size = UDim2.new(0.9, 0, 0.78, 0)
    scroll.Position = UDim2.new(0.05, 0, 0.18, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 3
    scroll.Visible = false
    
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 8)
    return scroll
end

local CombatScroll = CreateTabContent()
local VisualsScroll = CreateTabContent()
local MiscScroll = CreateTabContent()

CombatScroll.Visible = true

local function CreateTabButton(name, targetScroll)
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0.31, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        CombatScroll.Visible = false
        VisualsScroll.Visible = false
        MiscScroll.Visible = false
        
        for _, child in ipairs(TabBar:GetChildren()) do
            if child:IsA("TextButton") then
                child.TextColor3 = Color3.fromRGB(180, 180, 180)
                child.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            end
        end
        
        targetScroll.Visible = true
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    
    if targetScroll == CombatScroll then
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end

CreateTabButton("Combat", CombatScroll)
CreateTabButton("Visuals", VisualsScroll)
CreateTabButton("Misc", MiscScroll)

local TradeGui = Instance.new("Frame", ScreenGui)
TradeGui.Size = UDim2.new(0, 280, 0, 90)
TradeGui.Position = UDim2.new(0.5, -140, 0.15, 0)
TradeGui.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TradeGui.BorderSizePixel = 0
TradeGui.Visible = false

Instance.new("UICorner", TradeGui).CornerRadius = UDim.new(0, 12)
local UIStrokeTrade = Instance.new("UIStroke", TradeGui)
UIStrokeTrade.Thickness = 2
AddRainbow(UIStrokeTrade)

local TradeStatus = Instance.new("TextLabel", TradeGui)
TradeStatus.Size = UDim2.new(1, 0, 0, 35)
TradeStatus.BackgroundTransparency = 1
TradeStatus.Text = "WAITING FOR TRADE..."
TradeStatus.TextColor3 = Color3.new(1, 1, 1)
TradeStatus.Font = Enum.Font.GothamBold
TradeStatus.TextSize = 18

local TradeInfo = Instance.new("TextLabel", TradeGui)
TradeInfo.Size = UDim2.new(1, 0, 0, 45)
TradeInfo.Position = UDim2.new(0, 0, 0, 35)
TradeInfo.BackgroundTransparency = 1
TradeInfo.Text = "You: 0 | Them: 0"
TradeInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
TradeInfo.Font = Enum.Font.GothamMedium
TradeInfo.TextSize = 13

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "DarkGG2" then
        KeySystemGui:Destroy()
        Watermark.Visible = true
    else
        SubmitBtn.Text = "INVALID KEY!"
        SubmitBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        task.wait(1.5)
        SubmitBtn.Text = "CHECK KEY"
        SubmitBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
    end
end)

local isDraggingWatermark = false
Watermark.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingWatermark = false
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                connection:Disconnect()
                if not isDraggingWatermark then
                    MainWindow.Visible = not MainWindow.Visible
                end
            end
        end)
    end
end)

makeDraggable(Watermark)
makeDraggable(MainWindow)
makeDraggable(TradeGui)

local Config = {
    ESP = false,
    Aimbot = false,
    Chams = false,
    FakeSpeed = false,
    AntiFling = false,
    Spinbot = false,
    SpinSpeed = 10,
    TradeAdvisor = false,
    FlingMurderer = false,
    FlingSheriff = false,
    FlingTarget = false,
    Wallbang = false,
    KillAll = false,
    SelectedTarget = nil
}

local function AddToggle(targetScroll, name, callback)
    local btn = Instance.new("TextButton", targetScroll)
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = "  " .. name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    local ind = Instance.new("Frame", btn)
    ind.Size = UDim2.new(0, 12, 0, 12)
    ind.Position = UDim2.new(1, -25, 0.5, -6)
    ind.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.Text = "  " .. name .. ": ON"
            btn.TextColor3 = Color3.new(1, 1, 1)
            ind.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
        else
            btn.Text = "  " .. name .. ": OFF"
            btn.TextColor3 = Color3.fromRGB(180, 180, 180)
            ind.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        end
        callback(state)
    end)
end

local SpinSpeedBtn = Instance.new("TextButton", CombatScroll)
SpinSpeedBtn.Size = UDim2.new(1, 0, 0, 45)
SpinSpeedBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SpinSpeedBtn.Text = "  Spin Speed: Slow (10)"
SpinSpeedBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
SpinSpeedBtn.Font = Enum.Font.GothamMedium
SpinSpeedBtn.TextSize = 13
SpinSpeedBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", SpinSpeedBtn).CornerRadius = UDim.new(0, 10)

SpinSpeedBtn.MouseButton1Click:Connect(function()
    if Config.SpinSpeed == 10 then
        Config.SpinSpeed = 25
        SpinSpeedBtn.Text = "  Spin Speed: Medium (25)"
    elseif Config.SpinSpeed == 25 then
        Config.SpinSpeed = 50
        SpinSpeedBtn.Text = "  Spin Speed: Fast (50)"
    else
        Config.SpinSpeed = 10
        SpinSpeedBtn.Text = "  Spin Speed: Slow (10)"
    end
end)

local TargetBtn = Instance.new("TextButton", CombatScroll)
TargetBtn.Size = UDim2.new(1, 0, 0, 45)
TargetBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TargetBtn.Text = "  Select Target: None"
TargetBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
TargetBtn.Font = Enum.Font.GothamMedium
TargetBtn.TextSize = 13
TargetBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", TargetBtn).CornerRadius = UDim.new(0, 10)

local PlayerListFrame = Instance.new("ScrollingFrame", ScreenGui)
PlayerListFrame.Size = UDim2.new(0, 180, 0, 200)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PlayerListFrame.Visible = false
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.ZIndex = 10
Instance.new("UICorner", PlayerListFrame).CornerRadius = UDim.new(0, 10)
local PlayerListLayout = Instance.new("UIListLayout", PlayerListFrame)
PlayerListLayout.Padding = UDim.new(0, 4)

TargetBtn.MouseButton1Click:Connect(function()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
    PlayerListFrame.Position = UDim2.new(0, TargetBtn.AbsolutePosition.X, 0, TargetBtn.AbsolutePosition.Y + 50)
    
    for _, child in ipairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton", PlayerListFrame)
            pBtn.Size = UDim2.new(1, 0, 0, 30)
            pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            pBtn.Text = p.Name
            pBtn.TextColor3 = Color3.new(1, 1, 1)
            pBtn.Font = Enum.Font.Gotham
            pBtn.TextSize = 12
            pBtn.ZIndex = 11
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)
            
            pBtn.MouseButton1Click:Connect(function()
                Config.SelectedTarget = p
                TargetBtn.Text = "  Target: " .. p.Name
                PlayerListFrame.Visible = false
            end)
        end
    end
end)

AddToggle(CombatScroll, "Kill All", function(v) Config.KillAll = v end)
AddToggle(CombatScroll, "Wallbang (Instant TP Shot)", function(v) Config.Wallbang = v end)
AddToggle(CombatScroll, "Aimbot (Murderer + FOV)", function(v) Config.Aimbot = v end)
AddToggle(CombatScroll, "Fling Target", function(v) Config.FlingTarget = v end)
AddToggle(CombatScroll, "Fling Murderer", function(v) Config.FlingMurderer = v end)
AddToggle(CombatScroll, "Fling Sheriff", function(v) Config.FlingSheriff = v end)

AddToggle(VisualsScroll, "ESP (Players / Roles)", function(v) Config.ESP = v end)
AddToggle(VisualsScroll, "Chams (Players Colors)", function(v) Config.Chams = v end)
AddToggle(VisualsScroll, "Show On-Screen Buttons", function(v)
    PickupBtn.Visible = v
    ShootBtn.Visible = v
end)

AddToggle(MiscScroll, "Trade Advisor (1s Update)", function(v) 
    Config.TradeAdvisor = v 
    TradeGui.Visible = v
end)
AddToggle(MiscScroll, "Spinbot", function(v) Config.Spinbot = v end)
AddToggle(MiscScroll, "Fake Speedglitch (90)", function(v) Config.FakeSpeed = v end)
AddToggle(MiscScroll, "Anti-Fling", function(v) Config.AntiFling = v end)

local function isInLobby(player)
    if not player or not player.Character then return true end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    
    if getRole(player) ~= "Innocent" then return false end
    if player:FindFirstChild("Backpack") and #player.Backpack:GetChildren() > 0 then return false end
    
    local lobbyPart = workspace:FindFirstChild("Lobby") or workspace:FindFirstChild("LobbyMap") or workspace:FindFirstChild("Spawns")
    if lobbyPart then
        local lobbyPos = lobbyPart:IsA("Model") and lobbyPart:GetPivot().Position or lobbyPart.Position
        if (hrp.Position - lobbyPos).Magnitude < 140 then
            return true
        end
    end

    if hrp.Position.Y > 200 or hrp.Position.Y < -80 then
        return true
    end

    return false
end

task.spawn(function()
    while true do
        if Config.TradeAdvisor then
            local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                local tradeFrame = playerGui:FindFirstChild("TradeGUI") or playerGui:FindFirstChild("TradeFrame", true)
                
                if tradeFrame and tradeFrame.Visible then
                    TradeGui.Visible = true
                    local myValue, offerValue = 0, 0
                    
                    for _, obj in ipairs(tradeFrame:GetDescendants()) do
                        if obj:IsA("TextLabel") or obj:IsA("ImageLabel") then
                            local itemName = obj.Name
                            if obj:IsA("TextLabel") and obj.Text ~= "" then itemName = obj.Text end
                            local val = getItemValue(itemName)
                            if val > 0 then
                                if obj:IsDescendantOf(tradeFrame:FindFirstChild("YourOffer", true) or tradeFrame) then
                                    myValue = myValue + val
                                elseif obj:IsDescendantOf(tradeFrame:FindFirstChild("TheirOffer", true) or tradeFrame) then
                                    offerValue = offerValue + val
                                end
                            end
                        end
                    end
                    
                    local diff = offerValue - myValue
                    TradeInfo.Text = "You: " .. myValue .. " | Them: " .. offerValue .. " (Diff: " .. diff .. ")"
                    
                    if offerValue > myValue then
                        TradeStatus.Text = "WIN (+" .. diff .. ")"
                        TradeStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
                    elseif offerValue < myValue then
                        TradeStatus.Text = "LOSE (" .. diff .. ")"
                        TradeStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
                    else
                        TradeStatus.Text = "EQUAL (0)"
                        TradeStatus.TextColor3 = Color3.fromRGB(255, 255, 50)
                    end
                else
                    TradeGui.Visible = true
                    TradeStatus.Text = "NO ACTIVE TRADE"
                    TradeStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
                    TradeInfo.Text = "Waiting for trade window..."
                end
            end
        end
        task.wait(1)
    end
end)

task.spawn(function()
    while true do
        if Config.KillAll then
            local myChar = LocalPlayer.Character
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            
            if myHRP and not isInLobby(LocalPlayer) then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                        if p.Character.Humanoid.Health > 0 and not isInLobby(p) then
                            local targetHRP = p.Character.HumanoidRootPart
                            myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 1.5)
                            task.wait(0.25)
                        end
                    end
                    if not Config.KillAll then break end
                end
            end
        end
        task.wait(0.1)
    end
end)

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = 120
FOVCircle.Filled = false
FOVCircle.Thickness = 1.5
FOVCircle.Transparency = 0.8
FOVCircle.Color = Color3.fromRGB(138, 43, 226)

local function performFling(targetChar)
    local myChar = LocalPlayer.Character
    if not myChar or not targetChar then return end
    
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    if not myHRP or not targetHRP then return end

    local oldPos = myHRP.CFrame
    
    local bav = Instance.new("BodyAngularVelocity")
    bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bav.AngularVelocity = Vector3.new(0, 99999, 0)
    bav.Parent = myHRP

    local start = tick()
    while tick() - start < 0.3 do
        if not targetHRP or not targetHRP.Parent or not myHRP or not myHRP.Parent then break end
        myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 0)
        myHRP.AssemblyLinearVelocity = Vector3.new(9999, 9999, 9999)
        RunService.Heartbeat:Wait()
    end

    bav:Destroy()
    myHRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    myHRP.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    myHRP.CFrame = oldPos
end

RunService.Stepped:Connect(function()
    if Config.AntiFling then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, part in ipairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)

local spinAngle = 0
RunService.RenderStepped:Connect(function()
    if Config.Spinbot then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local humanoid = char and char:FindFirstChild("Humanoid")
        
        if hrp and humanoid then
            spinAngle = spinAngle + Config.SpinSpeed
            if spinAngle >= 360 then spinAngle = 0 end
            
            humanoid.AutoRotate = false
            hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, math.rad(spinAngle), 0)
        end
    else
        local char = LocalPlayer.Character
        local humanoid = char and char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.AutoRotate = true
        end
    end
end)

local espCache = {}
local highlightCache = {}

local function clearCache()
    for _, v in pairs(highlightCache) do
        if v then v:Destroy() end
    end
    highlightCache = {}
end

task.spawn(function()
    while true do
        if Config.Chams then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local role = getRole(p)
                    local color = Color3.fromRGB(0, 255, 0)
                    
                    if role == "Murderer" then
                        color = Color3.fromRGB(255, 0, 0)
                    elseif role == "Sheriff" then
                        color = Color3.fromRGB(0, 100, 255)
                    end
                    
                    local highlight = p.Character:FindFirstChild("DarkGG_Chams")
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "DarkGG_Chams"
                        highlight.Parent = p.Character
                        highlight.OutlineTransparency = 1
                        highlight.FillTransparency = 0.5
                        highlightCache[p] = highlight
                    end
                    highlight.FillColor = color
                end
            end
        else
            clearCache()
        end
        task.wait(1)
    end
end)

RunService.RenderStepped:Connect(function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if not espCache[p] then
                local box = Drawing.new("Square")
                box.Visible = false
                box.Filled = false
                box.Thickness = 1.5
                box.Color = Color3.new(1, 1, 1)

                local txt = Drawing.new("Text")
                txt.Visible = false
                txt.Size = 13
                txt.Center = true
                txt.Outline = true
                txt.Color = Color3.new(1, 1, 1)

                espCache[p] = {Box = box, Text = txt}
            end

            local data = espCache[p]
            local char = p.Character
            local rootPart = char and char:FindFirstChild("HumanoidRootPart")
            local humanoid = char and char:FindFirstChild("Humanoid")

            if Config.ESP and char and rootPart and humanoid and humanoid.Health > 0 then
                local role = getRole(p)
                local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

                if onScreen then
                    local size = (Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0)).Y)
                    local h = math.abs(size)
                    local w = h / 2

                    data.Box.Size = Vector2.new(w, h)
                    data.Box.Position = Vector2.new(pos.X - w / 2, pos.Y - h / 2)
                    data.Box.Visible = true

                    data.Text.Text = p.Name .. " [" .. role .. "]"
                    data.Text.Position = Vector2.new(pos.X, pos.Y - h / 2 - 18)
                    data.Text.Visible = true

                    if role == "Murderer" then
                        data.Box.Color = Color3.fromRGB(255, 50, 50)
                        data.Text.Color = Color3.fromRGB(255, 50, 50)
                    elseif role == "Sheriff" or role == "Hero" then
                        data.Box.Color = Color3.fromRGB(50, 150, 255)
                        data.Text.Color = Color3.fromRGB(50, 150, 255)
                    else
                        data.Box.Color = Color3.fromRGB(200, 200, 200)
                        data.Text.Color = Color3.fromRGB(200, 200, 200)
                    end
                else
                    data.Box.Visible = false
                    data.Text.Visible = false
                end
            else
                data.Box.Visible = false
                data.Text.Visible = false
            end
        end
    end
end)

-- ==================== ИСПРАВЛЕННЫЙ WALLBANG ====================
local lastWallbangShoot = 0
RunService.Heartbeat:Connect(function()
    FOVCircle.Visible = Config.Aimbot
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    -- ЛОГИКА WALLBANG (ПРОСТРЕЛ ЧЕРЕЗ СТЕНУ)
    if Config.Wallbang and (os.clock() - lastWallbangShoot >= 0.5) then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local gun = char and (char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun"))
        
        if hrp and gun then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and getRole(p) == "Murderer" and p.Character then
                    local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local humanoid = p.Character:FindFirstChild("Humanoid")
                    
                    if targetHrp and humanoid and humanoid.Health > 0 then
                        lastWallbangShoot = os.clock()
                        
                        task.spawn(function()
                            -- Экипируем пушку если она в рюкзаке
                            if gun.Parent == LocalPlayer.Backpack then
                                gun.Parent = char
                                task.wait(0.02)
                            end
                            
                            -- Сохраняем позицию
                            local oldCFrame = hrp.CFrame
                            
                            -- Отключаем физику для мгновенного перемещения
                            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            
                            -- ТЕЛЕПОРТ К ЦЕЛИ (сквозь стены)
                            -- Ставим чуть перед ним, чтобы шот прошел
                            hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 1.5)
                            
                            -- Ждем минимальное время для регистрации сервером
                            task.wait(0.03)
                            
                            -- ВЫСТРЕЛ
                            pcall(function()
                                gun:Activate()
                            end)
                            
                            -- Возврат на место
                            task.wait(0.05)
                            hrp.CFrame = oldCFrame
                            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        end)
                        break
                    end
                end
            end
        end
    end

    if Config.FakeSpeed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        if hum.MoveDirection.Magnitude > 0 and not hum.Jump then
            hum.WalkSpeed = 16
        else
            hum.WalkSpeed = 90
        end
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end

    if Config.AntiFling and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if hrp.AssemblyLinearVelocity.Magnitude > 250 or hrp.AssemblyAngularVelocity.Magnitude > 250 then
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end

    if Config.FlingTarget and Config.SelectedTarget and Config.SelectedTarget.Character then
        performFling(Config.SelectedTarget.Character)
    end

    if Config.FlingMurderer or Config.FlingSheriff then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local role = getRole(p)
                if (Config.FlingMurderer and role == "Murderer") or (Config.FlingSheriff and role == "Sheriff") then
                    performFling(p.Character)
                end
            end
        end
    end

    if Config.Aimbot then
        local target = nil
        local minDist = math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                if getRole(p) == "Murderer" then
                    local hrp = p.Character.HumanoidRootPart
                    local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                    if dist <= FOVCircle.Radius and dist < minDist then
                        minDist = dist
                        target = hrp
                    end
                end
            end
        end
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)
