
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Settings = {Aimbot={Enabled=false,FOV=150,Smooth=0.12},ESP={Enabled=false},Visuals={FOV=false}}
local GUI = nil
local ESPBoxes = {}
local FOVCircle = Drawing.new("Circle")

FOVCircle.Radius = 150
FOVCircle.Color = Color3.new(0,1,0)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Transparency = 0.8
FOVCircle.NumSides = 50
FOVCircle.Visible = false

-- PAINEL MODERNO (ABRE COM LEFTCTRL)
local function CreateGUI()
    GUI = Instance.new("ScreenGui")
    GUI.Name = "HackerAI"
    GUI.Parent = LocalPlayer.PlayerGui
    GUI.ResetOnSpawn = false
    
    local Frame = Instance.new("Frame")
    Frame.Parent = GUI
    Frame.BackgroundColor3 = Color3.new(0.1,0.1,0.15)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.5,-150,0.5,-200)
    Frame.Size = UDim2.new(0,300,0,400)
    Frame.Active = true
    Frame.Draggable = true
    Frame.Visible = false
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,12)
    Corner.Parent = Frame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.new(0,0.7,1)
    Stroke.Thickness = 2
    Stroke.Parent = Frame
    
    -- Título
    local Title = Instance.new("TextLabel")
    Title.Parent = Frame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1,0,0,50)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "🎯 HACKERAI UNIVERSAL"
    Title.TextColor3 = Color3.new(1,1,1)
    Title.TextSize = 18
    Title.TextStrokeTransparency = 0
    
    -- Toggles
    local function Toggle(text,y,callback)
        local TFrame = Instance.new("Frame")
        TFrame.Parent = Frame
        TFrame.BackgroundColor3 = Color3.new(0.2,0.2,0.25)
        TFrame.BorderSizePixel = 0
        TFrame.Position = UDim2.new(0,20,0,y)
        TFrame.Size = UDim2.new(1,-40,0,40)
        
        local TCorner = Instance.new("UICorner",TFrame)
        TCorner.CornerRadius = UDim.new(0,8)
        
        local TLabel = Instance.new("TextLabel")
        TLabel.Parent = TFrame
        TLabel.BackgroundTransparency = 1
        TLabel.Size = UDim2.new(1,-60,1,0)
        TLabel.Font = Enum.Font.Gotham
        TLabel.Text = text
        TLabel.TextColor3 = Color3.new(1,1,1)
        TLabel.TextSize = 14
        TLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local Btn = Instance.new("TextButton")
        Btn.Parent = TFrame
        Btn.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
        Btn.Size = UDim2.new(0,40,0,25)
        Btn.Position = UDim2.new(1,-50,0.5,-12.5)
        Btn.Text = "OFF"
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 12
        
        local BtnCorner = Instance.new("UICorner",Btn)
        BtnCorner.CornerRadius = UDim.new(0,6)
        
        local state = false
        Btn.MouseButton1Click:Connect(function()
            state = not state
            Btn.Text = state and "ON" or "OFF"
            Btn.BackgroundColor3 = state and Color3.new(0,0.8,0) or Color3.new(0.8,0.2,0.2)
            callback(state)
        end)
    end
    
    Toggle("🎯 Aimbot",60,function(v) Settings.Aimbot.Enabled=v end)
    Toggle("👁️ ESP",110,function(v) Settings.ESP.Enabled=v end)
    Toggle("📍 FOV",160,function(v) Settings.Visuals.FOV=v end)
    
    -- Info
    local Info = Instance.new("TextLabel")
    Info.Parent = Frame
    Info.BackgroundTransparency = 1
    Info.Position = UDim2.new(0,20,0,220)
    Info.Size = UDim2.new(1,-40,0,150)
    Info.Font = Enum.Font.Gotham
    Info.Text = "🎮 LEFTCTRL = Toggle GUI\n\n🔥 RightShift = Aimbot\n👁️ LeftShift = ESP\n📍 X = FOV"
    Info.TextColor3 = Color3.new(0.7,0.9,1)
    Info.TextSize = 13
    Info.TextYAlignment = Enum.TextYAlignment.Top
    
    -- Fechar
    local Close = Instance.new("TextButton")
    Close.Parent = Frame
    Close.BackgroundColor3 = Color3.new(1,0.2,0.2)
    Close.BorderSizePixel = 0
    Close.Position = UDim2.new(1,-35,0,10)
    Close.Size = UDim2.new(0,25,0,25)
    Close.Font = Enum.Font.GothamBold
    Close.Text = "✕"
    Close.TextColor3 = Color3.new(1,1,1)
    Close.TextSize = 16
    local CCorner = Instance.new("UICorner",Close)
    CCorner.CornerRadius = UDim.new(0,12)
    
    Close.MouseButton1Click:Connect(function()
        Frame.Visible = false
    end)
end

-- Aimbot
local function GetClosest()
    local closest,dist = nil,math.huge
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            local pos,onscreen = Camera:WorldToViewportPoint(head.Position)
            if onscreen then
                local distance = (Vector2.new(pos.X,pos.Y)-Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)).Magnitude
                if distance<dist and distance<Settings.Aimbot.FOV then
                    dist=distance
                    closest=head
                end
            end
        end
    end
    return closest
end

-- ESP
local function UpdateESP()
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            local pos,onscreen = Camera:WorldToViewportPoint(head.Position)
            if onscreen and Settings.ESP.Enabled then
                if not ESPBoxes[p] then
                    ESPBoxes[p] = Drawing.new("Square")
                    ESPBoxes[p].Color = Color3.new(0,1,0)
                    ESPBoxes[p].Thickness = 2
                    ESPBoxes[p].Filled = false
                end
                local size = (Camera:WorldToViewportPoint(head.Position-Vector3.new(0,3,0))-Camera:WorldToViewportPoint(head.Position+Vector3.new(0,3,0))).Magnitude
                ESPBoxes[p].Size = Vector2.new(size*0.4,size)
                ESPBoxes[p].Position = Vector2.new(pos.X-size*0.2,pos.Y-size/2)
                ESPBoxes[p].Visible = true
            elseif ESPBoxes[p] then
                ESPBoxes[p].Visible = false
            end
        end
    end
end

-- Keybinds
UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.LeftControl then
        if GUI and GUI.Frame then
            GUI.Frame.Visible = not GUI.Frame.Visible
        end
    elseif key.KeyCode == Enum.KeyCode.RightShift then
        Settings.Aimbot.Enabled = not Settings.Aimbot.Enabled
    elseif key.KeyCode == Enum.KeyCode.LeftShift then
        Settings.ESP.Enabled = not Settings.ESP.Enabled
    elseif key.KeyCode == Enum.KeyCode.X then
        Settings.Visuals.FOV = not Settings.Visuals.FOV
        FOVCircle.Visible = Settings.Visuals.FOV
    end
end)

-- Loop Principal
RunService.Heartbeat:Connect(function()
    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X,UserInputService:GetMouseLocation().Y)
    if Settings.Aimbot.Enabled then
        local target = GetClosest()
        if target then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position,target.Position),Settings.Aimbot.Smooth)
        end
    end
    UpdateESP()
end)

-- Iniciar GUI
CreateGUI()
print("🎯 HackerAI carregado! Pressione LEFTCTRL")
