-- Patrick UI Library
-- Made from your original UI script

local PatrickUI = {}

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Theme
local Theme = {
	Background = Color3.fromRGB(0,0,0),
	Accent = Color3.fromRGB(0,0,180),
	Text = Color3.fromRGB(255,255,255),
	Off = Color3.fromRGB(180,0,0),
	On = Color3.fromRGB(0,180,0)
}

-- Create Window
function PatrickUI:CreateWindow(title)
	local gui = Instance.new("ScreenGui")
	gui.Name = "ImafemboylolXD"
	gui.Parent = game.CoreGui

	local f = Instance.new("Frame")
	f.Size = UDim2.new(0.55,0,0.8,0)
	f.Position = UDim2.new(0.25,0,0.1,0)
	f.BackgroundColor3 = Theme.Background
	f.BorderSizePixel = 0
	f.BackgroundTransparency = 0.3
	f.Active = true
	f.Draggable = true
	f.Parent = gui

	local namef = Instance.new("Frame")
	namef.Size = UDim2.new(1,0,0.075,0)
	namef.BackgroundColor3 = Theme.Accent
	namef.BorderSizePixel = 1
	namef.Parent = f

	local name = Instance.new("TextLabel")
	name.Size = UDim2.new(1,0,1,0)
	name.BackgroundTransparency = 1
	name.Text = title or "Patrick UI"
	name.TextColor3 = Theme.Text
	name.Font = Enum.Font.Code
	name.TextSize = 18
	name.Parent = namef

	-- Tabs frame
	local tabf = Instance.new("Frame")
	tabf.Size = UDim2.new(0.3,0,0.92,0)
	tabf.Position = UDim2.new(0,0,0.08,0)
	tabf.BackgroundColor3 = Theme.Background
	tabf.BorderColor3 = Theme.Accent
	tabf.BorderSizePixel = 1
	tabf.Parent = f

	local tabScroll = Instance.new("ScrollingFrame")
	tabScroll.Size = UDim2.new(1,0,1,0)
	tabScroll.CanvasSize = UDim2.new(0,0,0,0)
	tabScroll.ScrollBarThickness = 0
	tabScroll.BackgroundTransparency = 1
	tabScroll.Parent = tabf

	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Padding = UDim.new(0,10)
	tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	tabLayout.Parent = tabScroll

	-- Content frame
	local contentf = Instance.new("Frame")
	contentf.Size = UDim2.new(0.7,0,0.92,0)
	contentf.Position = UDim2.new(0.3,0,0.08,0)
	contentf.BackgroundColor3 = Theme.Background
	contentf.BorderColor3 = Theme.Accent
	contentf.BorderSizePixel = 1
	contentf.Parent = f

	local Tabs = {}

	-- Create Tab
	function Tabs:CreateTab(nameText)
		local tabBtn = Instance.new("TextButton")
		tabBtn.Size = UDim2.new(0.9,0,0.1,0)
		tabBtn.Text = nameText
		tabBtn.BackgroundColor3 = Theme.Background
		tabBtn.BorderColor3 = Theme.Accent
		tabBtn.BorderSizePixel = 1
		tabBtn.TextColor3 = Theme.Text
		tabBtn.Font = Enum.Font.Code
		tabBtn.TextSize = 16
		tabBtn.Parent = tabScroll

		local tabContent = Instance.new("ScrollingFrame")
		tabContent.Size = UDim2.new(1,0,1,0)
		tabContent.CanvasSize = UDim2.new(0,0,0,0)
		tabContent.ScrollBarThickness = 0
		tabContent.BackgroundTransparency = 1
		tabContent.Visible = false
		tabContent.Parent = contentf

		local layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0,5)
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout.Parent = tabContent

		tabBtn.MouseButton1Click:Connect(function()
			for _,v in pairs(contentf:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end
			tabContent.Visible = true
		end)

		local Items = {}

		-- Button
		function Items:AddButton(text, callback)
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1,0,0.1,0)
			btn.Text = text
			btn.BackgroundColor3 = Theme.Background
			btn.BorderColor3 = Theme.Accent
			btn.BorderSizePixel = 1
			btn.TextColor3 = Theme.Text
			btn.Font = Enum.Font.Code
			btn.TextSize = 16
			btn.Parent = tabContent

			btn.MouseButton1Click:Connect(function()
				if callback then callback() end
			end)
		end

		-- Toggle
		function Items:AddToggle(text, callback)
			local toggleFrame = Instance.new("Frame")
			toggleFrame.Size = UDim2.new(1,0,0.1,0)
			toggleFrame.BackgroundColor3 = Theme.Background
			toggleFrame.BorderColor3 = Theme.Accent
			toggleFrame.BorderSizePixel = 1
			toggleFrame.Parent = tabContent

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0.8,0,1,0)
			label.BackgroundTransparency = 1
			label.Text = text
			label.TextColor3 = Theme.Text
			label.Font = Enum.Font.Code
			label.TextSize = 16
			label.Parent = toggleFrame

			local toggle = Instance.new("TextButton")
			toggle.Size = UDim2.new(0.2,0,1,0)
			toggle.Position = UDim2.new(0.8,0,0,0)
			toggle.BackgroundColor3 = Theme.Off
			toggle.Text = ""
			toggle.Parent = toggleFrame

			local state = false
			toggle.MouseButton1Click:Connect(function()
				state = not state
				toggle.BackgroundColor3 = state and Theme.On or Theme.Off
				if callback then callback(state) end
			end)
		end

		-- TextBox
		function Items:AddTextbox(placeholder, callback)
			local boxFrame = Instance.new("Frame")
			boxFrame.Size = UDim2.new(1,0,0.1,0)
			boxFrame.BackgroundColor3 = Theme.Background
			boxFrame.BorderColor3 = Theme.Accent
			boxFrame.BorderSizePixel = 1
			boxFrame.Parent = tabContent

			local box = Instance.new("TextBox")
			box.Size = UDim2.new(0.8,0,1,0)
			box.Text = placeholder
			box.BackgroundColor3 = Theme.Background
			box.BorderColor3 = Theme.Accent
			box.BorderSizePixel = 1
			box.TextColor3 = Theme.Text
			box.Font = Enum.Font.Code
			box.TextSize = 15
			box.Parent = boxFrame

			local enter = Instance.new("TextButton")
			enter.Size = UDim2.new(0.2,0,1,0)
			enter.Position = UDim2.new(0.8,0,0,0)
			enter.Text = "➡"
			enter.BackgroundColor3 = Theme.Background
			enter.TextColor3 = Theme.Text
			enter.Font = Enum.Font.Code
			enter.TextSize = 20
			enter.Parent = boxFrame

			enter.MouseButton1Click:Connect(function()
				if callback then callback(box.Text) end
			end)
		end

		return Items
	end

	return Tabs
end

return PatrickUI
