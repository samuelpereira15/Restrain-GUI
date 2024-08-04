local key = "RestrainGUI"
local userKey = ""

-- Function to prompt user for key
local function getUserKey()
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.3, 0, 0.3, 0)
    mainFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark background
    mainFrame.Parent = screenGui
    
    local mainFrameCorner = Instance.new("UICorner")
    mainFrameCorner.CornerRadius = UDim.new(0, 10)
    mainFrameCorner.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = "Enter Key"
    titleLabel.BackgroundColor3 = Color3.fromRGB(0, 60, 100) -- Dark blue background
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    titleLabel.TextSize = 18
    titleLabel.TextStrokeTransparency = 0.5
    titleLabel.Parent = mainFrame
    
    local userInput = Instance.new("TextBox")
    userInput.Size = UDim2.new(1, -20, 0.3, -20)
    userInput.Position = UDim2.new(0, 10, 0.25, 10)
    userInput.PlaceholderText = "Enter your key here"
    userInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Dark gray background
    userInput.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    userInput.Parent = mainFrame
    
    local submitButton = Instance.new("TextButton")
    submitButton.Size = UDim2.new(1, -20, 0.3, -20)
    submitButton.Position = UDim2.new(0, 10, 0.6, 10)
    submitButton.Text = "Submit"
    submitButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- Slightly lighter gray
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    submitButton.Parent = mainFrame
    
    local submitButtonCorner = Instance.new("UICorner")
    submitButtonCorner.CornerRadius = UDim.new(0, 5)
    submitButtonCorner.Parent = submitButton
    
    submitButton.MouseButton1Click:Connect(function()
        userKey = userInput.Text
        if userKey == key then
            -- Load the main GUI if the key is correct
            screenGui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/samuelpereira15/Restrain-GUI/main/main.lua"))()
        else
            -- Provide feedback if the key is incorrect
            titleLabel.Text = "Invalid Key"
            wait(2)
            titleLabel.Text = "Enter Key"
        end
    end)
end

-- Call the key input function
getUserKey()