-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Variáveis do jogador
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- Configurações do Aimbot
local AimSettings = {
    Enabled = false,
    FOV = 100,
    Smoothness = 0.2,
    Target = nil,
    TeamCheck = true
}

-- Interface gráfica
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VMasterTutorialsUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Container principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
MainFrame.Size = UDim2.new(0, 300, 0, 320)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Efeito de sombra
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 80)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Cabeçalho
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 60)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "VMaster Tutorials"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.TextSize = 24
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Text = "Professional Aimbot Suite"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextColor3 = Color3.fromRGB(180, 180, 220)
Subtitle.TextSize = 14
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 20, 0, 35)
Subtitle.Size = UDim2.new(1, -40, 0, 20)
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Aimbot
local AimbotButton = Instance.new("TextButton")
AimbotButton.Name = "AimbotButton"
AimbotButton.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
AimbotButton.Position = UDim2.new(0.1, 0, 0.25, 0)
AimbotButton.Size = UDim2.new(0.8, 0, 0, 50)
AimbotButton.Font = Enum.Font.GothamBold
AimbotButton.Text = "AIMBOT: OFF"
AimbotButton.TextColor3 = Color3.white
AimbotButton.TextSize = 18
AimbotButton.AutoButtonColor = false

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = AimbotButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(80, 160, 255)
ButtonStroke.Thickness = 2
ButtonStroke.Parent = AimbotButton

-- Controle de FOV
local FOVContainer = Instance.new("Frame")
FOVContainer.Name = "FOVContainer"
FOVContainer.BackgroundTransparency = 1
FOVContainer.Position = UDim2.new(0.1, 0, 0.45, 0)
FOVContainer.Size = UDim2.new(0.8, 0, 0, 80)

local FOVLabel = Instance.new("TextLabel")
FOVLabel.Name = "FOVLabel"
FOVLabel.Text = "FOV SIZE"
FOVLabel.Font = Enum.Font.Gotham
FOVLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
FOVLabel.TextSize = 14
FOVLabel.BackgroundTransparency = 1
FOVLabel.Size = UDim2.new(1, 0, 0, 20)
FOVLabel.TextXAlignment = Enum.TextXAlignment.Left

local FOVValue = Instance.new("TextBox")
FOVValue.Name = "FOVValue"
FOVValue.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
FOVValue.BorderSizePixel = 0
FOVValue.Position = UDim2.new(0, 0, 0, 25)
FOVValue.Size = UDim2.new(1, 0, 0, 40)
FOVValue.Font = Enum.Font.Gotham
FOVValue.PlaceholderText = "Enter FOV value"
FOVValue.Text = tostring(AimSettings.FOV)
FOVValue.TextColor3 = Color3.white
FOVValue.TextSize = 16
FOVValue.ClearTextOnFocus = false

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(0, 6)
FOVCorner.Parent = FOVValue

-- Instalar elementos
Header.Parent = MainFrame
Title.Parent = Header
Subtitle.Parent = Header
AimbotButton.Parent = MainFrame
FOVContainer.Parent = MainFrame
FOVLabel.Parent = FOVContainer
FOVValue.Parent = FOVContainer
MainFrame.Parent = ScreenGui
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- FOV Circle
local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "FOVCircle"
FOVCircle.BackgroundTransparency = 1
FOVCircle.Size = UDim2.new(0, AimSettings.FOV, 0, AimSettings.FOV)
FOVCircle.Position = UDim2.new(0.5, -AimSettings.FOV/2, 0.5, -AimSettings.FOV/2)
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)

local CircleUI = Instance.new("UICorner")
CircleUI.CornerRadius = UDim.new(1, 0)
CircleUI.Parent = FOVCircle

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Color3.fromRGB(50, 120, 220)
CircleStroke.Thickness = 2
CircleStroke.Parent = FOVCircle

FOVCircle.Parent = ScreenGui
FOVCircle.Visible = false

