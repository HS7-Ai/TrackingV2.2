-- HS7 Logo Animation with Effects
local function showHS7Logo()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local player = Players.LocalPlayer
    
    -- Create GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "HS7Logo"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    
    -- Main Container
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = gui
    
    -- Background Effect
    local background = Instance.new("Frame")
    background.Size = UDim2.new(0, 400, 0, 200)
    background.Position = UDim2.new(0.5, -200, 0.5, -100)
    background.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    background.BackgroundTransparency = 1
    background.BorderSizePixel = 0
    background.Parent = container
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 20)
    bgCorner.Parent = background
    
    local bgStroke = Instance.new("UIStroke")
    bgStroke.Color = Color3.fromRGB(100, 100, 255)
    bgStroke.Thickness = 3
    bgStroke.Transparency = 1
    bgStroke.Parent = background
    
    -- Logo Text
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(1, 0, 0.7, 0)
    logo.Position = UDim2.new(0, 0, 0.15, 0)
    logo.BackgroundTransparency = 1
    logo.Text = "HS7"
    logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    logo.TextSize = 64
    logo.Font = Enum.Font.GothamBlack
    logo.TextTransparency = 1
    logo.Parent = background
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0.3, 0)
    subtitle.Position = UDim2.new(0, 0, 0.7, 0)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "TRACKING SYSTEM"
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    subtitle.TextSize = 18
    subtitle.Font = Enum.Font.GothamMedium
    subtitle.TextTransparency = 1
    subtitle.Parent = background
    
    -- Animation Sequence
    spawn(function()
        -- Fade in background
        local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local bgTween = TweenService:Create(background, tweenInfo, {BackgroundTransparency = 0.1})
        local strokeTween = TweenService:Create(bgStroke, tweenInfo, {Transparency = 0})
        bgTween:Play()
        strokeTween:Play()
        
        wait(0.3)
        
        -- Logo fade in with scale effect
        logo.TextTransparency = 0
        logo.TextSize = 80
        local logoScaleTween = TweenService:Create(logo, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 64})
        logoScaleTween:Play()
        
        wait(0.4)
        
        -- Subtitle fade in
        local subtitleTween = TweenService:Create(subtitle, tweenInfo, {TextTransparency = 0})
        subtitleTween:Play()
        
        -- زيادة مدة العرض إلى 5 ثواني
        wait(4)
        
        -- Fade out everything
        local fadeOut = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local bgFadeOut = TweenService:Create(background, fadeOut, {BackgroundTransparency = 1})
        local strokeFadeOut = TweenService:Create(bgStroke, fadeOut, {Transparency = 1})
        local logoFadeOut = TweenService:Create(logo, fadeOut, {TextTransparency = 1})
        local subtitleFadeOut = TweenService:Create(subtitle, fadeOut, {TextTransparency = 1})
        
        bgFadeOut:Play()
        strokeFadeOut:Play()
        logoFadeOut:Play()
        subtitleFadeOut:Play()
        
        wait(1)
        gui:Destroy()
    end)
end

-- Main Tracking Script
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Show Logo
showHS7Logo()

-- انتظر حتى يتحمل اللاعب
repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

local trackingEnabled = false
local currentTrackedPlayer = nil
local connection = nil
local bodyGyro = nil
local currentKeyBind = Enum.KeyCode.F

-- إنشاء الواجهة
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HS7TrackingGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- الفريم الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 180, 0, 120)
mainFrame.Position = UDim2.new(0, 15, 0, 15)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(100, 100, 255)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.3
mainStroke.Parent = mainFrame

-- زر التتبع الرئيسي
local trackButton = Instance.new("TextButton")
trackButton.Size = UDim2.new(0.8, 0, 0.3, 0)
trackButton.Position = UDim2.new(0.1, 0, 0.1, 0)
trackButton.BackgroundColor3 = Color3.fromRGB(220, 60, 80)
trackButton.Text = "🔴 تتبع (F)"
trackButton.TextColor3 = Color3.new(1, 1, 1)
trackButton.TextSize = 14
trackButton.Font = Enum.Font.GothamBold
trackButton.BorderSizePixel = 0
trackButton.ZIndex = 2
trackButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = trackButton

