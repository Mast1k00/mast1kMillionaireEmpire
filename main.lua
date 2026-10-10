local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local parent
pcall(function()
    parent = gethui()
end)
parent = parent or CoreGui

local oldGui = parent:FindFirstChild("mast1kMillionaireGUI")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "mast1kMillionaireGUI"
gui.ResetOnSpawn = false
gui.Parent = parent

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 370)
frame.Position = UDim2.new(0.5, -175, 0.5, -185)
frame.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 190, 60)
stroke.Thickness = 2
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 45)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "mast1k Millonaire Tycoon💸"
title.TextColor3 = Color3.fromRGB(255, 205, 75)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.Parent = frame

local moneyTab = Instance.new("TextButton")
moneyTab.Size = UDim2.new(0, 155, 0, 32)
moneyTab.Position = UDim2.new(0, 15, 0, 52)
moneyTab.BackgroundColor3 = Color3.fromRGB(145, 105, 35)
moneyTab.BorderSizePixel = 0
moneyTab.Text = "💰 Money"
moneyTab.TextColor3 = Color3.new(1, 1, 1)
moneyTab.TextSize = 14
moneyTab.Font = Enum.Font.GothamBold
moneyTab.Parent = frame

local farmTab = Instance.new("TextButton")
farmTab.Size = UDim2.new(0, 155, 0, 32)
farmTab.Position = UDim2.new(0, 180, 0, 52)
farmTab.BackgroundColor3 = Color3.fromRGB(55, 65, 90)
farmTab.BorderSizePixel = 0
farmTab.Text = "🤖 AutoComplete"
farmTab.TextColor3 = Color3.new(1, 1, 1)
farmTab.TextSize = 14
farmTab.Font = Enum.Font.GothamBold
farmTab.Parent = frame

local moneyPage = Instance.new("Frame")
moneyPage.Size = UDim2.new(1, 0, 1, -95)
moneyPage.Position = UDim2.new(0, 0, 0, 90)
moneyPage.BackgroundTransparency = 1
moneyPage.Parent = frame

local farmPage = Instance.new("Frame")
farmPage.Size = moneyPage.Size
farmPage.Position = moneyPage.Position
farmPage.BackgroundTransparency = 1
farmPage.Visible = false
farmPage.Parent = frame

local function switchTab(name)
    moneyPage.Visible = name == "Money"
    farmPage.Visible = name == "Farm"

    moneyTab.BackgroundColor3 = name == "Money"
        and Color3.fromRGB(145, 105, 35)
        or Color3.fromRGB(55, 65, 90)

    farmTab.BackgroundColor3 = name == "Farm"
        and Color3.fromRGB(145, 105, 35)
        or Color3.fromRGB(55, 65, 90)
end

moneyTab.MouseButton1Click:Connect(function()
    switchTab("Money")
end)

farmTab.MouseButton1Click:Connect(function()
    switchTab("Farm")
end)

local amountBox = Instance.new("TextBox")
amountBox.Size = UDim2.new(0, 205, 0, 42)
amountBox.Position = UDim2.new(0, 15, 0, 5)
amountBox.BackgroundColor3 = Color3.fromRGB(37, 40, 52)
amountBox.BorderSizePixel = 0
amountBox.PlaceholderText = "Enter amount..."
amountBox.Text = ""
amountBox.TextColor3 = Color3.new(1, 1, 1)
amountBox.PlaceholderColor3 = Color3.fromRGB(155, 160, 175)
amountBox.TextSize = 16
amountBox.Font = Enum.Font.Gotham
amountBox.ClearTextOnFocus = false
amountBox.Parent = moneyPage

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = amountBox

local units = {
    {name = "Number", multiplier = 1},
    {name = "K", multiplier = 1e3},
    {name = "M", multiplier = 1e6},
    {name = "B", multiplier = 1e9},
    {name = "T", multiplier = 1e12},
    {name = "Q", multiplier = 1e15},
}

local selectedUnit = units[1]
local updatePreview