-- Funções
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = AimSettings.FOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Verificar time
            if AimSettings.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            -- Converter posição do jogador para tela
            local position, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
            
            if onScreen then
                local screenCenter = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                local mousePosition = Vector2.new(position.X, position.Y)
                local distance = (mousePosition - screenCenter).Magnitude
                
                if distance <= AimSettings.FOV/2 then
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function UpdateFOVCircle()
    FOVCircle.Size = UDim2.new(0, AimSettings.FOV, 0, AimSettings.FOV)
    FOVCircle.Position = UDim2.new(0.5, -AimSettings.FOV/2, 0.5, -AimSettings.FOV/2)
end

local function ToggleAimbot()
    AimSettings.Enabled = not AimSettings.Enabled
    
    if AimSettings.Enabled then
        AimbotButton.Text = "AIMBOT: ON"
        AimbotButton.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
        ButtonStroke.Color = Color3.fromRGB(255, 120, 120)
        FOVCircle.Visible = true
    else
        AimbotButton.Text = "AIMBOT: OFF"
        AimbotButton.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
        ButtonStroke.Color = Color3.fromRGB(80, 160, 255)
        FOVCircle.Visible = false
        AimSettings.Target = nil
    end
end

-- Efeitos de hover no botão
AimbotButton.MouseEnter:Connect(function()
    if AimSettings.Enabled then
        TweenService:Create(AimbotButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(240, 100, 100)}):Play()
    else
        TweenService:Create(AimbotButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 140, 240)}):Play()
    end
end)

AimbotButton.MouseLeave:Connect(function()
    if AimSettings.Enabled then
        TweenService:Create(AimbotButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 80, 80)}):Play()
    else
        TweenService:Create(AimbotButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 120, 220)}):Play()
    end
end)

-- Atualizar FOV em tempo real
FOVValue:GetPropertyChangedSignal("Text"):Connect(function()
    local newValue = tonumber(FOVValue.Text)
    if newValue and newValue >= 10 and newValue <= 500 then
        AimSettings.FOV = newValue
        UpdateFOVCircle()
    end
end)

-- Botão do aimbot
AimbotButton.MouseButton1Click:Connect(ToggleAimbot)

-- Loop principal do aimbot
RunService.RenderStepped:Connect(function()
    if AimSettings.Enabled then
        AimSettings.Target = GetClosestPlayer()
        
        if AimSettings.Target and AimSettings.Target.Character then
            local head = AimSettings.Target.Character:FindFirstChild("Head")
            if head then
                -- Calcular posição suavizada
                local currentCFrame = Camera.CFrame
                local targetPosition = head.Position
                local newCFrame = CFrame.lookAt(
                    currentCFrame.Position,
                    targetPosition
                )
                
                -- Aplicar suavização
                Camera.CFrame = currentCFrame:Lerp(newCFrame, AimSettings.Smoothness)
            end
        end
    end
end)

-- Sistema de arrastar a interface
local dragging = false
local dragInput, dragStart, startPos

local function UpdateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        UpdateInput(input)
    end
end)

-- Notificação inicial
local Notification = Instance.new("TextLabel")
Notification.Name = "Notification"
Notification.Text = "VMaster Tutorials UI Loaded Successfully!"
Notification.Font = Enum.Font.GothamBold
Notification.TextColor3 = Color3.fromRGB(220, 220, 255)
Notification.TextSize = 16
Notification.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
Notification.BorderSizePixel = 0
Notification.Position = UDim2.new(0.5, -150, 1, -80)
Notification.Size = UDim2.new(0, 300, 0, 40)
Notification.AnchorPoint = Vector2.new(0.5, 1)
Notification.Visible = false

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 6)
NotifCorner.Parent = Notification

Notification.Parent = ScreenGui

-- Mostrar notificação
Notification.Visible = true
task.wait(3)
local tween = TweenService:Create(Notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 1, 50)})
tween:Play()
tween.Completed:Connect(function()
    Notification:Destroy()
end)

print("VMaster Tutorials UI carregada com sucesso!")