-- زر تغيير الزر
local keyBindButton = Instance.new("TextButton")
keyBindButton.Size = UDim2.new(0.8, 0, 0.2, 0)
keyBindButton.Position = UDim2.new(0.1, 0, 0.45, 0)
keyBindButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
keyBindButton.Text = "✏️ تغيير الزر (F)"
keyBindButton.TextColor3 = Color3.new(1, 1, 1)
keyBindButton.TextSize = 11
keyBindButton.Font = Enum.Font.GothamMedium
keyBindButton.BorderSizePixel = 0
keyBindButton.Parent = mainFrame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyBindButton

-- زر فتح القائمة
local toggleListButton = Instance.new("TextButton")
toggleListButton.Size = UDim2.new(0, 30, 0, 30)
toggleListButton.Position = UDim2.new(0.85, 0, 0.85, 0)
toggleListButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
toggleListButton.Text = "📋"
toggleListButton.TextColor3 = Color3.new(1, 1, 1)
toggleListButton.TextSize = 14
toggleListButton.BorderSizePixel = 0
toggleListButton.Parent = mainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleListButton

-- حالة التتبع
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
statusLabel.Position = UDim2.new(0.1, 0, 0.7, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "جاهز للتتبع"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

-- قائمة اللاعبين
local playersFrame = Instance.new("Frame")
playersFrame.Size = UDim2.new(0, 240, 0, 350)
playersFrame.Position = UDim2.new(1, -255, 0, 15)
playersFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
playersFrame.BackgroundTransparency = 0.2
playersFrame.BorderSizePixel = 0
playersFrame.Active = true
playersFrame.Draggable = true
playersFrame.Visible = false
playersFrame.Parent = screenGui

local playersCorner = Instance.new("UICorner")
playersCorner.CornerRadius = UDim.new(0, 15)
playersCorner.Parent = playersFrame

local playersStroke = Instance.new("UIStroke")
playersStroke.Color = Color3.fromRGB(100, 100, 255)
playersStroke.Thickness = 1.5
playersStroke.Transparency = 0.3
playersStroke.Parent = playersFrame

-- عنوان القائمة
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = playersFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🎮 اللاعبين المتاحين"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- زر إغلاق القائمة
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 80)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- سكرول للاعبين
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -50)
scrollFrame.Position = UDim2.new(0, 5, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 255)
scrollFrame.Parent = playersFrame

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Padding = UDim.new(0, 8)
playerListLayout.Parent = scrollFrame

-- دالة إيجاد أقرب لاعب
function findClosestPlayer()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local playerPos = player.Character.HumanoidRootPart.Position
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local humanoidRootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local distance = (playerPos - humanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = otherPlayer
                end
            end
        end
    end
    
    return closestPlayer
end

-- دالة الحصول على اللاعبين مرتبين
function getSortedPlayersByDistance()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return {}
    end
    
    local playerPos = player.Character.HumanoidRootPart.Position
    local playersWithDistance = {}
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local humanoidRootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local distance = (playerPos - humanoidRootPart.Position).Magnitude
                table.insert(playersWithDistance, {
                    player = otherPlayer,
                    distance = distance
                })
            end
        end
    end
    
    table.sort(playersWithDistance, function(a, b)
        return a.distance < b.distance
    end)
    
    return playersWithDistance
end

-- دالة تحديث قائمة اللاعبين
function updatePlayersList()
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local sortedPlayers = getSortedPlayersByDistance()
    local playerCount = #sortedPlayers
    
    for i, playerData in ipairs(sortedPlayers) do
        local otherPlayer = playerData.player
        local distance = math.floor(playerData.distance)
        
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(1, 0, 0, 50)
        playerButton.BackgroundColor3 = currentTrackedPlayer == otherPlayer and trackingEnabled and 
            Color3.fromRGB(60, 180, 100) or Color3.fromRGB(40, 40, 60)
        playerButton.Text = (currentTrackedPlayer == otherPlayer and trackingEnabled and "🎯 " or "👤 ") .. 
            otherPlayer.Name .. "\n" .. distance .. " متر"
        playerButton.TextColor3 = Color3.new(1, 1, 1)
        playerButton.TextSize = 12
        playerButton.Font = Enum.Font.Gotham
        playerButton.BorderSizePixel = 0
        playerButton.Parent = scrollFrame
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = playerButton
        
        playerButton.MouseButton1Click:Connect(function()
            if currentTrackedPlayer == otherPlayer and trackingEnabled then
                toggleTracking()
            else
                switchTracking(otherPlayer)
            end
        end)
        
        -- تأثيرات Hover
        playerButton.MouseEnter:Connect(function()
            if currentTrackedPlayer ~= otherPlayer or not trackingEnabled then
                TweenService:Create(playerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
            end
        end)
        
        playerButton.MouseLeave:Connect(function()
            if currentTrackedPlayer ~= otherPlayer or not trackingEnabled then
                TweenService:Create(playerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
            else
                TweenService:Create(playerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 180, 100)}):Play()
            end
        end)
    end
    
    titleLabel.Text = "🎮 اللاعبين (" .. playerCount .. ")"
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, playerCount * 58)
end

