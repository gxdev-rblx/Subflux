--// Subflux UI Library //--

---// Made with Patrick GUI maker 0.5// ---
---//Owner TG@Red01ma //  ---


local Library = {}
Library.__index = Library

-- SERVICES
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

-- CONFIG
Library.ConfigFile = "subflux_ui_config.json"
Library.Flags = {}

-- SAVE CONFIG
function Library:SaveConfig()
    if writefile then
        writefile(self.ConfigFile, HttpService:JSONEncode(self.Flags))
    end
end

-- LOAD CONFIG
function Library:LoadConfig()
    if readfile and isfile and isfile(self.ConfigFile) then
        self.Flags = HttpService:JSONDecode(readfile(self.ConfigFile))
    end
end

-- MOBILE OPEN BUTTON
function Library:CreateMobileButton(gui, mainFrame)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,60,0,60)
    btn.Position = UDim2.new(0,20,0.5,-30)
    btn.Text = "≡"
    btn.Font = Enum.Font.Code
    btn.TextSize = 28
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Active = true
    btn.Draggable = true
    btn.Parent = gui

    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)

    btn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)
end

-- CREATE WINDOW
function Library:CreateWindow(title)
    local self = setmetatable({}, Library)

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "LoaderisU3ViZmx1eFYxMW9udG9w"
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")

    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.55, 0, 0.75, 0)
    frame.Position = UDim2.new(0.25, 0, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
    frame.BackgroundTransparency = 0.4
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", frame).Thickness = 2

    -- Mobile button
    self:CreateMobileButton(gui, frame)

    -- Title Bar
    local titleBar = Instance.new("Frame", frame)
    titleBar.Size = UDim2.new(1,0,0.15,0)
    titleBar.BackgroundTransparency = 0.4
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", titleBar).Thickness = 2

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(0.7,0,1,0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "UI"
    titleLabel.Font = Enum.Font.Code
    titleLabel.TextSize = 15
    titleLabel.TextColor3 = Color3.fromRGB(0,0,200)

    local close = Instance.new("TextButton", titleBar)
    close.Size = UDim2.new(0.1,0,1,0)
    close.Position = UDim2.new(0.9,0,0,0)
    close.Text = "X"
    close.BackgroundColor3 = Color3.fromRGB(255,0,0)
    close.TextColor3 = Color3.new(1,1,1)
    close.Font = Enum.Font.Legacy
    Instance.new("UICorner", close)

    close.MouseButton1Click:Connect(function()
        frame.Visible = false
    end)

    -- Tabs Frame
    local tabFrame = Instance.new("Frame", frame)
    tabFrame.Size = UDim2.new(0.3,0,0.84,0)
    tabFrame.Position = UDim2.new(0,0,0.16,0)
    tabFrame.BackgroundTransparency = 0.4
    Instance.new("UICorner", tabFrame).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", tabFrame).Thickness = 2

    local tabScroll = Instance.new("ScrollingFrame", tabFrame)
    tabScroll.Size = UDim2.new(1,0,1,0)
    tabScroll.ScrollBarThickness = 0
    tabScroll.CanvasSize = UDim2.new(0,0,0,0)
    tabScroll.BackgroundTransparency = 1

    local tabLayout = Instance.new("UIListLayout", tabScroll)
    tabLayout.Padding = UDim.new(0,10)
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabScroll.CanvasSize = UDim2.new(0,0,0,tabLayout.AbsoluteContentSize.Y + 10)
    end)

    -- Content Frame
    local contentFrame = Instance.new("Frame", frame)
    contentFrame.Size = UDim2.new(0.69,0,0.84,0)
    contentFrame.Position = UDim2.new(0.31,0,0.16,0)
    contentFrame.BackgroundTransparency = 0.4
    Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", contentFrame).Thickness = 2

    self.Gui = gui
    self.TabScroll = tabScroll
    self.ContentFrame = contentFrame

    return self
end

-- CREATE TAB
function Library:CreateTab(name)
    local tab = {}

    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1,0,0.1,0)
    tabButton.Text = name
    tabButton.Font = Enum.Font.Code
    tabButton.TextSize = 16
    tabButton.BackgroundTransparency = 0.1
    tabButton.Parent = self.TabScroll
    Instance.new("UICorner", tabButton)

    local content = Instance.new("ScrollingFrame", self.ContentFrame)
    content.Size = UDim2.new(1,0,1,0)
    content.ScrollBarThickness = 0
    content.CanvasSize = UDim2.new(0,0,0,0)
    content.BackgroundTransparency = 1
    content.Visible = false

    local layout = Instance.new("UIListLayout", content)
    layout.Padding = UDim.new(0,10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        content.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
    end)

    tabButton.MouseButton1Click:Connect(function()
        for _,v in pairs(self.ContentFrame:GetChildren()) do
            if v:IsA("ScrollingFrame") then
                v.Visible = false
            end
        end
        content.Visible = true
    end)

    -- BUTTON
    function tab:CreateButton(text, callback)
        local btn = Instance.new("TextButton", content)
        btn.Size = UDim2.new(1,0,0.1,0)
        btn.Text = text
        btn.Font = Enum.Font.Code
        btn.TextSize = 16
        btn.BackgroundTransparency = 0.1
        Instance.new("UICorner", btn)

        btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

    -- TOGGLE
    function tab:CreateToggle(text, default, callback)
        local flag = text:gsub("%s+", "_"):lower()
        local toggled = Library.Flags[flag]
        if toggled == nil then toggled = default or false end
        Library.Flags[flag] = toggled

        local frame = Instance.new("Frame", content)
        frame.Size = UDim2.new(1,0,0.1,0)
        frame.BackgroundTransparency = 0.1
        Instance.new("UICorner", frame)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.7,0,1,0)
        label.Position = UDim2.new(0.05,0,0,0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.Font = Enum.Font.Code
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left

        local toggle = Instance.new("TextButton", frame)
        toggle.Size = UDim2.new(0.2,0,0.6,0)
        toggle.Position = UDim2.new(0.75,0,0.2,0)
        toggle.Text = ""
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

        local function update()
            toggle.BackgroundColor3 = toggled and Color3.fromRGB(0,170,0) or Color3.fromRGB(150,150,150)
            if callback then callback(toggled) end
        end

        toggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            Library.Flags[flag] = toggled
            update()
        end)

        update()
    end

    -- TEXTBOX
    function tab:CreateTextbox(text, default, callback)
        local flag = text:gsub("%s+", "_"):lower()
        local value = Library.Flags[flag] or default or ""
        Library.Flags[flag] = value

        local frame = Instance.new("Frame", content)
        frame.Size = UDim2.new(1,0,0.1,0)
        frame.BackgroundTransparency = 0.1
        Instance.new("UICorner", frame)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.4,0,1,0)
        label.Position = UDim2.new(0.05,0,0,0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.Font = Enum.Font.Code
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left

        local box = Instance.new("TextBox", frame)
        box.Size = UDim2.new(0.45,0,0.6,0)
        box.Position = UDim2.new(0.5,0,0.2,0)
        box.Text = value
        box.Font = Enum.Font.Code
        box.TextSize = 14
        box.ClearTextOnFocus = false
        Instance.new("UICorner", box)

        box.FocusLost:Connect(function()
            Library.Flags[flag] = box.Text
            if callback then callback(box.Text) end
        end)
    end

    return tab
end

return Library