local unitButton = Instance.new("TextButton")
unitButton.Size = UDim2.new(0, 100, 0, 42)
unitButton.Position = UDim2.new(1, -115, 0, 5)
unitButton.BackgroundColor3 = Color3.fromRGB(55, 65, 90)
unitButton.BorderSizePixel = 0
unitButton.Text = "Number ▼"
unitButton.TextColor3 = Color3.new(1, 1, 1)
unitButton.TextSize = 14
unitButton.Font = Enum.Font.GothamBold
unitButton.Parent = moneyPage

local unitCorner = Instance.new("UICorner")
unitCorner.CornerRadius = UDim.new(0, 8)
unitCorner.Parent = unitButton

local dropdown = Instance.new("Frame")
dropdown.Size = UDim2.new(0, 100, 0, #units * 30)
dropdown.Position = UDim2.new(1, -115, 0, 51)
dropdown.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
dropdown.BorderSizePixel = 0
dropdown.Visible = false
dropdown.ZIndex = 10
dropdown.Parent = moneyPage

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 8)
dropdownCorner.Parent = dropdown

for i, unit in ipairs(units) do
    local option = Instance.new("TextButton")
    option.Size = UDim2.new(1, 0, 0, 30)
    option.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
    option.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
    option.BorderSizePixel = 0
    option.Text = unit.name
    option.TextColor3 = Color3.new(1, 1, 1)
    option.TextSize = 13
    option.Font = Enum.Font.Gotham
    option.ZIndex = 11
    option.Parent = dropdown

    option.MouseButton1Click:Connect(function()
        selectedUnit = unit
        unitButton.Text = unit.name .. " ▼"
        dropdown.Visible = false
        updatePreview()
    end)
end

unitButton.MouseButton1Click:Connect(function()
    dropdown.Visible = not dropdown.Visible
end)

local preview = Instance.new("TextLabel")
preview.Size = UDim2.new(1, -30, 0, 25)
preview.Position = UDim2.new(0, 15, 0, 58)
preview.BackgroundTransparency = 1
preview.Text = "💰 Enter an amount"
preview.TextColor3 = Color3.fromRGB(180, 185, 200)
preview.TextSize = 12
preview.Font = Enum.Font.Gotham
preview.TextXAlignment = Enum.TextXAlignment.Left
preview.Parent = moneyPage

updatePreview = function()
    local value = tonumber(amountBox.Text)

    if value and value > 0 then
        preview.Text = "💰 Value: " ..
            string.format("%.6g", value * selectedUnit.multiplier)
    else
        preview.Text = "💰 Enter an amount"
    end
end

amountBox:GetPropertyChangedSignal("Text"):Connect(updatePreview)

local giveButton = Instance.new("TextButton")
giveButton.Size = UDim2.new(1, -30, 0, 42)
giveButton.Position = UDim2.new(0, 15, 0, 91)
giveButton.BackgroundColor3 = Color3.fromRGB(45, 155, 90)
giveButton.BorderSizePixel = 0
giveButton.Text = "Give Money💰"
giveButton.TextColor3 = Color3.new(1, 1, 1)
giveButton.TextSize = 16
giveButton.Font = Enum.Font.GothamBold
giveButton.Parent = moneyPage

local giveCorner = Instance.new("UICorner")
giveCorner.CornerRadius = UDim.new(0, 8)
giveCorner.Parent = giveButton

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 137)
status.BackgroundTransparency = 1
status.Text = "Ready 💸"
status.TextColor3 = Color3.fromRGB(180, 185, 200)
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.Parent = moneyPage

local destroyButton = Instance.new("TextButton")
destroyButton.Size = UDim2.new(1, -30, 0, 32)
destroyButton.Position = UDim2.new(0, 15, 1, -73)
destroyButton.BackgroundColor3 = Color3.fromRGB(180, 55, 60)
destroyButton.BorderSizePixel = 0
destroyButton.Text = "Destroy GUI❌"
destroyButton.TextColor3 = Color3.new(1, 1, 1)
destroyButton.TextSize = 14
destroyButton.Font = Enum.Font.GothamBold
destroyButton.Parent = frame

local destroyCorner = Instance.new("UICorner")
destroyCorner.CornerRadius = UDim.new(0, 8)
destroyCorner.Parent = destroyButton