-- دالة التحقق إذا اللاعب ميت
function isPlayerDead(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return true
    end
    
    local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        return humanoid.Health <= 0
    end
    
    return true
end

-- دالة التتبع
function trackPlayer()
    if not trackingEnabled or not currentTrackedPlayer then
        return
    end
    
    -- التحقق إذا اللاعب المستهدف مات
    if isPlayerDead(currentTrackedPlayer) then
        local closestPlayer = findClosestPlayer()
        if closestPlayer then
            currentTrackedPlayer = closestPlayer
            statusLabel.Text = "يتتبع: " .. closestPlayer.Name
            print("🔄 تحولت لأقرب لاعب: " .. closestPlayer.Name)
        else
            toggleTracking()
            return
        end
    end
    
    local targetRoot = currentTrackedPlayer.Character:FindFirstChild("HumanoidRootPart")
    local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    if not targetRoot or not playerRoot then
        return
    end
    
    -- توجيه الجسم نحو الهدف
    local lookVector = (targetRoot.Position - playerRoot.Position).Unit
    local newBodyCFrame = CFrame.new(playerRoot.Position, playerRoot.Position + lookVector)
    
    if bodyGyro and bodyGyro.Parent then
        bodyGyro.CFrame = newBodyCFrame
    end
    
    -- إعداد الكاميرا
    local cameraOffset = Vector3.new(0, 3, 8)
    local cameraPosition = playerRoot.Position + 
                          (newBodyCFrame.RightVector * cameraOffset.X) + 
                          (newBodyCFrame.UpVector * cameraOffset.Y) - 
                          (newBodyCFrame.LookVector * cameraOffset.Z)
    
    camera.CFrame = CFrame.lookAt(cameraPosition, targetRoot.Position + Vector3.new(0, 2, 0))
    camera.CameraType = Enum.CameraType.Custom
    camera.CameraSubject = player.Character.Humanoid
end

-- دالة التبديل للتتبع
function toggleTracking()
    if trackingEnabled then
        -- إيقاف التتبع
        trackingEnabled = false
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if bodyGyro then
            bodyGyro:Destroy()
            bodyGyro = nil
        end
        currentTrackedPlayer = nil
        trackButton.BackgroundColor3 = Color3.fromRGB(220, 60, 80)
        trackButton.Text = "🔴 تتبع (" .. currentKeyBind.Name .. ")"
        statusLabel.Text = "جاهز للتتبع"
        print("⏹️ توقف التتبع")
    else
        -- تشغيل التتبع
        local closestPlayer = findClosestPlayer()
        if closestPlayer then
            trackingEnabled = true
            currentTrackedPlayer = closestPlayer
            
            -- إنشاء BodyGyro
            if bodyGyro then
                bodyGyro:Destroy()
            end
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
            bodyGyro.P = 5000
            bodyGyro.D = 500
            bodyGyro.Parent = player.Character.HumanoidRootPart
            
            -- بدء التتبع
            connection = RunService.RenderStepped:Connect(trackPlayer)
            trackButton.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
            trackButton.Text = "🟢 يتتبع (" .. currentKeyBind.Name .. ")"
            statusLabel.Text = "يتتبع: " .. closestPlayer.Name
            print("🎯 بدأ التتبع على: " .. closestPlayer.Name)
        else
            print("❌ ما في لاعب للتتبع")
        end
    end
    updatePlayersList()
end

-- دالة التتبع للاعب محدد
function switchTracking(targetPlayer)
    if trackingEnabled then
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if bodyGyro then
            bodyGyro:Destroy()
            bodyGyro = nil
        end
    end
    
    currentTrackedPlayer = targetPlayer
    trackingEnabled = true
    
    -- إنشاء BodyGyro
    if bodyGyro then
        bodyGyro:Destroy()
    end
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.P = 5000
    bodyGyro.D = 500
    bodyGyro.Parent = player.Character.HumanoidRootPart
    
    -- بدء التتبع
    connection = RunService.RenderStepped:Connect(trackPlayer)
    trackButton.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
    trackButton.Text = "🟢 يتتبع (" .. currentKeyBind.Name .. ")"
    statusLabel.Text = "يتتبع: " .. targetPlayer.Name
    updatePlayersList()
    
    print("🎯 بدأ التتبع على: " .. targetPlayer.Name)
end

-- نظام تغيير الزر
local function changeKeyBind()
    keyBindButton.Text = "اضغط زر جديد..."
    keyBindButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.UserInputType == Enum.UserInputType.Keyboard then
            currentKeyBind = input.KeyCode
            keyBindButton.Text = "✏️ تغيير الزر (" .. currentKeyBind.Name .. ")"
            keyBindButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
            trackButton.Text = trackingEnabled and "🟢 يتتبع (" .. currentKeyBind.Name .. ")" or "🔴 تتبع (" .. currentKeyBind.Name .. ")"
            connection:Disconnect()
            print("✅ تم تغيير الزر إلى: " .. currentKeyBind.Name)
        end
    end)
