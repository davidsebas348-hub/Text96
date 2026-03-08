-- ======================
-- SBS HUB COMPLETO FINAL (NPC OR DIE)(MODO PVP)
-- ======================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local buttonStates = {}
-- BOTONES QUE NO SERAN TOGLE
local noToggleButtons = {
    ["YOUTUBE:SBS HUB"] = true,
    ["SUSCRIBETE:)"] = true,
    ["Gaze Emote"] = true,
    ["LOCALPLAYER"] = true,
    ["DESYNC"] = true,
    ["Fps Boost"] = true,
    ["FULL BRIGHT"] = true,
    ["COMPLETE OBBY"] = true,
    ["AUTO COLLECT CASH (FARM)"] = true,
    ["REMOVE INVISIBLE WALLS"] = true,
}

-- BOTONES SIN EFECTO VERDE
local noGreenFlash = {
    ["SUSCRIBETE:)"] = true
}
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "SBS_HUB"
screenGui.ResetOnSpawn = false
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0,500,0,350)
mainFrame.Position = UDim2.new(0.5,-250,0.5,-175)
mainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
mainFrame.BorderSizePixel = 0

-- ======================
-- RESIZE CORNER
-- ======================
local resizeCorner = Instance.new("Frame", mainFrame)
resizeCorner.Size = UDim2.new(0,20,0,20)
resizeCorner.Position = UDim2.new(1,-20,1,-20)
resizeCorner.BackgroundTransparency = 0.5
resizeCorner.BackgroundColor3 = Color3.fromRGB(255,255,255)
resizeCorner.BorderSizePixel = 0

-- ======================
-- RESIZE LOGIC
-- ======================
do
    local dragging, dragStart, startSize
    local function updateSize(input)
        local delta = input.Position - dragStart
        local newWidth = math.max(100, startSize.X + delta.X) -- mínimo ancho 100
        local newHeight = math.max(100, startSize.Y + delta.Y) -- mínimo alto 100
        mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
    resizeCorner.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startSize = Vector2.new(mainFrame.AbsoluteSize.X, mainFrame.AbsoluteSize.Y)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSize(input)
        end
    end)
end


local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(255,255,255)
stroke.Thickness = 2

do
    local dragging, dragStart, startPos, dragInput
    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)
end

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundColor3 = Color3.fromRGB(0,0,0)
title.Text = "SBS HUB | NPC OR DIE"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
local line = Instance.new("Frame", mainFrame)
line.Size = UDim2.new(1,0,0,2)
line.Position = UDim2.new(0,0,0,50)
line.BackgroundColor3 = Color3.fromRGB(255,255,255)

local leftFrame = Instance.new("ScrollingFrame", mainFrame)
leftFrame.Size = UDim2.new(0,150,1,-52)
leftFrame.Position = UDim2.new(0,0,0,52)
leftFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
leftFrame.BorderSizePixel = 0
leftFrame.ScrollBarThickness = 6
leftFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
local rightFrame = Instance.new("ScrollingFrame", mainFrame)
rightFrame.Size = UDim2.new(1,-150,1,-52)
rightFrame.Position = UDim2.new(0,150,0,52)
rightFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
rightFrame.BorderSizePixel = 0
local midLine = Instance.new("Frame", mainFrame)
midLine.Size = UDim2.new(0,2,1,-52)
midLine.Position = UDim2.new(0,150,0,52)
midLine.BackgroundColor3 = Color3.fromRGB(255,255,255)

local function createMenuButton(parent,text,y,callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-20,0,30)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(15,15,15)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BorderSizePixel = 0
    
    b.MouseButton1Click:Connect(callback)
end

local function createButton(parent,text,y,callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-20,0,30)
    b.Position = UDim2.new(0,10,0,y)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BorderSizePixel = 0
    
    local isToggle = not noToggleButtons[text]
    
    if isToggle then
        
        if buttonStates[text] == nil then
            buttonStates[text] = false
        end
        
        local function updateVisual()
            if buttonStates[text] then
                b.Text = text .. "  [ON]"
                b.BackgroundColor3 = Color3.fromRGB(0,120,0)
            else
                b.Text = text .. "  [OFF]"
                b.BackgroundColor3 = Color3.fromRGB(20,20,20)
            end
        end
        
        updateVisual()
        
        b.MouseButton1Click:Connect(function()
            buttonStates[text] = not buttonStates[text]
            updateVisual()
            callback(buttonStates[text]) -- manda true o false
        end)
        
    else
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(20,20,20)
        
    b.MouseButton1Click:Connect(function()
        if not noGreenFlash[text] then
            local oldColor = b.BackgroundColor3
            b.BackgroundColor3 = Color3.fromRGB(0,120,0)
            task.delay(1,function()
                if b then
                    b.BackgroundColor3 = oldColor
                end
            end)
        end
        callback()
    end)
    end -- ← ESTE END FALTABA