local hint = Instance.new("TextLabel")
hint.Size = UDim2.new(1, -20, 0, 18)
hint.Position = UDim2.new(0, 10, 1, -19)
hint.BackgroundTransparency = 1
hint.Text = "Press Q to open / close GUI"
hint.TextColor3 = Color3.fromRGB(150, 155, 170)
hint.TextSize = 11
hint.Font = Enum.Font.Gotham
hint.Parent = frame

giveButton.MouseButton1Click:Connect(function()
    local text = amountBox.Text:gsub("%s+", "")
    local value = tonumber(text)

    if not value or value <= 0 or value == math.huge then
        status.Text = "❌ Enter a valid amount"
        status.TextColor3 = Color3.fromRGB(255, 90, 90)
        return
    end

    local amount = value * selectedUnit.multiplier

    if amount == math.huge then
        status.Text = "❌ Amount too large"
        status.TextColor3 = Color3.fromRGB(255, 90, 90)
        return
    end

    local remote = ReplicatedStorage:FindFirstChild("fewjnfejwb3")

    if not remote or not remote:IsA("RemoteEvent") then
        status.Text = "❌ RemoteEvent not found"
        status.TextColor3 = Color3.fromRGB(255, 90, 90)
        return
    end

    local success = pcall(function()
        remote:FireServer(amount)
    end)

    if success then
        status.Text = "✅ Request sent!"
        status.TextColor3 = Color3.fromRGB(100, 255, 140)
    else
        status.Text = "❌ Request failed"
        status.TextColor3 = Color3.fromRGB(255, 90, 90)
    end
end)

local farmRunning = false

local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(1, -30, 0, 42)
startButton.Position = UDim2.new(0, 15, 0, 10)
startButton.BackgroundColor3 = Color3.fromRGB(45, 155, 90)
startButton.BorderSizePixel = 0
startButton.Text = "▶ Start AutoComplete"
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.TextSize = 15
startButton.Font = Enum.Font.GothamBold
startButton.Parent = farmPage

local startCorner = Instance.new("UICorner")
startCorner.CornerRadius = UDim.new(0, 8)
startCorner.Parent = startButton

local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(1, -30, 0, 42)
stopButton.Position = UDim2.new(0, 15, 0, 62)
stopButton.BackgroundColor3 = Color3.fromRGB(180, 55, 60)
stopButton.BorderSizePixel = 0
stopButton.Text = "⏹ Stop AutoComplete"
stopButton.TextColor3 = Color3.new(1, 1, 1)
stopButton.TextSize = 15
stopButton.Font = Enum.Font.GothamBold
stopButton.Parent = farmPage

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 8)
stopCorner.Parent = stopButton

local itemsButton = Instance.new("TextButton")
itemsButton.Size = UDim2.new(1, -30, 0, 42)
itemsButton.Position = UDim2.new(0, 15, 0, 114)
itemsButton.BackgroundColor3 = Color3.fromRGB(145, 105, 35)
itemsButton.BorderSizePixel = 0
itemsButton.Text = "🎁 Give all items"
itemsButton.TextColor3 = Color3.new(1, 1, 1)
itemsButton.TextSize = 15
itemsButton.Font = Enum.Font.GothamBold
itemsButton.Parent = farmPage

local itemsCorner = Instance.new("UICorner")
itemsCorner.CornerRadius = UDim.new(0, 8)
itemsCorner.Parent = itemsButton

local itemsHint = Instance.new("TextLabel")
itemsHint.Size = UDim2.new(1, -30, 0, 30)
itemsHint.Position = UDim2.new(0, 15, 0, 160)
itemsHint.BackgroundTransparency = 1
itemsHint.Text = "Requires completing the tycoon to Mars"
itemsHint.TextColor3 = Color3.fromRGB(180, 185, 200)
itemsHint.TextSize = 10
itemsHint.Font = Enum.Font.Gotham
itemsHint.TextWrapped = true
itemsHint.Parent = farmPage

local itemsRunning = false

local itemNames = {
    "Giver1",
    "Giver2",
    "Giver4",
    "Giver5",
    "Giver6",
    "Giver7",
    "MoonGear1",
    "MoonGear2"
}