end

-- أحداث الأزرار
trackButton.MouseButton1Click:Connect(function()
    toggleTracking()
end)

keyBindButton.MouseButton1Click:Connect(function()
    changeKeyBind()
end)

toggleListButton.MouseButton1Click:Connect(function()
    playersFrame.Visible = not playersFrame.Visible
end)

closeButton.MouseButton1Click:Connect(function()
    playersFrame.Visible = false
end)

-- كيبورد إنتري
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == currentKeyBind then
        toggleTracking()
    end
end)

-- إعادة التتبع بعد ال respawn
player.CharacterAdded:Connect(function(character)
    character:WaitForChild("HumanoidRootPart")
    if trackingEnabled then
        task.wait(1)
        -- إنشاء BodyGyro جديد
        if bodyGyro then
            bodyGyro:Destroy()
        end
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        bodyGyro.P = 5000
        bodyGyro.D = 500
        bodyGyro.Parent = character.HumanoidRootPart
        
        -- البحث عن لاعب جديد إذا مات الهدف
        if currentTrackedPlayer and isPlayerDead(currentTrackedPlayer) then
            local closestPlayer = findClosestPlayer()
            if closestPlayer then
                currentTrackedPlayer = closestPlayer
                statusLabel.Text = "يتتبع: " .. closestPlayer.Name
                print("🔄 تحولت لأقرب لاعب بعد ال respawn: " .. closestPlayer.Name)
            end
        end
    end
end)

-- تحديث القائمة عند دخول/خروج لاعبين
Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    updatePlayersList()
end)

Players.PlayerRemoving:Connect(function(leftPlayer)
    if leftPlayer == currentTrackedPlayer then
        print("🎯 اللاعب المستهدف غادر السيرفر")
        local closestPlayer = findClosestPlayer()
        if closestPlayer then
            currentTrackedPlayer = closestPlayer
            statusLabel.Text = "يتتبع: " .. closestPlayer.Name
        else
            toggleTracking()
        end
    end
    updatePlayersList()
end)

-- تأثيرات الأزرار
trackButton.MouseEnter:Connect(function()
    TweenService:Create(trackButton, TweenInfo.new(0.2), {
        BackgroundColor3 = trackingEnabled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(240, 80, 100)
    }):Play()
end)

trackButton.MouseLeave:Connect(function()
    TweenService:Create(trackButton, TweenInfo.new(0.2), {
        BackgroundColor3 = trackingEnabled and Color3.fromRGB(60, 180, 100) or Color3.fromRGB(220, 60, 80)
    }):Play()
end)

keyBindButton.MouseEnter:Connect(function()
    TweenService:Create(keyBindButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 150)}):Play()
end)

keyBindButton.MouseLeave:Connect(function()
    TweenService:Create(keyBindButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 120)}):Play()
end)

toggleListButton.MouseEnter:Connect(function()
    TweenService:Create(toggleListButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 100)}):Play()
end)

toggleListButton.MouseLeave:Connect(function()
    TweenService:Create(toggleListButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
end)

-- الإعداد الأولي
updatePlayersList()

print("🎮 HS7 Tracking System - Loaded Successfully!")
print("✨ With Beautiful Logo & Players List")
print("🎯 Press " .. currentKeyBind.Name .. " to toggle tracking")
print("📋 Click the list button to view all players")
