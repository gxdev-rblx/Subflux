--// SubFlux V2 UI Library
local SubFlux = {}
SubFlux.__index = SubFlux

--// Theme presets
local Themes = {
	Blue = {
		Border = Color3.fromRGB(0, 0, 255),
		Header = Color3.fromRGB(0, 0, 180)
	},
	Red = {
		Border = Color3.fromRGB(255, 0, 0),
		Header = Color3.fromRGB(180, 0, 0)
	},
	Green = {
		Border = Color3.fromRGB(0, 255, 0),
		Header = Color3.fromRGB(0, 180, 0)
	},
	Purple = {
		Border = Color3.fromRGB(170, 0, 255),
		Header = Color3.fromRGB(120, 0, 180)
	}
}

--// Create Window
function SubFlux:CreateWindow(title)
	local self = setmetatable({}, SubFlux)
	self.Borders = {}

	-- ScreenGui
	local gui = Instance.new("ScreenGui")
	gui.Name = "SubFluxV2"
	gui.Parent = game.CoreGui

	-- Main Frame
	local f = Instance.new("Frame")
	f.Size = UDim2.new(0.55, 0, 0.8, 0)
	f.Position = UDim2.new(0.25, 0, 0.1, 0)
	f.BackgroundColor3 = Color3.new(0, 0, 0)
	f.BackgroundTransparency = 0.3
	f.BorderSizePixel = 1
	f.Active = true
	f.Draggable = true
	f.Parent = gui
	table.insert(self.Borders, f)

	-- Header
	local namef = Instance.new("Frame")
	namef.Size = UDim2.new(1, 0, 0.075, 0)
	namef.BackgroundColor3 = Themes.Blue.Header
	namef.BorderSizePixel = 1
	namef.Parent = f
	table.insert(self.Borders, namef)
	self.Header = namef

	local name = Instance.new("TextLabel")
	name.Size = UDim2.new(0.95, 0, 1, 0)
	name.Position = UDim2.new(0.03, 0, 0, 0)
	name.BackgroundTransparency = 1
	name.Text = title or "SubFlux V2"
	name.TextColor3 = Color3.new(1,1,1)
	name.Font = Enum.Font.Code
	name.TextSize = 16
	name.TextXAlignment = Left
	name.TextYAlignment = Center
	name.Parent = namef

	-- Tab Frame
	local tabf = Instance.new("Frame")
	tabf.Size = UDim2.new(0.3, 0, 0.92, 0)
	tabf.Position = UDim2.new(0, 0, 0.08, 0)
	tabf.BackgroundColor3 = Color3.new(0, 0, 0)
	tabf.BorderSizePixel = 1
	tabf.Parent = f
	table.insert(self.Borders, tabf)

	local tabSF = Instance.new("ScrollingFrame")
	tabSF.Size = UDim2.new(1, 0, 1, 0)
	tabSF.ScrollBarThickness = 0
	tabSF.BackgroundTransparency = 1
	tabSF.Parent = tabf

	local tabLayout = Instance.new("UIListLayout", tabSF)
	tabLayout.Padding = UDim.new(0, 10)
	tabLayout.HorizontalAlignment = Center

	-- Content Frame
	local contentf = Instance.new("Frame")
	contentf.Size = UDim2.new(0.7, 0, 0.92, 0)
	contentf.Position = UDim2.new(0.3, 0, 0.08, 0)
	contentf.BackgroundColor3 = Color3.new(0, 0, 0)
	contentf.BorderSizePixel = 1
	contentf.Parent = f
	table.insert(self.Borders, contentf)

	self.GUI = gui
	self.TabSF = tabSF
	self.ContentFrame = contentf
	self.Tabs = {}

	-- Default theme
	self:SetTheme("Blue")

	return self
end

--// Theme switcher
function SubFlux:SetTheme(themeName)
	local theme = Themes[themeName]
	if not theme then return end

	for _, obj in pairs(self.Borders) do
		obj.BorderColor3 = theme.Border
	end

	self.Header.BackgroundColor3 = theme.Header
end

--// Create Tab
function SubFlux:CreateTab(name)
	local tab = {}

	local tabBtn = Instance.new("TextButton")
	tabBtn.Size = UDim2.new(0.9, 0, 0.1, 0)
	tabBtn.Text = name
	tabBtn.BackgroundColor3 = Color3.new(0,0,0)
	tabBtn.TextColor3 = Color3.new(1,1,1)
	tabBtn.Font = Enum.Font.Code
	tabBtn.TextSize = 16
	tabBtn.Parent = self.TabSF
	table.insert(self.Borders, tabBtn)

	local sf = Instance.new("ScrollingFrame")
	sf.Size = UDim2.new(1,0,1,0)
	sf.ScrollBarThickness = 0
	sf.BackgroundTransparency = 1
	sf.Visible = false
	sf.Parent = self.ContentFrame

	local layout = Instance.new("UIListLayout", sf)
	layout.Padding = UDim.new(0, 5)
	layout.HorizontalAlignment = Center

	tabBtn.MouseButton1Click:Connect(function()
		for _, t in pairs(self.Tabs) do
			t.Frame.Visible = false
		end
		sf.Visible = true
	end)

	tab.Frame = sf
	table.insert(self.Tabs, tab)

	if #self.Tabs == 1 then sf.Visible = true end

	-- Button
	function tab:AddButton(text, cb)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1,0,0.1,0)
		b.Text = text
		b.BackgroundColor3 = Color3.new(0,0,0)
		b.TextColor3 = Color3.new(1,1,1)
		b.Font = Enum.Font.Code
		b.TextSize = 16
		b.Parent = sf
		table.insert(self.Borders, b)

		b.MouseButton1Click:Connect(function()
			pcall(cb)
		end)
	end

	-- Toggle
	function tab:AddToggle(text, default, cb)
		local state = default or false

		local f = Instance.new("Frame")
		f.Size = UDim2.new(1,0,0.1,0)
		f.BackgroundColor3 = Color3.new(0,0,0)
		f.Parent = sf
		table.insert(self.Borders, f)

		local l = Instance.new("TextLabel")
		l.Size = UDim2.new(0.75,0,1,0)
		l.Position = UDim2.new(0.03,0,0,0)
		l.Text = text
		l.TextColor3 = Color3.new(1,1,1)
		l.Font = Enum.Font.Code
		l.TextSize = 16
		l.BackgroundTransparency = 1
		l.TextXAlignment = Left
		l.Parent = f

		local t = Instance.new("TextButton")
		t.Size = UDim2.new(0.2,0,1,0)
		t.Position = UDim2.new(0.8,0,0,0)
		t.Text = ""
		t.BackgroundColor3 = state and Color3.new(0,1,0) or Color3.new(1,0,0)
		t.Parent = f
		table.insert(self.Borders, t)

		t.MouseButton1Click:Connect(function()
			state = not state
			t.BackgroundColor3 = state and Color3.new(0,1,0) or Color3.new(1,0,0)
			pcall(cb, state)
		end)
	end

	return tab
end

return SubFlux
