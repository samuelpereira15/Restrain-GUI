-- Create GUI elements
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

-- Create main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
mainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark background
mainFrame.Parent = screenGui

-- Add UICorner to main frame
local mainFrameCorner = Instance.new("UICorner")
mainFrameCorner.CornerRadius = UDim.new(0, 10)
mainFrameCorner.Parent = mainFrame

-- Create Title Frame
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0.1, 0)
titleFrame.Position = UDim2.new(0, 0, 0, 0)
titleFrame.BackgroundColor3 = Color3.fromRGB(0, 60, 100) -- Dark blue background
titleFrame.Parent = mainFrame

-- Add UICorner to title frame
local titleFrameCorner = Instance.new("UICorner")
titleFrameCorner.CornerRadius = UDim.new(0, 10)
titleFrameCorner.Parent = titleFrame

-- Create Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 60, 100)
titleLabel.Text = "Restrain GUI"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
titleLabel.TextSize = 18
titleLabel.TextStrokeTransparency = 0.5
titleLabel.TextWrapped = true
titleLabel.Parent = titleFrame

-- Create TextBox for player selection
local playerTextBox = Instance.new("TextBox")
playerTextBox.Size = UDim2.new(1, -20, 0.2, -20)
playerTextBox.Position = UDim2.new(0, 10, 0.1, 10)
playerTextBox.PlaceholderText = "Enter player name"
playerTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Dark gray background
playerTextBox.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
playerTextBox.Parent = mainFrame

-- Add UICorner to TextBox
local playerTextBoxCorner = Instance.new("UICorner")
playerTextBoxCorner.CornerRadius = UDim.new(0, 5)
playerTextBoxCorner.Parent = playerTextBox

-- Create dropdown for restraint type
local restraintDropdown = Instance.new("TextButton")
restraintDropdown.Size = UDim2.new(1, -20, 0.2, -20)
restraintDropdown.Position = UDim2.new(0, 10, 0.35, 10)
restraintDropdown.Text = "Select Restraint"
restraintDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Dark gray background
restraintDropdown.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
restraintDropdown.Parent = mainFrame

-- Add UICorner to dropdown
local restraintDropdownCorner = Instance.new("UICorner")
restraintDropdownCorner.CornerRadius = UDim.new(0, 5)
restraintDropdownCorner.Parent = restraintDropdown

-- Create Apply button
local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(1, -20, 0.2, -20)
applyButton.Position = UDim2.new(0, 10, 0.6, 10)
applyButton.Text = "Apply Restraint"
applyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- Slightly lighter gray
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
applyButton.Parent = mainFrame

-- Add UICorner to Apply button
local applyButtonCorner = Instance.new("UICorner")
applyButtonCorner.CornerRadius = UDim.new(0, 5)
applyButtonCorner.Parent = applyButton

-- Create Unapply button
local unapplyButton = Instance.new("TextButton")
unapplyButton.Size = UDim2.new(1, -20, 0.2, -20)
unapplyButton.Position = UDim2.new(0, 10, 0.85, 10)
unapplyButton.Text = "Remove Restraint"
unapplyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- Slightly lighter gray
unapplyButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
unapplyButton.Parent = mainFrame

-- Add UICorner to Unapply button
local unapplyButtonCorner = Instance.new("UICorner")
unapplyButtonCorner.CornerRadius = UDim.new(0, 5)
unapplyButtonCorner.Parent = unapplyButton

-- Restraint options
local restraintOptions = {
    ziptie = false,
    handcuff = false
}

-- Function to get player by name
local function getPlayerByName(name)
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p.Name:lower() == name:lower() then
            return p
        end
    end
    return nil
end

-- Function to disable movement
local function disableMovement(playerChar)
    local humanoid = playerChar:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
        humanoid.WalkSpeed = 6
        humanoid.JumpPower = 0
        -- Disable tools and inventory
        for _, tool in ipairs(playerChar:FindFirstChildOfClass("Backpack"):GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = nil
            end
        end
    end
end

-- Function to enable movement
local function enableMovement(playerChar)
    local humanoid = playerChar:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = false
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
        -- Re-enable tools and inventory
        for _, tool in ipairs(playerChar:FindFirstChildOfClass("Backpack"):GetChildren()) do
            if not tool:IsA("Tool") and tool.Parent == nil then
                tool.Parent = playerChar:FindFirstChildOfClass("Backpack")
            end
        end
    end
end

-- Function to apply restraint
local function applyRestraint()
    local playerName = playerTextBox.Text
    local restraintType = restraintDropdown.Text

    local targetPlayer = getPlayerByName(playerName)
    if targetPlayer then
        local targetChar = targetPlayer.Character
        if targetChar then
            -- Apply restraint
            if restraintType == "ziptie" then
                restraintOptions.ziptie = true
                print("Applied ziptie to", playerName)
            elseif restraintType == "handcuff" then
                restraintOptions.handcuff = true
                print("Applied handcuff to", playerName)
            end

            -- Disable movement
            disableMovement(targetChar)
        end
    end
end

-- Function to remove restraint
local function removeRestraint()
    local playerName = playerTextBox.Text

    local targetPlayer = getPlayerByName(playerName)
    if targetPlayer then
        local targetChar = targetPlayer.Character
        if targetChar then
            -- Remove restraint
            if restraintOptions.ziptie then
                restraintOptions.ziptie = false
                print("Removed ziptie from", playerName)
            end
            if restraintOptions.handcuff then
                restraintOptions.handcuff = false
                print("Removed handcuff from", playerName)
            end

            -- Enable movement
            enableMovement(targetChar)
        end
    end
end

-- Connect buttons to functions
applyButton.MouseButton1Click:Connect(applyRestraint)
unapplyButton.MouseButton1Click:Connect(removeRestraint)

-- Handle restraint type dropdown
restraintDropdown.MouseButton1Click:Connect(function()
    local restraintType = restraintDropdown.Text
    if restraintType == "Select Restraint" then
        restraintDropdown.Text = "ziptie"
    elseif restraintType == "ziptie" then
        restraintDropdown.Text = "handcuff"
    else
        restraintDropdown.Text = "Select Restraint"
    end
end)