local function findMyTycoon()
    local tycoons = workspace:FindFirstChild("Tycoons")
    if not tycoons then
        return nil
    end

    for _, tycoon in ipairs(tycoons:GetChildren()) do
        local owner = tycoon:FindFirstChild("Owner")

        if owner and (
            (owner:IsA("StringValue") and owner.Value == player.Name)
            or (owner:IsA("IntValue") and owner.Value == player.UserId)
        ) then
            return tycoon
        end
    end

    return nil
end

local function isGamePassButton(part, buttonsFolder)
    local current = part

    while current and current ~= buttonsFolder do
        local gamePass = current:FindFirstChild("GamePass", true)

        if gamePass and gamePass:IsA("IntValue") then
            return true
        end

        current = current.Parent
    end

    return false
end

local function getTargets(buttonsFolder)
    local targets = {}

    for _, item in ipairs(buttonsFolder:GetDescendants()) do
        if item:IsA("BasePart")
            and not isGamePassButton(item, buttonsFolder) then

            local current = item
            local skip = false

            while current and current ~= buttonsFolder do
                if current:IsA("Model") then
                    local head = current:FindFirstChild("Head")

                    if head and head:IsA("BasePart")
                        and head.Transparency == 1 then
                        skip = true
                        break
                    end
                end

                current = current.Parent
            end

            if not skip then
                table.insert(targets, item)
            end
        end
    end

    return targets
end

itemsButton.MouseButton1Click:Connect(function()
    if itemsRunning then
        return
    end

    itemsRunning = true
    itemsButton.Text = "⏳ Collecting..."
    itemsButton.BackgroundColor3 = Color3.fromRGB(90, 90, 100)

    task.spawn(function()
        local character = player.Character
            or player.CharacterAdded:Wait()

        local originalPivot = character:GetPivot()

        local tycoon = findMyTycoon()
        local purchasesFolder = tycoon
            and tycoon:FindFirstChild("PurchasesFolder", true)

        if not purchasesFolder then
            itemsButton.Text = "❌ PurchasesFolder not found"
            itemsRunning = false
            return
        end

        for _, itemName in ipairs(itemNames) do
            if not itemsRunning then
                break
            end

            local model = purchasesFolder:FindFirstChild(itemName, true)

            if model and (model:IsA("Model") or model:IsA("BasePart")) then
                local targetPivot

                if model:IsA("Model") then
                    targetPivot = model:GetPivot()
                else
                    targetPivot = model.CFrame
                end

                pcall(function()
                    character:PivotTo(
                        targetPivot + Vector3.new(0, 4, 0)
                    )
                end)

                task.wait(0.1)
            end
        end

        if character.Parent then
            pcall(function()
                character:PivotTo(originalPivot)
            end)
        end

        itemsButton.Text = "🎁 Give all items"
        itemsButton.BackgroundColor3 = Color3.fromRGB(145, 105, 35)
        itemsRunning = false
    end)
end)

startButton.MouseButton1Click:Connect(function()
    if farmRunning then
        return
    end

    farmRunning = true

    task.spawn(function()
        while farmRunning do
            local tycoon = findMyTycoon()
            local buttonsFolder =
                tycoon and tycoon:FindFirstChild("ButtonsFolder")
            local character = player.Character

            if buttonsFolder and character and character.Parent then
                local targets = getTargets(buttonsFolder)

                for _, target in ipairs(targets) do
                    if not farmRunning then
                        break
                    end

                    if target.Parent and character.Parent then
                        pcall(function()
                            character:PivotTo(
                                target.CFrame + Vector3.new(0, 4, 0)
                            )
                        end)
                    end

                    task.wait(0.1)
                end
            end

            task.wait(0.1)
        end
    end)
end)

stopButton.MouseButton1Click:Connect(function()
    farmRunning = false
    stopButton.Text = "⏹ Stopping..."

    task.delay(0.2, function()
        if stopButton and stopButton.Parent then
            stopButton.Text = "⏹ Stop AutoComplete"
        end
    end)
end)

local guiVisible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.Q then
        guiVisible = not guiVisible
        gui.Enabled = guiVisible
    end
end)

destroyButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
