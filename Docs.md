# Patrick UI Library

![Roblox](https://img.shields.io/badge/Roblox-Lua-red)
![Lua](https://img.shields.io/badge/Lua-5.1-blue)
![UI Library](https://img.shields.io/badge/UI-Library-success)
![Mobile](https://img.shields.io/badge/Mobile-Friendly-brightgreen)
![Config](https://img.shields.io/badge/Config-Save%2FLoad-yellow)
![Open Source](https://img.shields.io/badge/Open-Source-purple)

A lightweight, clean Roblox UI library designed for **LocalScript / executor environments**.

Built from scratch with:
- Window system
- Tabs
- Buttons
- Toggles (saved)
- Textboxes (saved)
- Mobile open button
- JSON config system

---

## ✨ Features

- 🪟 Draggable window  
- 📑 Tab system  
- 🔘 Buttons  
- 🔁 Toggles with save/load  
- 📝 Textboxes with save/load  
- 📱 Mobile-friendly floating open button  
- 💾 Config system using JSON  
- ⚡ Simple & easy API  

---

## 📦 Installation

```lua
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/vaq4eS2x"))()
```

## 💾 Adding Config system

## Load config

```lua
Library:LoadConfig()
```
## Save config

```lua
Library:SaveConfig()
```
## 🖥 Creating Window

```lua
local window = Library:CreateWindow("Title Name")
```
## 📁 Creating Tabs

```lua
local tab = window:CreateTab("Tab name")
```
## creating button

```lua
tab:CreateButton("Click Me", function()
    print("Button clicked")
end)
```
## Creating toggle

```lua
tab:CreateToggle("Fullbright", false, function(state)
    print(state)
end)
```
## Creating text box

```lua
tab:CreateTextbox("Username", "Player", function(text)
    print(text)
end)
```
## Planned Updates
•Adding Ui animation
•silders and dropdown
•Rich Text
•More soon
