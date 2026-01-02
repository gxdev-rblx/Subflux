--// Array List UI Library
--// Fully LocalScript

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local spinEnabled = false
local spinSpeed = 720 -- degrees per second
local noclipEnabled = false

RunService.RenderStepped:Connect(function(dt)
	if not spinEnabled then return end

	local character = player.Character
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChild("Humanoid")

	if root and humanoid and humanoid.Health > 0 then
		-- Rotate character smoothly without breaking movement
		root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(spinSpeed * dt), 0)
	end
end)

--// ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "ArrayListGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--// Container
local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(1, 0)
container.Position = UDim2.new(1, -10, 0, 10)
container.Size = UDim2.new(0, 250, 1, -20)
container.BackgroundTransparency = 1
container.Parent = gui

--// UIListLayout
local layout = Instance.new("UIListLayout")
layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 4)
layout.Parent = container

--// Array storage
local ArrayList = {}
local States = {}

--// Create entry
local function createItem(name)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 22)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Right
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.Font = Enum.Font.GothamBold
	label.TextSize = 16
	label.Text = name
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.LayoutOrder = -#ArrayList
	label.Parent = container

	-- Shadow
	local shadow = Instance.new("TextLabel")
	shadow.Size = UDim2.new(1, 0, 1, 0)
	shadow.Position = UDim2.new(0, 1, 0, 1)
	shadow.BackgroundTransparency = 1
	shadow.TextXAlignment = Enum.TextXAlignment.Right
	shadow.Font = label.Font
	shadow.TextSize = label.TextSize
	shadow.Text = label.Text
	shadow.TextColor3 = Color3.fromRGB(0, 0, 0)
	shadow.ZIndex = label.ZIndex - 1
	shadow.Parent = label

	ArrayList[name] = label
end

--// Remove entry
local function removeItem(name)
	if ArrayList[name] then
		ArrayList[name]:Destroy()
		ArrayList[name] = nil
	end
end

--// Public API
local ArrayLibrary = {}

function ArrayLibrary:Set(name, state)
	States[name] = state

	if state then
		if not ArrayList[name] then
			createItem(name)
		end
	else
		removeItem(name)
	end
end

function ArrayLibrary:Toggle(name)
	self:Set(name, not States[name])
end

function ArrayLibrary:Get(name)
	return States[name]
end

game:GetService("RunService").Heartbeat:Connect(function()
	if autoJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
		local humanoid = player.Character.Humanoid
		if humanoid:GetState() == Enum.HumanoidStateType.Physics then
			humanoid:ChangeState(Enum.HumanoidStateType.Seated)
		end

		-- Check if the player is on the ground
		if humanoid:GetState() == Enum.HumanoidStateType.Seated then
			humanoid.Jump = true
		end
	end
end)


_G.HeadSize = 0
_G.Disabled = false
 
game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)


-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = nil
local HumanoidRootPart = nil

-- Settings
local ROTATE_RANGE = 50 -- studs

-- State
local RotateEnabled = false
local RotateConnection = nil

-- Update character references
local function UpdateCharacter()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end

UpdateCharacter()
LocalPlayer.CharacterAdded:Connect(UpdateCharacter)

-- Get nearest player
local function GetNearestPlayer()
    local closest = nil
    local shortest = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer
            and player.Character
            and player.Character:FindFirstChild("HumanoidRootPart")
            and player.Character:FindFirstChild("Humanoid")
            and player.Character.Humanoid.Health > 0 then

            local distance = (HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortest and distance <= ROTATE_RANGE then
                shortest = distance
                closest = player
            end
        end
    end

    return closest
end

-- Rotate loop
local function StartRotate()
    if RotateConnection then return end

    RotateConnection = RunService.RenderStepped:Connect(function()
        if not RotateEnabled then return end
        if not Character or not HumanoidRootPart then return end

        local target = GetNearestPlayer()
        if target then
            local targetPos = target.Character.HumanoidRootPart.Position
            local lookVector = (targetPos - HumanoidRootPart.Position).Unit
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
        end
    end)
end

local function StopRotate()
    if RotateConnection then
        RotateConnection:Disconnect()
        RotateConnection = nil
    end
end

-- Public toggle function
function SetRotate(state)
    RotateEnabled = state

    if state then
        StartRotate()
    else
        StopRotate()
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/gxdev-rblx/Subflux/refs/heads/main/Files/obfuscated_script-1766924627891.lua.txt"))()

local Window = UI:CreateWindow("SubFlux [Universal][Version 1]")


------------------------------------------------
-- MOBILE TOGGLE BUTTON (LOCAL SCRIPT ONLY)
------------------------------------------------

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Find the UI created by the module
local mainGui = game.CoreGui:WaitForChild("patrickGui")

-- Create mobile button GUI
local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "PatrickMobileToggle"
mobileGui.Parent = game.CoreGui
mobileGui.ResetOnSpawn = false

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.1, 0, 0.1, 0)
toggleBtn.Position = UDim2.new(0, 15, 0.5, -27)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.BorderColor3 = Color3.fromRGB(0, 0, 255)
toggleBtn.BorderSizePixel = 1
toggleBtn.Text = "Toggle Ui"
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Font = Enum.Font.Code
toggleBtn.TextSize = 10
toggleBtn.AutoButtonColor = false
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Parent = mobileGui

-- Toggle logic
local open = true

toggleBtn.MouseButton1Click:Connect(function()
	open = not open
	mainGui.Enabled = open
end)





local MainTab = Window:CreateTab("Combat")
local MotionTab = Window:CreateTab("Motion")
local UtilityTab = Window:CreateTab("Utility")


MainTab:AddToggle("Killaura [Universal]", function(state)
	ArrayLibrary:Set("Killaura", state)
    SetRotate(state)
end)

MainTab:AddToggle("Speed", function(state)
	ArrayLibrary:Set("Speed", state)
end)

MainTab:AddToggle("Hitbox", function(state)
	ArrayLibrary:Set("Hitbox", state)
    _G.Disabled = (state) 
end)

MainTab:AddTextbox("Hitbox Size", function(text)
	_G.HeadSize = (text) 
end)

MotionTab:AddTextbox("WalkSpeed", function(text)
	humanoid.WalkSpeed = (text) 
end)

MotionTab:AddTextbox("JumpPower", function(text)
	humanoid.JumpPower = (text) 
end)

MotionTab:AddTextbox("Gravity", function(text)
	game.Workspace.Gravity = (text)
end)


MotionTab:AddToggle("Bhop", function(state)
	autoJumpEnabled = state
    ArrayLibrary:Set("Bhop", state)
end)

MotionTab:AddToggle("Spinbot", function(state)
	spinEnabled = state
    ArrayLibrary:Set("spinbot", state)
end)

MotionTab:AddToggle("No Clip", function(state)
	noclipEnabled = state
    ArrayLibrary:Set("No clip", state)
end)

RunService.Stepped:Connect(function()
	local character = player.Character
	if not character then return end

	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = not noclipEnabled
		end
	end
end)

UtilityTab:AddButton("Ping Counter", function()	           loadstring(game:HttpGet("https://pastebin.com/raw/MvKKJ331",true))() 
end)

UtilityTab:AddButton("Fps Counter", function()	loadstring(game:HttpGet("https://pastebin.com/raw/ySHJdZpb",true))()
end)