end
-- ======================
-- SCROLL POR SUBMENU
-- ======================
local scrollConfig = {
    ["MAIN"] = true,
    ["ESP"] = false,
    ["COMBAT"] = false,
    ["EMOTES"] = false,
    ["CASH"] = false,
    ["OBBY"] = false,
    ["Fps"] = false,
    ["YOUTUBE"] = false
}
-- ======================
-- MENUS
-- ======================
local menuOrder = {"MAIN","COMBAT","ESP","EMOTES","CASH","OBBY","Fps","YOUTUBE"}
local menuData = {
    ["MAIN"] = {
        "LOCALPLAYER",
        "FORCE SPEED",
        "DESYNC",
        "INVISIBLE (It lasts 5 seconds)",
        "FULL BRIGHT",
        "INFINITY STAMINA (OP)",
        "X-RAY",
        "REMOVE INVISIBLE WALLS",
        "SHIFT LOCK",
        "TP TOOL",
    },
    ["COMBAT"] = {
        "AIMBOT TOTAL",
        "AUTO SHOOT ENEMIES",
    },
    ["ESP"] = {
        "ESP TO ENEMIES",
        "ESP A TEAM",
    },
    ["EMOTES"] = {
        "Gaze Emote",
        "SEMI-INVISIBLE"
    },
    ["CASH"] = {
        "AUTO COLLECT CASH",
        "AUTO COLLECT CASH (SLOW)",
        "AUTO COLLECT CASH (FARM)"
    },
    ["OBBY"] = {
        "AUTO OBBY",
        "COMPLETE OBBY",
    },
    ["Fps"] = {
        "Fps Boost"
    },
    ["YOUTUBE"] = {
        "YOUTUBE:SBS HUB",
        "SUSCRIBETE:)"
    }
}

local function clearFrame(frame)
    for _,v in pairs(frame:GetChildren()) do
        if v:IsA("TextButton") or v:IsA("TextLabel") then
            v:Destroy()
        end
    end
    frame.CanvasPosition = Vector2.new(0,0)
end

for i,menu in ipairs(menuOrder) do
    createMenuButton(leftFrame, menu, 10+(i-1)*35, function()
        clearFrame(rightFrame)
        -- aplicar scroll SOLO a este submenu
        if scrollConfig[menu] then
            rightFrame.ScrollBarThickness = 6
            rightFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        else
            rightFrame.ScrollBarThickness = 0
            rightFrame.AutomaticCanvasSize = Enum.AutomaticSize.None
            rightFrame.CanvasSize = UDim2.new(0,0,0,0)
        end
        local titleLabel = Instance.new("TextLabel", rightFrame)
        titleLabel.Size = UDim2.new(1,0,0,30)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = menu
        titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 18
        local oy = 40
        for _,opt in ipairs(menuData[menu]) do
    createButton(rightFrame,opt,oy,function(state)
                -- BOTONES CON SU FUNCION
                 if opt == "ESP TO ENEMIES" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text90/refs/heads/main/Text90.lua"))()
                    elseif opt == "ESP A TEAM" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text89/refs/heads/main/Text89.lua"))()
                    elseif opt == "AIMBOT TOTAL" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text93/refs/heads/main/Text93.lua"))()
                    elseif opt == "AUTO SHOOT ENEMIES" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text86/refs/heads/main/Text86.lua"))()
                    elseif opt == "FORCE SPEED" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text95/refs/heads/main/Text95.lua"))()
                    elseif opt == "INFINITY STAMINA (OP)" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text76/refs/heads/main/Text76.lua"))()
                    elseif opt == "AUTO OBBY" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text71/refs/heads/main/Text71.lua"))()
                    elseif opt == "COMPLETE OBBY" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text72/refs/heads/main/Text72.lua"))()
                    elseif opt == "AUTO COLLECT CASH (FARM)" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text73/main/Text73.lua"))()
                elseif opt == "AUTO COLLECT CASH" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text363/refs/heads/main/Text363.lua"))()
                elseif opt == "AUTO COLLECT CASH (SLOW)" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text364/refs/heads/main/Text364.lua"))()
                elseif opt == "REMOVE INVISIBLE WALLS" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text365/refs/heads/main/Text365.lua"))()
                    elseif opt == "SHIFT LOCK" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Shift-lock/refs/heads/main/Shift_Lock_.lua"))()
                elseif opt == "SEMI-INVISIBLE" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text335/refs/heads/main/Text335.lua"))()
                elseif opt == "INVISIBLE (It lasts 5 seconds)" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text366/refs/heads/main/Text366.lua",true))()
                elseif opt == "DESYNC" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text24/refs/heads/main/Text23.lua",true))()
                elseif opt == "FULL BRIGHT" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text279/refs/heads/main/Text279.lua"))()
                elseif opt == "LOCALPLAYER" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text8/refs/heads/main/Text8.lua"))()
                elseif opt == "Fps Boost" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Fps-Boost-/refs/heads/main/FPS_BOOST_UNIVERSAL.lua"))()
                elseif opt == "YOUTUBE:SBS HUB" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Copiar-canal/refs/heads/main/Suscribete.lua"))()
                elseif opt == "TP TOOL" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text331/refs/heads/main/Text331.lua"))()
                elseif opt == "X-RAY" then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/davidsebas348-hub/Text147/refs/heads/main/Text147.lua"))()
                elseif opt == "Gaze Emote" then
                    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gaze-emote-74592"))()          
                end
            end)
            oy += 40
        end
    end)
end
-- ICONO SBS PARA ABRIR/CERRAR (MOVIBLE)
local toggle = Instance.new("TextButton", screenGui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(1,-80,0,20)
toggle.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggle.Text = "SBS"
toggle.TextColor3 = Color3.fromRGB(255,255,255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 24
toggle.BorderSizePixel = 0
local corner = Instance.new("UICorner", toggle)
corner.CornerRadius = UDim.new(0.3,0)
do
    local dragging, dragStart, startPos, dragInput
    local function update(input)
        local delta = input.Position - dragStart
        toggle.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = toggle.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    toggle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)
end
local open = true
toggle.MouseButton1Click:Connect(function()
    open = not open
    mainFrame.Visible = open
end)
