getgenv().SecureMode = Value

getgenv().AntiKick = false
getgenv().AntiHwidBan = false
getgenv().AntiIpBan = false
getgenv().BypassChat = false

	local Rayfield = loadstring(game:HttpGet(('https://sirius.menu/gen2')))()


	local function generateVarName()
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local name = ""
    for i = 1, 3 do  -- Variable names will be 3 characters long
        name = name .. chars:sub(math.random(1, #chars), math.random(1, #chars))
    end
    return name
end

-- Strong obfuscation function with random variable renaming and encoding
local function strongObfuscate(code)
    -- Create a table to store renamed variables
    local varNames = {}
    
    -- Function to replace variable names in the code
    local function renameVariables(code)
        local renamedCode = code
        local varCounter = 0
        -- Pattern to find variable names (e.g., `local a, b, c`)
        for var in code:gmatch("[%a_][%w_]*") do
            if not varNames[var] then
                varCounter = varCounter + 1
                local newVar = generateVarName()
                varNames[var] = newVar
                renamedCode = renamedCode:gsub("%f[%a_]" .. var .. "%f[%A_]", newVar)
            end
        end
        return renamedCode
    end
    
    -- First, rename all variables in the code
    local renamedCode = renameVariables(code)
    
    -- Now, encode each character into byte values
    local encoded = {}
    for i = 1, #renamedCode do
        table.insert(encoded, string.format("\"%d\"", string.byte(renamedCode, i)))
    end
    
    -- Return the obfuscated code as a function
    return "return (function(...)local " .. table.concat(varNames, ",") .. "={" .. table.concat(encoded, ",") .. "};local E=table.concat({" .. table.concat(varNames, ",") .. "});loadstring(E)();end)"
end





	if Rayfield then
		print([[

 _   _        __       _        _   _       _     
| | | |_ __  / _| __ _(_)_ __  | | | |_   _| |__  
| | | | '_ \| |_ / _` | | '__| | |_| | | | | '_ \ 
| |_| | | | |  _| (_| | | |    |  _  | |_| | |_) |
 \___/|_| |_|_|  \__,_|_|_|    |_| |_|\__,_|_.__/ 

]])
	end




	local GunESPEnabled = false
local GunESPFolder = Instance.new("Folder", game.CoreGui)
GunESPFolder.Name = "GunESPFolder"

-- Update Gun ESP
local function UpdateGunESP()
    -- Check if gun exists in workspace (means it's dropped)
    local gunTool = workspace:FindFirstChild("Gun")
    local highlight = GunESPFolder:FindFirstChild("GunHighlight")

    if gunTool and gunTool:IsA("Tool") then
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "GunHighlight"
            highlight.Adornee = gunTool:FindFirstChild("Handle") or gunTool
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.new(0, 0, 0)
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = GunESPFolder
        else
            highlight.Adornee = gunTool:FindFirstChild("Handle") or gunTool
        end
    elseif highlight then
        highlight:Destroy()
    end
end

-- ESP update loop
task.spawn(function()
    while true do
        if GunESPEnabled then
            UpdateGunESP()
        else
            for _, v in pairs(GunESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
        task.wait(1)
    end
end)


	local function GetPlayerCoins(player)
    local coins
    pcall(function()
        coins = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Coins")
        -- Alternative example: coins = player:WaitForChild("Data"):FindFirstChild("Coins")
    end)
    return coins
end
	local murdererESPEnabled = false
	local currentMurderer = nil
	local sheriffESPEnabled = false
	local currentSheriff = nil
	local espBox = nil
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local username = LocalPlayer.Name
	local userId = LocalPlayer.UserId
	local espEnabled = false
	local RunService = game:GetService("RunService")
	local highlights = {}
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local nameTags = {}
	local updateConnection
	local connection
	local playerNames = {}
	local playerDropdown = nil
	local Workspace = game:GetService("Workspace")
	local Executor = identifyexecutor and identifyexecutor() or "Unknown Executor"
	local AntiAFKEnabled = false
    local noclip = false
    local connection
	local selectedPlayerName = nil
	local flingConnection = nil

	local GunESPEnabled = false
local GunESPFolder = Instance.new("Folder", game.CoreGui)
GunESPFolder.Name = "GunESPFolder"

-- Update Gun ESP
local function UpdateGunESP()
    -- Check if gun exists in workspace (means it's dropped)
    local gunTool = workspace:FindFirstChild("Gun")
    local highlight = GunESPFolder:FindFirstChild("GunHighlight")

    if gunTool and gunTool:IsA("Tool") then
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "GunHighlight"
            highlight.Adornee = gunTool:FindFirstChild("Handle") or gunTool
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.new(0, 0, 0)
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = GunESPFolder
        else
            highlight.Adornee = gunTool:FindFirstChild("Handle") or gunTool
        end
    elseif highlight then
        highlight:Destroy()
    end
end

-- ESP update loop
task.spawn(function()
    while true do
        if GunESPEnabled then
            UpdateGunESP()
        else
            for _, v in pairs(GunESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
        task.wait(1)
    end
end)

	local TrapESPEnabled = false
local TrapESPFolder = Instance.new("Folder", game.CoreGui)
TrapESPFolder.Name = "TrapESPFolder"

-- Detect and highlight traps
local function UpdateTrapESP()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "Trap" and not TrapESPFolder:FindFirstChild(obj:GetDebugId(999)) then
            local trapHighlight = Instance.new("Highlight")
            trapHighlight.Name = obj:GetDebugId(999)
            trapHighlight.Adornee = obj
            trapHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            trapHighlight.FillColor = Color3.fromRGB(255, 0, 0)
            trapHighlight.FillTransparency = 0.5
            trapHighlight.OutlineColor = Color3.new(0, 0, 0)
            trapHighlight.OutlineTransparency = 0
            trapHighlight.Parent = TrapESPFolder
        end
    end

    -- Remove invalid ESPs
    for _, v in pairs(TrapESPFolder:GetChildren()) do
        if not v.Adornee or not v.Adornee:IsDescendantOf(workspace) then
            v:Destroy()
        end
    end
end

-- Auto update loop
task.spawn(function()
    while true do
        if TrapESPEnabled then
            UpdateTrapESP()
        else
            for _, v in pairs(TrapESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
        task.wait(1)
    end
end)



    local tracers = false
local tracerLines = {}

-- Create drawing lines
local function createLine(player)
	if player == LocalPlayer then return end
	if tracerLines[player] then return end

	local line = Drawing.new("Line")
	line.Visible = false
	line.Thickness = 1.5
	line.Color = Color3.fromRGB(0, 255, 0)
	tracerLines[player] = line
end

-- Remove lines
local function removeLine(player)
	if tracerLines[player] then
		tracerLines[player]:Remove()
		tracerLines[player] = nil
	end
end

-- Update tracer positions
RunService.RenderStepped:Connect(function()
	if not tracers then
		for _, line in pairs(tracerLines) do
			line.Visible = false
		end
		return
	end

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = player.Character.HumanoidRootPart
			local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)

			if not tracerLines[player] then
				createLine(player)
			end

			local line = tracerLines[player]
			if onScreen then
				line.Visible = true
				line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
				line.To = Vector2.new(screenPos.X, screenPos.Y)
			else
				line.Visible = false
			end
		elseif tracerLines[player] then
			tracerLines[player].Visible = false
		end
	end
end)

-- Player management
Players.PlayerRemoving:Connect(function(player)
	removeLine(player)
end)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		if tracers then
			createLine(player)
		end
	end)
end)

--esps

local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "ESPFolder"

-- Role Colors
local roleColors = {
    Murderer = Color3.fromRGB(255, 0, 0),
    Sheriff = Color3.fromRGB(0, 170, 255),
    Innocent = Color3.fromRGB(0, 255, 0)
}

-- Toggle states
local ModeAllRoles = false
local ModeMurdererOnly = false
local ModeSheriffOnly = false

-- Get role from tools
local function GetRole(player)
    local bp = player:FindFirstChildOfClass("Backpack")
    local char = player.Character
    if not bp or not char then return "Innocent" end

    if bp:FindFirstChild("Knife") or char:FindFirstChild("Knife") then
        return "Murderer"
    elseif bp:FindFirstChild("Gun") or char:FindFirstChild("Gun") then
        return "Sheriff"
    else
        return "Innocent"
    end
end

-- Update ESPs based on active mode
local function UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local role = GetRole(player)
            local shouldShow = false

            if ModeAllRoles then
                shouldShow = true
            elseif ModeMurdererOnly and role == "Murderer" then
                shouldShow = true
            elseif ModeSheriffOnly and role == "Sheriff" then
                shouldShow = true
            end

            local existing = ESPFolder:FindFirstChild(player.Name)

            if shouldShow then
                if not existing then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = player.Name
                    highlight.Adornee = player.Character
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.new(0, 0, 0)
                    highlight.OutlineTransparency = 0
                    highlight.Parent = ESPFolder
                    highlight.FillColor = roleColors[role] or Color3.new(1, 1, 1)
                else
                    existing.Adornee = player.Character
                    existing.FillColor = roleColors[role] or Color3.new(1, 1, 1)
                end
            elseif existing then
                existing:Destroy()
            end
        end
    end
end

-- Clear ESPs
local function ClearESP()
    for _, v in pairs(ESPFolder:GetChildren()) do
        v:Destroy()
    end
end

-- Loop to update
task.spawn(function()
    while true do
        if ModeAllRoles or ModeMurdererOnly or ModeSheriffOnly then
            UpdateESP()
        else
            ClearESP()
        end
        task.wait(1)
    end
end)

--end




local flying = false
local flyConnection
local speed = 60 -- How fast you want the fly to be

-- Main Fly Function
local function startFlying()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = humanoidRootPart.CFrame
    bodyGyro.Parent = humanoidRootPart

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = humanoidRootPart

    flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
        local camera = workspace.CurrentCamera
        local moveDirection = Vector3.new()

        if flying then
            moveDirection = Vector3.new(
                (game.UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (game.UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                (game.UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (game.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 1 or 0),
                (game.UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (game.UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
            )
            moveDirection = camera.CFrame:VectorToWorldSpace(moveDirection)
            bodyVelocity.Velocity = moveDirection * speed
            bodyGyro.CFrame = camera.CFrame
        else
            bodyVelocity.Velocity = Vector3.zero
        end
    end)
end

local function stopFlying()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        if hrp:FindFirstChild("BodyGyro") then
            hrp.BodyGyro:Destroy()
        end
        if hrp:FindFirstChild("BodyVelocity") then
            hrp.BodyVelocity:Destroy()
        end
    end
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
end

local flingEnabled = false
local spinConnection

local function startFling()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    -- Huge angular velocity to spin
    local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 999999, 0) -- spin really fast around Y axis
    bodyAngularVelocity.MaxTorque = Vector3.new(0, 9999999, 0)
    bodyAngularVelocity.P = 10000
    bodyAngularVelocity.Parent = hrp

    spinConnection = character.HumanoidRootPart.Touched:Connect(function(hit)
        if hit and hit.Parent and game.Players:GetPlayerFromCharacter(hit.Parent) then
            -- Optional: can add some extra force if you want even more flinging
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = hrp.CFrame.LookVector * 500
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Parent = hrp
            game.Debris:AddItem(bv, 0.1)
        end
    end)
end

local function stopFling()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        for _, child in ipairs(hrp:GetChildren()) do
            if child:IsA("BodyAngularVelocity") then
                child:Destroy()
            end
        end
    end
    if spinConnection then
        spinConnection:Disconnect()
        spinConnection = nil
    end
end

local CoinESPEnabled = false
local CoinESPFolder = Instance.new("Folder", game.CoreGui)
CoinESPFolder.Name = "CoinESPFolder"

-- Function to update Coin ESPs
local function UpdateCoinESP()
    for _, coin in pairs(workspace:GetDescendants()) do
        if coin:IsA("BasePart") and coin.Name == "Coin" and not CoinESPFolder:FindFirstChild(coin:GetDebugId(999)) then
            local coinHighlight = Instance.new("Highlight")
            coinHighlight.Name = coin:GetDebugId(999)
            coinHighlight.Adornee = coin
            coinHighlight.FillColor = Color3.fromRGB(255, 255, 0)
            coinHighlight.FillTransparency = 0.4
            coinHighlight.OutlineColor = Color3.new(0, 0, 0)
            coinHighlight.OutlineTransparency = 0
            coinHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            coinHighlight.Parent = CoinESPFolder
        end
    end

    -- Clean up old ESPs
    for _, v in pairs(CoinESPFolder:GetChildren()) do
        if not v.Adornee or not v.Adornee:IsDescendantOf(workspace) then
            v:Destroy()
        end
    end
end

-- Coin ESP Loop
task.spawn(function()
    while true do
        if CoinESPEnabled then
            UpdateCoinESP()
        else
            for _, v in pairs(CoinESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
        task.wait(1)
    end
end)





	setclipboard("https://discord.com/invite/7m6n24djSh")



	local CustomTheme = {
    TextColor = Color3.fromRGB(235, 235, 245),

    Background = Color3.fromRGB(15, 15, 15),
    Topbar = Color3.fromRGB(15, 15, 15),
    Shadow = Color3.fromRGB(10, 10, 10),

    NotificationBackground = Color3.fromRGB(25, 25, 30),
    NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

    TabBackground = Color3.fromRGB(35, 35, 40),
    TabStroke = Color3.fromRGB(50, 50, 60),
    TabBackgroundSelected = Color3.fromRGB(90, 140, 200),
    TabTextColor = Color3.fromRGB(200, 200, 210),
    SelectedTabTextColor = Color3.fromRGB(255, 255, 255),

    ElementBackground = Color3.fromRGB(30, 30, 35),
    ElementBackgroundHover = Color3.fromRGB(40, 40, 50),
    SecondaryElementBackground = Color3.fromRGB(25, 25, 30),
    ElementStroke = Color3.fromRGB(55, 55, 65),
    SecondaryElementStroke = Color3.fromRGB(45, 45, 55),

    SliderBackground = Color3.fromRGB(60, 120, 200),
    SliderProgress = Color3.fromRGB(100, 160, 240),
    SliderStroke = Color3.fromRGB(130, 180, 255),

    ToggleBackground = Color3.fromRGB(30, 30, 35),
    ToggleEnabled = Color3.fromRGB(70, 130, 180),
    ToggleDisabled = Color3.fromRGB(85, 85, 95),
    ToggleEnabledStroke = Color3.fromRGB(90, 160, 220),
    ToggleDisabledStroke = Color3.fromRGB(100, 100, 110),
    ToggleEnabledOuterStroke = Color3.fromRGB(45, 45, 55),
    ToggleDisabledOuterStroke = Color3.fromRGB(35, 35, 40),

    DropdownSelected = Color3.fromRGB(45, 45, 55),
    DropdownUnselected = Color3.fromRGB(35, 35, 40),

    InputBackground = Color3.fromRGB(30, 30, 35),
    InputStroke = Color3.fromRGB(55, 55, 65),
    PlaceholderColor = Color3.fromRGB(160, 160, 180)
}


	


    local Window = Rayfield:CreateWindow({
        Name = "Unfair Hub - v0.1 (Beta)",
        Icon = 0,
        LoadingTitle = "Unfair Hub",
        LoadingSubtitle = "Best Script!",
        Theme = CustomTheme,

        DisableRayfieldPrompts = true,
        DisableBuildWarnings = false,

        ConfigurationSaving = {
            Enabled = false,
            FolderName = Hello,
            FileName = "UnfairHub"
        },
		
		KeySystem = false, -- Set this to true to use our key system
   		KeySettings = {
      		Title = "Key System Unfair Hub",
      		Subtitle = "Key",
      		Note = "unfairhub", -- Use this to tell the user how to get a key
      		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      		Key = {"https://97a9a78b-ee0c-4262-bf72-1e1c8d52d41b-00-3944juhnetfvh.worf.replit.dev/"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   		}
    })

    local MainTab = Window:CreateTab("Home", 76315994129182)

	if not MainTab then
		game:GetService("Players").LocalPlayer:Kick("Fatal Error, Please Check Discord.")
	return 
end

	Rayfield:Notify({
   Title = "Warning",
   Content = "Script has error due to callback errors, etc please ensure that the script isnt fully useable, YET.",
   Duration = 20000000,
   Image = nil,
})





	local TimeLabel = MainTab:CreateLabel("--OS time")

-- Update the label every second
task.spawn(function()
    while true do
        local currentTime = os.date("%I:%M:%S %p") -- 12-hour format with AM/PM
        TimeLabel:Set("OS Time: " .. currentTime)
        task.wait(1)
    end
end)



	MainTab:CreateLabel("Welcome to Unfair Hub")	

    MainTab:CreateLabel("Welcome : " .. username)
	


	MainTab:CreateParagraph({
    Title = "Version 0.1 - Updates/Changelog",
    Content = [[
 [*] Script Hub :   
      [*] Optimized Script
	 [*] Adding more features
        ]]
    })


	MainTab:CreateLabel("Current Executor is: " .. Executor)

	




	local Tab = Window:CreateTab("MM2", "gamepad-2")
    local Esp = Tab:CreateSection("ESP")

	local Toggle = Tab:CreateToggle({
   		Name = "ESP All",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			ModeAllRoles = Value
        if Value then
            ModeMurdererOnly = false
            ModeSheriffOnly = false
        else
            ClearESP()
        end
   	end,
	})
	
	local Toggle = Tab:CreateToggle({
   		Name = "ESP Murderer",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			ModeMurdererOnly = Value
        if Value then
            ModeAllRoles = false
            ModeSheriffOnly = false
        else
            ClearESP()
        end
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "ESP Sheriff",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			ModeSheriffOnly = Value
        if Value then
            ModeAllRoles = false
            ModeMurdererOnly = false
        else
            ClearESP()
        end
   	end,
	})
	
	local Toggle = Tab:CreateToggle({
   		Name = "Trap Esp",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			TrapESPEnabled = Value
        if not Value then
            for _, v in pairs(TrapESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Gun Esp",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			GunESPEnabled = Value
        if not Value then
            for _, v in pairs(GunESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
   	end,
	})



    local Chams = Tab:CreateSection("Chams")


	local Toggle = Tab:CreateToggle({
   		Name = "Cham Coins",
   		CurrentValue = false,
   		Flag = "CoinESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			
   	end,
	})

	local Slider = Tab:CreateSlider({
   		Name = "Cham Opacity",
   		Range = {0, 100},
   		Increment = 10,
   		Suffix = "",
   		CurrentValue = 70,
   		Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
})

	local Effect = Tab:CreateSection("Effects")

	local Toggle = Tab:CreateToggle({
   		Name = "See dead Chat",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Role Notify",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			
   	end,
	})




	local RadiosMuted = false

-- Function to mute all radios (sounds in the game)
local function MuteRadios()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") then
            obj.Volume = 0  -- Mute the sound
        end
    end
end

-- Function to unmute all radios
local function UnmuteRadios()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") then
            obj.Volume = 1  -- Restore sound to normal volume
        end
    end
end

	local Toggle = Tab:CreateToggle({
   		Name = "Mute Radios",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			RadiosMuted = Value
        if RadiosMuted then
            MuteRadios()  -- Mute all radios when the toggle is enabled
        else
            UnmuteRadios()  -- Unmute radios when the toggle is disabled
        end
   	end,
	})









	local FPSBoostEnabled = false

-- Function to optimize FPS by disabling certain features
local function OptimizeFPS()
    -- Disable shadows (affects lighting performance)
    game:GetService("Lighting").GlobalShadows = false

    -- Disable certain post-processing effects that can impact FPS
    local lighting = game:GetService("Lighting")
    lighting.BloomEnabled = false
    lighting.AmbientOcclusionEnabled = false
    lighting.VignetteEnabled = false

    -- Reduce texture quality (to a lower setting)
    game:GetService("GraphicsSettings").QualityLevel = Enum.QualityLevel.Low

    -- Disable particle effects (to reduce visual load)
    for _, particle in pairs(workspace:GetDescendants()) do
        if particle:IsA("ParticleEmitter") then
            particle.Enabled = false
        end
    end
end

-- Function to restore normal graphics settings
local function RestoreGraphics()
    -- Enable shadows
    game:GetService("Lighting").GlobalShadows = true

    -- Enable post-processing effects
    local lighting = game:GetService("Lighting")
    lighting.BloomEnabled = true
    lighting.AmbientOcclusionEnabled = true
    lighting.VignetteEnabled = true

    -- Restore original texture quality
    game:GetService("GraphicsSettings").QualityLevel = Enum.QualityLevel.Medium

    -- Re-enable particle effects
    for _, particle in pairs(workspace:GetDescendants()) do
        if particle:IsA("ParticleEmitter") then
            particle.Enabled = true
        end
    end
end

	local Toggle = Tab:CreateToggle({
   		Name = "Better FPS",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			FPSBoostEnabled = Value
        if FPSBoostEnabled then
            OptimizeFPS()  -- Apply optimizations when the toggle is enabled
        else
            RestoreGraphics()  -- Restore original graphics settings when the toggle is disabled
        end
   	end,
	})


	local Player = Tab:CreateSection("Player")




	local invisible = false

-- Makes the player invisible
local function MakeInvisible()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = 1
        elseif part:IsA("Decal") or part:IsA("Accessory") then
            part:Destroy()
        end
    end

    local head = char:FindFirstChild("Head")
    if head and head:FindFirstChild("face") then
        head.face:Destroy()
    end
end

-- Restores visibility after death/reset
local function RestoreVisibility()
    local player = game.Players.LocalPlayer
    player.CharacterAdded:Connect(function(char)
        invisible = false
    end)
end

	local Button = Tab:CreateButton({
   		Name = "Invisible",
   		Callback = function()
			if not invisible then
            invisible = true
            MakeInvisible()
            RestoreVisibility()
            Rayfield:Notify({
                Title = "Invisibility Enabled",
                Content = "You are now invisible until death or reset.",
                Duration = 3
            })
        end
  	end,
	})

	local Tools = Tab:CreateSection("Tools")



	local autoAnnounceRoles = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to detect and announce roles
local function announceRoles()
    while autoAnnounceRoles do
        task.wait(2)

        local murderer, sheriff = nil, nil

        for _, player in pairs(Players:GetPlayers()) do
            if player and player:FindFirstChild("Backpack") then
                if player.Backpack:FindFirstChild("Knife") then
                    murderer = player
                elseif player.Backpack:FindFirstChild("Gun") then
                    sheriff = player
                end
            end
        end

        -- Announce murderer
        if murderer then
            if murderer == LocalPlayer then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Murderer: #######", "All")
            else
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Murderer: " .. murderer.Name, "All")
            end
        end

        -- Announce sheriff
        if sheriff then
            if sheriff == LocalPlayer then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Sheriff: #######", "All")
            else
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Sheriff: " .. sheriff.Name, "All")
            end
        end
    end
end

	local Toggle = Tab:CreateToggle({
   		Name = "Say Roles",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			autoAnnounceRoles = Value
        if Value then
            task.spawn(announceRoles)
        end
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Void Protect",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Mods = Tab:CreateSection("Mods")



	local autoGrabGun = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to grab the dropped gun
local function grabGunLoop()
    while autoGrabGun do
        task.wait(0.5)

        local map = workspace:FindFirstChild("Map")
        if map then
            local gunDrop = map:FindFirstChild("GunDrop")
            if gunDrop and gunDrop:IsA("Tool") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                -- Teleport to the dropped gun
                LocalPlayer.Character.HumanoidRootPart.CFrame = gunDrop.Handle.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
end

	local Toggle = Tab:CreateToggle({
   		Name = "Auto Get Gun",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			autoGrabGun = Value
        if autoGrabGun then
            task.spawn(grabGunLoop)
        end
   	end,
	})





	local UserInputService = game:GetService("UserInputService")


	local Keybind = Tab:CreateKeybind({
   Name = "Grab Gun",
   CurrentKeybind = "G",
   HoldToInteract = false,
   Flag = "GrabGunKeybind",
   Callback = function()
      local gun = Workspace:FindFirstChild("GunDrop")
      if gun and gun:IsA("Tool") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
         LocalPlayer.Character:PivotTo(gun.CFrame + Vector3.new(0, 3, 0))
      else
         Rayfield:Notify({
            Title = "Gun Not Found",
            Content = "No dropped gun was detected.",
            Duration = 3
         })
      end
   end,
})


local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")

local selectedSilentAim = "None"  -- Default Silent Aim
local selectedAimMode = "None"    -- Default Aim Mode
local enabledSilentAim = false    -- To enable/disable Silent Aim
local enabledAimMode = false      -- To enable/disable Aim Mode

-- Silent Aim Function (aims at the player's head or body)
local function silentAim()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
            if onScreen then
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Aim Mode Function (Static vs. Dynamic Aim)
local function dynamicAim()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Hook logic for Silent Aim or Aim Mode
RunService.RenderStepped:Connect(function()
    if enabledSilentAim or enabledAimMode then
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if not tool then return end

        local target = nil

        if enabledSilentAim and selectedSilentAim == "Silent" then
            target = silentAim()
        end

        if enabledAimMode then
            if selectedAimMode == "Static" then
                target = silentAim()  -- Static aim uses head aim
            elseif selectedAimMode == "Dynamic" then
                target = dynamicAim()  -- Dynamic aim adjusts continuously
            end
        end

        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = target.Character.HumanoidRootPart
            -- Adjust aim for knife or gun
            if tool.Name == "Knife" then
                tool.Handle.CFrame = CFrame.lookAt(tool.Handle.Position, hrp.Position)
            elseif tool.Name == "Gun" then
                tool.Handle.CFrame = CFrame.lookAt(tool.Handle.Position, hrp.Position)
            end
        end
    end
end)


Tab:CreateDropdown({
    Name = "Silent Aim",
    Options = {"None", "Silent"},
    CurrentOption = "None",  -- Default option
    Flag = "SilentAimDropdown",
    Callback = function(Option)
        selectedSilentAim = Option
        enabledSilentAim = (Option == "Silent")  -- Enable Silent Aim if selected
    end,
})

-- Aim Mode Dropdown (Static vs Dynamic)
Tab:CreateDropdown({
    Name = "Aim Mode",
    Options = {"None", "Static", "Dynamic"},
    CurrentOption = "None",  -- Default option
    Flag = "AimModeDropdown",
    Callback = function(Option)
        selectedAimMode = Option
        enabledAimMode = (Option ~= "None")  -- Enable Aim Mode if Static or Dynamic is selected
    end,
})




	local Label = Tab:CreateLabel("Checking gun status...")

	 -- Gun Check Loop
	task.spawn(function()
		while true do
			local gunDropped = Workspace:FindFirstChild("GunDrop")
			local sheriffAlive = false
	 
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player:FindFirstChild("Backpack") then
					local hasGun = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")
					if hasGun then
						sheriffAlive = true
						break
					end
				end
			end
	 
			if gunDropped then
				gunLabel:Set("🟢 Gun Dropped")
			else
				if sheriffAlive then
					gunLabel:Set("🔴 Gun not dropped")
				else
					gunLabel:Set("🔴 Gun not dropped (Sheriff may be dead)")
				end
			end
	 
			task.wait(1)
		end
	end)

	local Sheriff = Tab:CreateSection("Sheriff")

	local function getMurderer()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player:FindFirstChild("Character") then
            local role = player:FindFirstChild("MM2_Role")
            if role and role.Value == "Murderer" then
                return player
            end
        end
    end
    return nil
end

local function teleportBehind(target)
    local localChar = game.Players.LocalPlayer.Character
    local targetChar = target.Character
    if localChar and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
        local hrp = localChar:FindFirstChild("HumanoidRootPart")
        hrp.CFrame = targetChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4) -- Teleport behind
    end
end

local function shootGun()
    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool and tool.Name == "Gun" then
        tool:FindFirstChild("Handle"):FireServer()
    end
end



Tab:CreateButton({
   Name = "Auto Shoot Murderer",
   Callback = function()
       local murderer = getMurderer()
       if murderer then
           teleportBehind(murderer)
           task.wait(0.2)
           shootGun()
       else
           Rayfield:Notify({
               Title = "Murderer Not Found",
               Content = "Could not detect murderer!",
               Duration = 3
           })
       end
   end
})




local bankScannerEnabled = false

-- Function to disable the bank scanner for all players
local function disableBankScanner()
    -- Assuming the scanner has a script or functionality that can be disabled
    if bankScanner then
        -- Example: If there's a script that handles the scanner, you can disable it
        local scannerScript = bankScanner:FindFirstChild("ScannerScript")
        if scannerScript then
            scannerScript.Disabled = true
        end
        -- You can also manipulate other properties (e.g., visibility or interactions)
        bankScanner:Destroy()  -- If you want to remove the scanner completely, this destroys the part.
    end
end

-- Function to enable the bank scanner again
local function enableBankScanner()
    -- Example: If you just disable the scanner and want to re-enable it later
    if bankScanner then
        local scannerScript = bankScanner:FindFirstChild("ScannerScript")
        if scannerScript then
            scannerScript.Disabled = false
        end
        -- You can restore any other properties or reset the scanner here
    end
end

-- Create the toggle button for enabling/disabling the bank scanner
Tab:CreateToggle({
    Name = "Disable Bank Scanner",
    CurrentValue = bankScannerEnabled,  -- Set the default value based on whether the scanner is enabled
    Flag = "DisableBankScannerToggle",  -- Unique flag for saving the config
    Callback = function(Value)
        bankScannerEnabled = Value
        if bankScannerEnabled then
            enableBankScanner()  -- Re-enable the scanner if toggle is on
        else
            disableBankScanner()  -- Disable the scanner if toggle is off
        end
    end,
})

	local Murder = Tab:CreateSection("Murderer")



	local function isMurderer()
    local role = LocalPlayer:FindFirstChild("MM2_Role")
    return role and role.Value == "Murderer"
end

local function getKnifeTool()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
end

local function killAll()
    if not isMurderer() then
        Rayfield:Notify({
            Title = "You Are Not the Murderer",
            Content = "This feature only works when you're the Murderer.",
            Duration = 4
        })
        return
    end

    local knife = getKnifeTool()
    if not knife then
        Rayfield:Notify({
            Title = "Knife Not Found",
            Content = "Equip your knife before using Kill All.",
            Duration = 3
        })
        return
    end

    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local enemyHRP = player.Character.HumanoidRootPart
            local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myHRP then
                myHRP.CFrame = enemyHRP.CFrame * CFrame.new(0, 0, 2) -- Teleport close
                task.wait(0.2)
                pcall(function()
                    knife:FindFirstChild("Handle"):FireServer(enemyHRP)
                end)
            end
        end
    end
end

Tab:CreateButton({
   Name = "Kill All (Murderer Only)",
   Callback = function()
       killAll()
   end
})

	
	




	local lagging = false

-- Function to simulate global server lag by creating many parts for everyone
local function createGlobalLag()
    while lagging do
        -- Create a part in the Workspace to add load to the server
        local part = Instance.new("Part")
        part.Size = Vector3.new(100, 100, 100)
        part.Position = Vector3.new(math.random(-500, 500), math.random(0, 50), math.random(-500, 500))
        part.Anchored = true
        part.Parent = Workspace
        wait(0.01)  -- Adjust the frequency to control lag intensity
    end
end

-- Function to clean up lag by removing all the parts
local function stopGlobalLag()
    for _, part in pairs(Workspace:GetChildren()) do
        if part:IsA("Part") then
            part:Destroy()  -- Destroy any part that was created to simulate lag
        end
    end
end


	local Toggle = Tab:CreateToggle({
   		Name = "Make Server Lag",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			lagging = Value
        if lagging then
            createGlobalLag()  -- Start the loop to create parts and simulate lag
        else
            stopGlobalLag()  -- Stop creating parts and clean up the workspace
        end
   	end,
	})



	local Teleport = Tab:CreateSection("Teleport")

	
-- Function to find the lobby location
local function findLobbyPosition()
    local map = workspace:FindFirstChild("Lobby") or workspace:FindFirstChild("Map")
    if map then
        -- Look for a part or spawn named "Lobby" or something similar
        for _, part in pairs(map:GetDescendants()) do
            if part:IsA("BasePart") and part.Name:lower():find("lobby") then
                return part.Position
            end
        end
    end

    -- Fallback: Look for a SpawnLocation
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("SpawnLocation") and v.Name:lower():find("lobby") then
            return v.Position
        end
    end

    return nil
end

-- Function to teleport
local function teleportToLobby()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local lobbyPos = findLobbyPosition()
    if lobbyPos then
        root.CFrame = CFrame.new(lobbyPos + Vector3.new(0, 5, 0)) -- Offset slightly above ground
    else
        Rayfield:Notify({
            Title = "Lobby Not Found",
            Content = "Could not locate the lobby.",
            Duration = 4
        })
    end
end

	local Button = Tab:CreateButton({
   		Name = "Lobby",
   		Callback = function()
			teleportToLobby()
   		end,
	})

	local Button = Tab:CreateButton({
   		Name = "Map",
   		Callback = function()
			
   		end,
	})

	local Button = Tab:CreateButton({
   		Name = "Above Map",
   		Callback = function()
			
   		end,
	})

	local Button = Tab:CreateButton({
   		Name = "Murderer",
   		Callback = function()
			
   		end,
	})

	local Button = Tab:CreateButton({
   		Name = "Sheriff",
   		Callback = function()
			local function teleportToSheriff()
    -- Search for the Sheriff in the player list
    for _, player in pairs(Players:GetPlayers()) do
        -- Check if the player is not the LocalPlayer and has the Sheriff role
        if player ~= LocalPlayer and player.Character and player:FindFirstChild("HumanoidRootPart") then
            -- Assuming the role is stored in a Leaderboard or similar
            local playerRole = player:FindFirstChild("Role") -- Replace with actual role variable in your game

            -- If the player has the Sheriff role, teleport the LocalPlayer to them
            if playerRole and playerRole.Value == roleTag then
                local sheriffPosition = player.Character.HumanoidRootPart.Position
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(sheriffPosition)
                return
            end
        end
    end
    -- If no Sheriff found, notify the user
    print("No Sheriff found in the game.")
end
   		end,
	})

	local Spectate = Tab:CreateSection("Spectate")


	local Input = Tab:CreateInput({
   Name = "Spectate Player",
   CurrentValue = "",
   PlaceholderText = "Username",
   RemoveTextAfterFocusLost = true,
   Flag = "UsernameInput",
   Callback = function(inputText)
        inputText = inputText:lower() -- Make input lowercase
		local playerToSpectate = nil

        -- Find player ignoring case sensitivity
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Name:lower() == inputText then
                playerToSpectate = player
                break
            end
        end

        if playerToSpectate and playerToSpectate.Character and playerToSpectate.Character:FindFirstChild("Humanoid") then
            -- Switch the camera to spectate the player's humanoid
            workspace.CurrentCamera.CameraSubject = playerToSpectate.Character.Humanoid
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

            game.StarterGui:SetCore("SendNotification", {
                Title = "Spectating",
                Text = "Now Spectating: " .. playerToSpectate.Name,
                Duration = 3
            })
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error",
                Text = "Player not found or not spawned yet.",
                Duration = 3
            })
        end
   end,
})

	local Button = Tab:CreateButton({
    Name = "Stop Spectating",
    Flag = "StopSpectatingButton",
    Callback = function()
        -- Reset camera back to LocalPlayer's character when stopped
        local player = game.Players.LocalPlayer
        game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        game.StarterGui:SetCore("SendNotification", {
            Title = "Spectating Stopped",
            Text = "You are no longer spectating.",
            Duration = 3
        })
    end,
})

--Premium









local Bad = Window:CreateTab("Player", "globe")

Bad:CreateToggle({
    Name = "Esp",
    CurrentValue = false,
    Callback = function(Value)
        setESP(value)
    end,
})

Bad:CreateToggle({
    Name = "Tracers",
    CurrentValue = false,
    Callback = function(Value)
    end,
})

Bad:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(Value)
        noclip = Value
        if noclip then
            connection = game:GetService("RunService").Stepped:Connect(function()
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide == true then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
            -- Re-enable collisions when noclip is turned off
            if game.Players.LocalPlayer.Character then
                for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end,
})

Bad:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(Value)
        flying = Value
        if flying then
            startFlying()
        else
            stopFlying()
        end
    end,
})





local flingerEnabled = false

-- Function to fling another player
local function flingPlayer(player)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 500, 0) -- High Y force (upward fling)
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.P = 1e5
        bodyVelocity.Parent = hrp

        task.delay(0.3, function()
            bodyVelocity:Destroy()
        end)
    end
end

-- Touch detection
local function onTouched(hit)
    if not flingerEnabled then return end
    local character = hit:FindFirstAncestorOfClass("Model")
    local player = character and Players:GetPlayerFromCharacter(character)
    if player and player ~= LocalPlayer then
        flingPlayer(player)
    end
end

-- Connect to touch events
local function hookTouch()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.Touched:Connect(onTouched)
    end
end

-- Rehook on character added
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    hookTouch()
end)

-- Initial hook
if LocalPlayer.Character then
    hookTouch()
end

Bad:CreateToggle({
    Name = "Fling",
    CurrentValue = false,
    Callback = function(Value)
        flingerEnabled = Value
    end,
})

Bad:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").Health = 0
        end
    end,
})

Bad:CreateButton({
    Name = "God mode",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").Health = math.huge
        end
    end,
})

local Input = Bad:CreateInput({
    Name = "Set WalkSpeed",
    CurrentValue = "",
    PlaceholderText = "Enter WalkSpeed (e.g. 50)",
    RemoveTextAfterFocusLost = true,
    Flag = "WalkSpeedInput",
    Callback = function(Text)
        local speed = tonumber(Text)
        if speed and game.Players.LocalPlayer.Character then
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
        end
    end,
})

local Input = Bad:CreateInput({
    Name = "Set JumpPower",
    CurrentValue = "",
    PlaceholderText = "Enter JumpPower (e.g. 100)",
    RemoveTextAfterFocusLost = true,
    Flag = "JumpPowerInput",
    Callback = function(Text)
        local power = tonumber(Text)
        if power and game.Players.LocalPlayer.Character then
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = power
            end
        end
    end,
})

local InfiniteJumpEnabled = false

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)


local Toggle = Bad:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end,
})





















	local Misc = Window:CreateTab("Scripts", "code")

	local Label = Misc:CreateLabel("We are working on other games!")

	local Dropdown = Misc:CreateDropdown({
		Name = "Murder Mystery 2",
		Options = {"Copy"},
		CurrentOption = {""},
		MultipleOptions = false,
		Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
		Callback = function(Options)
			setclipboard("142823291")
		end,
	})

	local Premium = Window:CreateTab("Premium", "star")

	local Robux = Premium:CreateLabel("Get more Features with Unfair Hub Premium")
	local Legit = Premium:CreateLabel("Very Cheap and fun, just for 400 Robux!")

	Premium:CreateParagraph({
    	Title = "Features",
    	Content = [[  
   [*] Breaking Game features
      [*] Commands For Alt!
	 [*] More Scripts!
        ]]
    })

	Premium:CreateParagraph({
    	Title = "Steps to get Premium",
		Content = [[
    [1] Join the copied discord link
	[2] go to the support ticket
	[3] create ticket
	[4] wait for dev or admin
	[5] Buy gamepass that linked
	[6] Give Hwid (required)
        ]]
    })

	local FE = Window:CreateTab("FE Scripts", "scroll")

	local Button = FE:CreateButton({
        Name = "Infinity yield (OP)",
        Callback = function()
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "System Broken",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"))()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "FE YEET GUI (Troll Face Edition)",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/zJYDDPS3",true))()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "Eclipse Hub",
        Callback = function()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "Dark Dex",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Keyless-dex-working-new-25658"))()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "Quirky Cmd",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Cubbbe/CMD-Thingy/refs/heads/main/Quirky%20CMD",true))()
            
            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "Chat Bypasser",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/shadow62x/catbypass/main/upfix"))()
            
            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

	local Leel = FE:CreateSection("Custom Script")


	local inputCode = ""

-- Input Box
FE:CreateInput({
    Name = "Custom Loadstring",
    CurrentValue = "",
    PlaceholderText = 'Paste full loadstring here...',
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(Text)
        inputCode = Text
    end,
})

-- Button to run the loadstring
FE:CreateButton({
    Name = "Execute Loadstring",
    Callback = function()
        if inputCode ~= "" and inputCode:lower():find("loadstring") then
            local success, err = pcall(function()
                loadstring(inputCode)()
            end)
            if not success then
                warn("Error executing script:", err)
            end
        else
            warn("Invalid or empty loadstring.")
        end
    end,
})








	local No = Window:CreateTab("Troll", 2005276185)



	local PlayerList = {}
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(PlayerList, player.Name)
    end
end

-- Dropdown for Player Selection
local Dropdown = No:CreateDropdown({
    Name = "Select Player",
    Options = PlayerList,
    CurrentOption = PlayerList[1],  -- Default to the first player in the list
    MultipleOptions = false,
    Flag = "PlayerDropdown",  -- A unique flag for configuration saving
    Callback = function(Options)
        selectedPlayerName = Options[1]  -- Only one option can be selected, so it's the first in the table
    end,
})

-- Auto update player list
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        table.insert(PlayerList, player.Name)
        Dropdown:Set(PlayerList)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(PlayerList) do
        if name == player.Name then
            table.remove(PlayerList, i)
            break
        end
    end
    Dropdown:Set(PlayerList)
end)

-- Fling logic
local function startFling(target)
    if not target then return end
    local character = target.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local hrp = character.HumanoidRootPart
    flingConnection = game:GetService("RunService").Heartbeat:Connect(function()
        hrp.Velocity = Vector3.new(9999, 9999, 9999)
    end)
end

local function stopFling()
    if flingConnection then
        flingConnection:Disconnect()
        flingConnection = nil
    end
end

-- Fling Button
No:CreateButton({
    Name = "Fling",
    Callback = function()
        local targetPlayer = Players:FindFirstChild(selectedPlayerName)
        if targetPlayer then
            startFling(targetPlayer)
        end
    end,
})

-- Stop Fling Button
No:CreateButton({
    Name = "Stop Fling",
    Callback = function()
        stopFling()
    end,
})

local Sniper = No:CreateSection("Stream Snipe / snipe")

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")


No:CreateInput({
    Name = "Target Username",
    PlaceholderText = "Enter exact username",
    RemoveTextAfterFocusLost = false,
    Flag = "TargetUserInput",
    Callback = function(input)
        TargetUsername = input
    end,
})

-- Join Button
No:CreateButton({
    Name = "Join Player's Server",
    Callback = function()
        if not TargetUsername or TargetUsername == "" then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please enter a username.",
                Duration = 4,
            })
            return
        end

        -- Step 1: Get userId from username
        local success, result = pcall(function()
            return game:HttpGet("https://api.roblox.com/users/get-by-username?username=" .. TargetUsername)
        end)

        if not success then
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to get user info.",
                Duration = 4,
            })
            return
        end

        local data = HttpService:JSONDecode(result)
        if not data.Id then
            Rayfield:Notify({
                Title = "Invalid Username",
                Content = "User not found.",
                Duration = 4,
            })
            return
        end

        local userId = data.Id

        -- Step 2: Check online status
        local success2, presenceRaw = pcall(function()
            return game:HttpGet("https://api.roblox.com/users/" .. userId .. "/onlinestatus/")
        end)

        if not success2 then
            Rayfield:Notify({
                Title = "Error",
                Content = "Could not check online status.",
                Duration = 4,
            })
            return
        end

        local presence = HttpService:JSONDecode(presenceRaw)
        if presence.IsOnline and presence.PlaceId and presence.GameId then
            -- Step 3: Teleport
            TeleportService:TeleportToPlaceInstance(presence.PlaceId, presence.GameId, Players.LocalPlayer)
        else
            Rayfield:Notify({
                Title = "Not In Game",
                Content = "User is not in a public server.",
                Duration = 4,
            })
        end
    end,
})

local May = Window:CreateTab("Tools", "book") --- Lucide Icons on : lucide.de

local urlInput = ""

-- Input for raw script URL
May:CreateInput({
    Name = "Script URL",
    CurrentValue = "",
    PlaceholderText = "Paste raw link here...",
    RemoveTextAfterFocusLost = false,
    Flag = "ScriptURL",
    Callback = function(Text)
        urlInput = Text
    end,
})

-- Button to convert to loadstring and copy to clipboard
May:CreateButton({
    Name = "Make Loadstring",
    Callback = function()
        if urlInput:match("^https?://") then
            local loadstringCode = 'loadstring(game:HttpGet("' .. urlInput .. '"))()'
            setclipboard(loadstringCode)
            print("Copied to clipboard:\n" .. loadstringCode)
        else
            warn("Please enter a valid URL starting with http or https.")
        end
    end,
})

local Obf = May:CreateSection("Obfuscator")

local Label = May:CreateLabel("Comming Soon...", nil)





















	local Set = Window:CreateTab("Settings", "settings")

	local Label = Set:CreateLabel("Everything is OFF so activate ur settings!", nil, Color3.fromRGB(255, 0, 0), false) -- Title, Icon, Color, IgnoreTheme

	local AntiFlingRunning = false
	local AntiFlingConnection

Set:CreateToggle({
    Name = "Anti-Fling",
    CurrentValue = false,
    Flag = "AntiFlingToggle",
    Callback = function(Value)
        if Value and not AntiFlingRunning then
            AntiFlingRunning = true

            local lp = game.Players.LocalPlayer
            local char = lp.Character or lp.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")

            AntiFlingConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if hrp.Velocity.Magnitude > 100 then -- if you're suddenly being flung
                    hrp.Anchored = true
                elseif hrp.Anchored and hrp.Velocity.Magnitude < 5 then
                    hrp.Anchored = false
                end
            end)

        elseif not Value and AntiFlingRunning then
            AntiFlingRunning = false
            if AntiFlingConnection then
                AntiFlingConnection:Disconnect()
            end

            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Anchored = false
            end
        end
    end
})

local AntiVoidEnabled = false
local AntiVoidConnection
local safePosition = nil

Set:CreateToggle({
    Name = "Anti-Void",
    CurrentValue = false,
    Flag = "AntiVoidToggle",
    Callback = function(Value)
        local lp = game.Players.LocalPlayer
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        if Value and not AntiVoidEnabled then
            AntiVoidEnabled = true
            safePosition = hrp.Position

            AntiVoidConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if hrp.Position.Y < -20 then
                    hrp.Velocity = Vector3.zero
                    hrp.CFrame = CFrame.new(safePosition + Vector3.new(0, 5, 0)) -- TP slightly above safe spot
                end
            end)

        elseif not Value and AntiVoidEnabled then
            AntiVoidEnabled = false
            if AntiVoidConnection then
                AntiVoidConnection:Disconnect()
                AntiVoidConnection = nil
            end
        end
    end
})

local Toggle = Set:CreateToggle({
   Name = "Anti AFK",
   CurrentValue = false,
   Flag = "AntiAFKToggle",
   Callback = function(Value)
      AntiAFKEnabled = Value

      if AntiAFKEnabled then
         -- Notify when Anti-AFK is activated
         game.StarterGui:SetCore("SendNotification", {
            Title = "Anti AFK",
            Text = "Anti-AFK Activated! 🕹️",
            Duration = 3
         })
      end
   end,
})

-- Function to keep player active when Anti-AFK is on
task.spawn(function()
   while true do
      if AntiAFKEnabled then
         -- Simulate minor movement or action to prevent AFK kick
         game:GetService("Players").LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 0))
         -- You can also make small chat messages or animations to simulate activity

         -- Wait a short period to avoid heavy resource usage
         task.wait(5) -- Every 5 seconds
      end
      task.wait(1)
   end
end)

Set:CreateToggle({
   Name = "Auto Rejoin (10 minutes)",
   CurrentValue = false,
   Flag = "AutoRejoinToggle",
   Callback = function(Value)
      AutoRejoinEnabled = Value

      if AutoRejoinEnabled then
         -- Show notification when enabled
         game.StarterGui:SetCore("SendNotification", {
            Title = "Auto Rejoin",
            Text = "Auto Rejoin enabled. You will rejoin after 10 minutes.",
            Duration = 5,
         })

         -- Start loop
         AutoRejoinThread = task.spawn(function()
            while AutoRejoinEnabled do
               task.wait(600) -- 10 minutes
               if AutoRejoinEnabled then
                  game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
               end
            end
         end)
      else
         -- Cancel loop if disabled
         if AutoRejoinThread then
            task.cancel(AutoRejoinThread)
            AutoRejoinThread = nil
         end

         -- Show notification when disabled
         game.StarterGui:SetCore("SendNotification", {
            Title = "Auto Rejoin",
            Text = "Auto Rejoin has been disabled.",
            Duration = 5,
         })
      end
   end,
})

Set:CreateButton({
	Name = "Rejoin Server",
	Callback = function()
		local TeleportService = game:GetService("TeleportService")
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer

		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	end
})

Set:CreateButton({
	Name = "Server Hop",
	Callback = function()
		local TeleportService = game:GetService("TeleportService")
		local HttpService = game:GetService("HttpService")
		local Players = game:GetService("Players")

		local function ServerHop()
			local Servers = {}
			local Cursor = ""
			local JobId = game.JobId

			local function FetchServers()
				local URL = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"..(Cursor ~= "" and "&cursor="..Cursor or "")
				local Response = HttpService:JSONDecode(game:HttpGet(URL))
				return Response
			end

			local function TryHop()
				local Data = FetchServers()
				if Data and Data.data then
					for _, server in ipairs(Data.data) do
						if server.playing < server.maxPlayers and server.id ~= JobId then
							TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Players.LocalPlayer)
							return true
						end
					end
				end
				Cursor = Data.nextPageCursor or ""
				return false
			end

			repeat until TryHop() or Cursor == ""
		end

		ServerHop()
	end
})

local Toggle = Set:CreateToggle({
   Name = "Anti Kick",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      getgenv().AntiKick = Value

      -- Roblox Notification
      game.StarterGui:SetCore("SendNotification", {
         Title = "AntiKick System",
         Text = Value and "Anti Kick Activated 🛡️" or "Anti Kick Deactivated ❌",
         Duration = 5
      })
   end,
})

local Toggle = Set:CreateToggle({
   Name = "Anti HWID Ban",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      getgenv().AntiHwidBan = Value

      -- Roblox Notification
      game.StarterGui:SetCore("SendNotification", {
         Title = "AntiBan System",
         Text = Value and "Anti HWID Ban active 🛡️" or "Anti HWID Ban inactive ❌",
         Duration = 5
      })
   end,
})

local Toggle = Set:CreateToggle({
   Name = "Anti IP Ban",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      getgenv().AntiIpBan = Value

      -- Roblox Notification
      game.StarterGui:SetCore("SendNotification", {
         Title = "AntiBan System",
         Text = Value and "Anti Ip Ban active 🛡️" or "Anti ip Ban inactive ❌",
         Duration = 5
      })
   end,
})

local Button = Set:CreateButton({
   Name = "Kill UI",
   Callback = function()
		Rayfield:Destroy()
   end,
})








	local function showNotification(title, text)
    -- Ensure it runs on the local player to show the notification
    local success, errorMsg = pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
			Icon = "rbxassetid://607866915",
            Duration = 10  -- Duration in seconds (adjust as needed)
        })
    end)

    if not success then
        warn("Failed to send notification:", errorMsg)
    end
end

-- Example usage
showNotification("Unfair Hub Loaded", "The Script loaded sucessfully.")




	local function Sound()
        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://9068539820"
        Sound.Volume = 1
        Sound.Parent = game:GetService("SoundService")
        Sound:Play()
        game:GetService("Debris"):AddItem(Sound, 2)
    end

    Sound()

--end
--if game.PlaceId == 142823291 then

debugX = true

if not readfile or not isfile then game.Players.LocalPlayer:Kick("Unsupported Executor") return end

getgenv().SecureMode = Value

getgenv().AntiKick = false
getgenv().AntiHwidBan = false
getgenv().AntiIpBan = false
getgenv().BypassChat = false

	local Rayfield = loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnfairLTD/Xploits/refs/heads/main/Source')))()




	local function generateVarName()
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local name = ""
    for i = 1, 3 do  -- Variable names will be 3 characters long
        name = name .. chars:sub(math.random(1, #chars), math.random(1, #chars))
    end
    return name
end

-- Strong obfuscation function with random variable renaming and encoding
local function strongObfuscate(code)
    -- Create a table to store renamed variables
    local varNames = {}
    
    -- Function to replace variable names in the code
    local function renameVariables(code)
        local renamedCode = code
        local varCounter = 0
        -- Pattern to find variable names (e.g., `local a, b, c`)
        for var in code:gmatch("[%a_][%w_]*") do
            if not varNames[var] then
                varCounter = varCounter + 1
                local newVar = generateVarName()
                varNames[var] = newVar
                renamedCode = renamedCode:gsub("%f[%a_]" .. var .. "%f[%A_]", newVar)
            end
        end
        return renamedCode
    end
    
    -- First, rename all variables in the code
    local renamedCode = renameVariables(code)
    
    -- Now, encode each character into byte values
    local encoded = {}
    for i = 1, #renamedCode do
        table.insert(encoded, string.format("\"%d\"", string.byte(renamedCode, i)))
    end
    
    -- Return the obfuscated code as a function
    return "return (function(...)local " .. table.concat(varNames, ",") .. "={" .. table.concat(encoded, ",") .. "};local E=table.concat({" .. table.concat(varNames, ",") .. "});loadstring(E)();end)"
end





	if Rayfield then
		print([[

 _   _        __       _        _   _       _     
| | | |_ __  / _| __ _(_)_ __  | | | |_   _| |__  
| | | | '_ \| |_ / _` | | '__| | |_| | | | | '_ \ 
| |_| | | | |  _| (_| | | |    |  _  | |_| | |_) |
 \___/|_| |_|_|  \__,_|_|_|    |_| |_|\__,_|_.__/ 

]])
	end




	local GunESPEnabled = false
local GunESPFolder = Instance.new("Folder", game.CoreGui)
GunESPFolder.Name = "GunESPFolder"

-- Update Gun ESP
local function UpdateGunESP()
    -- Check if gun exists in workspace (means it's dropped)
    local gunTool = workspace:FindFirstChild("Gun")
    local highlight = GunESPFolder:FindFirstChild("GunHighlight")

    if gunTool and gunTool:IsA("Tool") then
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "GunHighlight"
            highlight.Adornee = gunTool:FindFirstChild("Handle") or gunTool
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.new(0, 0, 0)
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = GunESPFolder
        else
            highlight.Adornee = gunTool:FindFirstChild("Handle") or gunTool
        end
    elseif highlight then
        highlight:Destroy()
    end
end

-- ESP update loop
task.spawn(function()
    while true do
        if GunESPEnabled then
            UpdateGunESP()
        else
            for _, v in pairs(GunESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
        task.wait(1)
    end
end)


	local function GetPlayerCoins(player)
    local coins
    pcall(function()
        coins = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Coins")
        -- Alternative example: coins = player:WaitForChild("Data"):FindFirstChild("Coins")
    end)
    return coins
end
	local murdererESPEnabled = false
	local currentMurderer = nil
	local sheriffESPEnabled = false
	local currentSheriff = nil
	local espBox = nil
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local username = LocalPlayer.Name
	local userId = LocalPlayer.UserId
	local espEnabled = false
	local RunService = game:GetService("RunService")
	local highlights = {}
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local nameTags = {}
	local updateConnection
	local connection
	local playerNames = {}
	local playerDropdown = nil
	local Workspace = game:GetService("Workspace")
	local Executor = identifyexecutor and identifyexecutor() or "Unknown Executor"
	local AntiAFKEnabled = false
    local noclip = false
    local connection
	local selectedPlayerName = nil
	local flingConnection = nil

	local GunESPEnabled = false
local GunESPFolder = Instance.new("Folder", game.CoreGui)
GunESPFolder.Name = "GunESPFolder"

-- Update Gun ESP
local function UpdateGunESP()
    -- Check if gun exists in workspace (means it's dropped)
    local gunTool = workspace:FindFirstChild("Gun")
    local highlight = GunESPFolder:FindFirstChild("GunHighlight")

    if gunTool and gunTool:IsA("Tool") then
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "GunHighlight"
            highlight.Adornee = gunTool:FindFirstChild("Handle") or gunTool
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.new(0, 0, 0)
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = GunESPFolder
        else
            highlight.Adornee = gunTool:FindFirstChild("Handle") or gunTool
        end
    elseif highlight then
        highlight:Destroy()
    end
end

-- ESP update loop
task.spawn(function()
    while true do
        if GunESPEnabled then
            UpdateGunESP()
        else
            for _, v in pairs(GunESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
        task.wait(1)
    end
end)

	local TrapESPEnabled = false
local TrapESPFolder = Instance.new("Folder", game.CoreGui)
TrapESPFolder.Name = "TrapESPFolder"

-- Detect and highlight traps
local function UpdateTrapESP()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "Trap" and not TrapESPFolder:FindFirstChild(obj:GetDebugId(999)) then
            local trapHighlight = Instance.new("Highlight")
            trapHighlight.Name = obj:GetDebugId(999)
            trapHighlight.Adornee = obj
            trapHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            trapHighlight.FillColor = Color3.fromRGB(255, 0, 0)
            trapHighlight.FillTransparency = 0.5
            trapHighlight.OutlineColor = Color3.new(0, 0, 0)
            trapHighlight.OutlineTransparency = 0
            trapHighlight.Parent = TrapESPFolder
        end
    end

    -- Remove invalid ESPs
    for _, v in pairs(TrapESPFolder:GetChildren()) do
        if not v.Adornee or not v.Adornee:IsDescendantOf(workspace) then
            v:Destroy()
        end
    end
end

-- Auto update loop
task.spawn(function()
    while true do
        if TrapESPEnabled then
            UpdateTrapESP()
        else
            for _, v in pairs(TrapESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
        task.wait(1)
    end
end)



    local tracers = false
local tracerLines = {}

-- Create drawing lines
local function createLine(player)
	if player == LocalPlayer then return end
	if tracerLines[player] then return end

	local line = Drawing.new("Line")
	line.Visible = false
	line.Thickness = 1.5
	line.Color = Color3.fromRGB(0, 255, 0)
	tracerLines[player] = line
end

-- Remove lines
local function removeLine(player)
	if tracerLines[player] then
		tracerLines[player]:Remove()
		tracerLines[player] = nil
	end
end

-- Update tracer positions
RunService.RenderStepped:Connect(function()
	if not tracers then
		for _, line in pairs(tracerLines) do
			line.Visible = false
		end
		return
	end

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = player.Character.HumanoidRootPart
			local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)

			if not tracerLines[player] then
				createLine(player)
			end

			local line = tracerLines[player]
			if onScreen then
				line.Visible = true
				line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
				line.To = Vector2.new(screenPos.X, screenPos.Y)
			else
				line.Visible = false
			end
		elseif tracerLines[player] then
			tracerLines[player].Visible = false
		end
	end
end)

-- Player management
Players.PlayerRemoving:Connect(function(player)
	removeLine(player)
end)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		if tracers then
			createLine(player)
		end
	end)
end)

--esps

local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "ESPFolder"

-- Role Colors
local roleColors = {
    Murderer = Color3.fromRGB(255, 0, 0),
    Sheriff = Color3.fromRGB(0, 170, 255),
    Innocent = Color3.fromRGB(0, 255, 0)
}

-- Toggle states
local ModeAllRoles = false
local ModeMurdererOnly = false
local ModeSheriffOnly = false

-- Get role from tools
local function GetRole(player)
    local bp = player:FindFirstChildOfClass("Backpack")
    local char = player.Character
    if not bp or not char then return "Innocent" end

    if bp:FindFirstChild("Knife") or char:FindFirstChild("Knife") then
        return "Murderer"
    elseif bp:FindFirstChild("Gun") or char:FindFirstChild("Gun") then
        return "Sheriff"
    else
        return "Innocent"
    end
end

-- Update ESPs based on active mode
local function UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local role = GetRole(player)
            local shouldShow = false

            if ModeAllRoles then
                shouldShow = true
            elseif ModeMurdererOnly and role == "Murderer" then
                shouldShow = true
            elseif ModeSheriffOnly and role == "Sheriff" then
                shouldShow = true
            end

            local existing = ESPFolder:FindFirstChild(player.Name)

            if shouldShow then
                if not existing then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = player.Name
                    highlight.Adornee = player.Character
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.new(0, 0, 0)
                    highlight.OutlineTransparency = 0
                    highlight.Parent = ESPFolder
                    highlight.FillColor = roleColors[role] or Color3.new(1, 1, 1)
                else
                    existing.Adornee = player.Character
                    existing.FillColor = roleColors[role] or Color3.new(1, 1, 1)
                end
            elseif existing then
                existing:Destroy()
            end
        end
    end
end

-- Clear ESPs
local function ClearESP()
    for _, v in pairs(ESPFolder:GetChildren()) do
        v:Destroy()
    end
end

-- Loop to update
task.spawn(function()
    while true do
        if ModeAllRoles or ModeMurdererOnly or ModeSheriffOnly then
            UpdateESP()
        else
            ClearESP()
        end
        task.wait(1)
    end
end)

--end




local flying = false
local flyConnection
local speed = 60 -- How fast you want the fly to be

-- Main Fly Function
local function startFlying()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = humanoidRootPart.CFrame
    bodyGyro.Parent = humanoidRootPart

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = humanoidRootPart

    flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
        local camera = workspace.CurrentCamera
        local moveDirection = Vector3.new()

        if flying then
            moveDirection = Vector3.new(
                (game.UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (game.UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                (game.UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (game.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 1 or 0),
                (game.UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (game.UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
            )
            moveDirection = camera.CFrame:VectorToWorldSpace(moveDirection)
            bodyVelocity.Velocity = moveDirection * speed
            bodyGyro.CFrame = camera.CFrame
        else
            bodyVelocity.Velocity = Vector3.zero
        end
    end)
end

local function stopFlying()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        if hrp:FindFirstChild("BodyGyro") then
            hrp.BodyGyro:Destroy()
        end
        if hrp:FindFirstChild("BodyVelocity") then
            hrp.BodyVelocity:Destroy()
        end
    end
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
end

local flingEnabled = false
local spinConnection

local function startFling()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    -- Huge angular velocity to spin
    local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 999999, 0) -- spin really fast around Y axis
    bodyAngularVelocity.MaxTorque = Vector3.new(0, 9999999, 0)
    bodyAngularVelocity.P = 10000
    bodyAngularVelocity.Parent = hrp

    spinConnection = character.HumanoidRootPart.Touched:Connect(function(hit)
        if hit and hit.Parent and game.Players:GetPlayerFromCharacter(hit.Parent) then
            -- Optional: can add some extra force if you want even more flinging
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = hrp.CFrame.LookVector * 500
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Parent = hrp
            game.Debris:AddItem(bv, 0.1)
        end
    end)
end

local function stopFling()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        for _, child in ipairs(hrp:GetChildren()) do
            if child:IsA("BodyAngularVelocity") then
                child:Destroy()
            end
        end
    end
    if spinConnection then
        spinConnection:Disconnect()
        spinConnection = nil
    end
end

local CoinESPEnabled = false
local CoinESPFolder = Instance.new("Folder", game.CoreGui)
CoinESPFolder.Name = "CoinESPFolder"

-- Function to update Coin ESPs
local function UpdateCoinESP()
    for _, coin in pairs(workspace:GetDescendants()) do
        if coin:IsA("BasePart") and coin.Name == "Coin" and not CoinESPFolder:FindFirstChild(coin:GetDebugId(999)) then
            local coinHighlight = Instance.new("Highlight")
            coinHighlight.Name = coin:GetDebugId(999)
            coinHighlight.Adornee = coin
            coinHighlight.FillColor = Color3.fromRGB(255, 255, 0)
            coinHighlight.FillTransparency = 0.4
            coinHighlight.OutlineColor = Color3.new(0, 0, 0)
            coinHighlight.OutlineTransparency = 0
            coinHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            coinHighlight.Parent = CoinESPFolder
        end
    end

    -- Clean up old ESPs
    for _, v in pairs(CoinESPFolder:GetChildren()) do
        if not v.Adornee or not v.Adornee:IsDescendantOf(workspace) then
            v:Destroy()
        end
    end
end

-- Coin ESP Loop
task.spawn(function()
    while true do
        if CoinESPEnabled then
            UpdateCoinESP()
        else
            for _, v in pairs(CoinESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
        task.wait(1)
    end
end)





	setclipboard("https://discord.com/invite/7m6n24djSh")



	local CustomTheme = {
    TextColor = Color3.fromRGB(235, 235, 245),

    Background = Color3.fromRGB(15, 15, 15),
    Topbar = Color3.fromRGB(15, 15, 15),
    Shadow = Color3.fromRGB(10, 10, 10),

    NotificationBackground = Color3.fromRGB(25, 25, 30),
    NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

    TabBackground = Color3.fromRGB(35, 35, 40),
    TabStroke = Color3.fromRGB(50, 50, 60),
    TabBackgroundSelected = Color3.fromRGB(90, 140, 200),
    TabTextColor = Color3.fromRGB(200, 200, 210),
    SelectedTabTextColor = Color3.fromRGB(255, 255, 255),

    ElementBackground = Color3.fromRGB(30, 30, 35),
    ElementBackgroundHover = Color3.fromRGB(40, 40, 50),
    SecondaryElementBackground = Color3.fromRGB(25, 25, 30),
    ElementStroke = Color3.fromRGB(55, 55, 65),
    SecondaryElementStroke = Color3.fromRGB(45, 45, 55),

    SliderBackground = Color3.fromRGB(60, 120, 200),
    SliderProgress = Color3.fromRGB(100, 160, 240),
    SliderStroke = Color3.fromRGB(130, 180, 255),

    ToggleBackground = Color3.fromRGB(30, 30, 35),
    ToggleEnabled = Color3.fromRGB(70, 130, 180),
    ToggleDisabled = Color3.fromRGB(85, 85, 95),
    ToggleEnabledStroke = Color3.fromRGB(90, 160, 220),
    ToggleDisabledStroke = Color3.fromRGB(100, 100, 110),
    ToggleEnabledOuterStroke = Color3.fromRGB(45, 45, 55),
    ToggleDisabledOuterStroke = Color3.fromRGB(35, 35, 40),

    DropdownSelected = Color3.fromRGB(45, 45, 55),
    DropdownUnselected = Color3.fromRGB(35, 35, 40),

    InputBackground = Color3.fromRGB(30, 30, 35),
    InputStroke = Color3.fromRGB(55, 55, 65),
    PlaceholderColor = Color3.fromRGB(160, 160, 180)
}


	


    local Window = Rayfield:CreateWindow({
        Name = "Unfair Hub - v0.1 (Beta)",
        Icon = 0,
        LoadingTitle = "Unfair Hub",
        LoadingSubtitle = "Best Script!",
        Theme = CustomTheme,

        DisableRayfieldPrompts = true,
        DisableBuildWarnings = false,

        ConfigurationSaving = {
            Enabled = false,
            FolderName = Hello,
            FileName = "UnfairHub"
        },
		
		KeySystem = false, -- Set this to true to use our key system
   		KeySettings = {
      		Title = "Key System Unfair Hub",
      		Subtitle = "Key",
      		Note = "unfairhub", -- Use this to tell the user how to get a key
      		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      		Key = {"https://97a9a78b-ee0c-4262-bf72-1e1c8d52d41b-00-3944juhnetfvh.worf.replit.dev/"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   		}
    })

    local MainTab = Window:CreateTab("Home", 76315994129182)

	if not MainTab then
		game:GetService("Players").LocalPlayer:Kick("Fatal Error, Please Check Discord.")
	return 
end

	Rayfield:Notify({
   Title = "Warning",
   Content = "Script has error due to callback errors, etc please ensure that the script isnt fully useable, YET.",
   Duration = 20000000,
   Image = nil,
})





	local TimeLabel = MainTab:CreateLabel("--OS time")

-- Update the label every second
task.spawn(function()
    while true do
        local currentTime = os.date("%I:%M:%S %p") -- 12-hour format with AM/PM
        TimeLabel:Set("OS Time: " .. currentTime)
        task.wait(1)
    end
end)



	MainTab:CreateLabel("Welcome to Unfair Hub")	

    MainTab:CreateLabel("Welcome : " .. username)
	


	MainTab:CreateParagraph({
    Title = "Version 0.1 - Updates/Changelog",
    Content = [[
 [*] Script Hub :   
      [*] Optimized Script
	 [*] Adding more features
        ]]
    })


	MainTab:CreateLabel("Current Executor is: " .. Executor)

	




	local Tab = Window:CreateTab("MM2", "gamepad-2")
    local Esp = Tab:CreateSection("ESP")

	local Toggle = Tab:CreateToggle({
   		Name = "ESP All",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			ModeAllRoles = Value
        if Value then
            ModeMurdererOnly = false
            ModeSheriffOnly = false
        else
            ClearESP()
        end
   	end,
	})
	
	local Toggle = Tab:CreateToggle({
   		Name = "ESP Murderer",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			ModeMurdererOnly = Value
        if Value then
            ModeAllRoles = false
            ModeSheriffOnly = false
        else
            ClearESP()
        end
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "ESP Sheriff",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			ModeSheriffOnly = Value
        if Value then
            ModeAllRoles = false
            ModeMurdererOnly = false
        else
            ClearESP()
        end
   	end,
	})
	
	local Toggle = Tab:CreateToggle({
   		Name = "Trap Esp",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			TrapESPEnabled = Value
        if not Value then
            for _, v in pairs(TrapESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Gun Esp",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			GunESPEnabled = Value
        if not Value then
            for _, v in pairs(GunESPFolder:GetChildren()) do
                v:Destroy()
            end
        end
   	end,
	})



    local Chams = Tab:CreateSection("Chams")


	local Toggle = Tab:CreateToggle({
   		Name = "Cham Coins",
   		CurrentValue = false,
   		Flag = "CoinESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			
   	end,
	})

	local Slider = Tab:CreateSlider({
   		Name = "Cham Opacity",
   		Range = {0, 100},
   		Increment = 10,
   		Suffix = "",
   		CurrentValue = 70,
   		Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
})

	local Effect = Tab:CreateSection("Effects")

	local Toggle = Tab:CreateToggle({
   		Name = "See dead Chat",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Role Notify",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			
   	end,
	})




	local RadiosMuted = false

-- Function to mute all radios (sounds in the game)
local function MuteRadios()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") then
            obj.Volume = 0  -- Mute the sound
        end
    end
end

-- Function to unmute all radios
local function UnmuteRadios()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") then
            obj.Volume = 1  -- Restore sound to normal volume
        end
    end
end

	local Toggle = Tab:CreateToggle({
   		Name = "Mute Radios",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			RadiosMuted = Value
        if RadiosMuted then
            MuteRadios()  -- Mute all radios when the toggle is enabled
        else
            UnmuteRadios()  -- Unmute radios when the toggle is disabled
        end
   	end,
	})









	local FPSBoostEnabled = false

-- Function to optimize FPS by disabling certain features
local function OptimizeFPS()
    -- Disable shadows (affects lighting performance)
    game:GetService("Lighting").GlobalShadows = false

    -- Disable certain post-processing effects that can impact FPS
    local lighting = game:GetService("Lighting")
    lighting.BloomEnabled = false
    lighting.AmbientOcclusionEnabled = false
    lighting.VignetteEnabled = false

    -- Reduce texture quality (to a lower setting)
    game:GetService("GraphicsSettings").QualityLevel = Enum.QualityLevel.Low

    -- Disable particle effects (to reduce visual load)
    for _, particle in pairs(workspace:GetDescendants()) do
        if particle:IsA("ParticleEmitter") then
            particle.Enabled = false
        end
    end
end

-- Function to restore normal graphics settings
local function RestoreGraphics()
    -- Enable shadows
    game:GetService("Lighting").GlobalShadows = true

    -- Enable post-processing effects
    local lighting = game:GetService("Lighting")
    lighting.BloomEnabled = true
    lighting.AmbientOcclusionEnabled = true
    lighting.VignetteEnabled = true

    -- Restore original texture quality
    game:GetService("GraphicsSettings").QualityLevel = Enum.QualityLevel.Medium

    -- Re-enable particle effects
    for _, particle in pairs(workspace:GetDescendants()) do
        if particle:IsA("ParticleEmitter") then
            particle.Enabled = true
        end
    end
end

	local Toggle = Tab:CreateToggle({
   		Name = "Better FPS",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			FPSBoostEnabled = Value
        if FPSBoostEnabled then
            OptimizeFPS()  -- Apply optimizations when the toggle is enabled
        else
            RestoreGraphics()  -- Restore original graphics settings when the toggle is disabled
        end
   	end,
	})


	local Player = Tab:CreateSection("Player")




	local invisible = false

-- Makes the player invisible
local function MakeInvisible()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = 1
        elseif part:IsA("Decal") or part:IsA("Accessory") then
            part:Destroy()
        end
    end

    local head = char:FindFirstChild("Head")
    if head and head:FindFirstChild("face") then
        head.face:Destroy()
    end
end

-- Restores visibility after death/reset
local function RestoreVisibility()
    local player = game.Players.LocalPlayer
    player.CharacterAdded:Connect(function(char)
        invisible = false
    end)
end

	local Button = Tab:CreateButton({
   		Name = "Invisible",
   		Callback = function()
			if not invisible then
            invisible = true
            MakeInvisible()
            RestoreVisibility()
            Rayfield:Notify({
                Title = "Invisibility Enabled",
                Content = "You are now invisible until death or reset.",
                Duration = 3
            })
        end
  	end,
	})

	local Tools = Tab:CreateSection("Tools")



	local autoAnnounceRoles = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to detect and announce roles
local function announceRoles()
    while autoAnnounceRoles do
        task.wait(2)

        local murderer, sheriff = nil, nil

        for _, player in pairs(Players:GetPlayers()) do
            if player and player:FindFirstChild("Backpack") then
                if player.Backpack:FindFirstChild("Knife") then
                    murderer = player
                elseif player.Backpack:FindFirstChild("Gun") then
                    sheriff = player
                end
            end
        end

        -- Announce murderer
        if murderer then
            if murderer == LocalPlayer then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Murderer: #######", "All")
            else
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Murderer: " .. murderer.Name, "All")
            end
        end

        -- Announce sheriff
        if sheriff then
            if sheriff == LocalPlayer then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Sheriff: #######", "All")
            else
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Sheriff: " .. sheriff.Name, "All")
            end
        end
    end
end

	local Toggle = Tab:CreateToggle({
   		Name = "Say Roles",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			autoAnnounceRoles = Value
        if Value then
            task.spawn(announceRoles)
        end
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Void Protect",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Mods = Tab:CreateSection("Mods")



	local autoGrabGun = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to grab the dropped gun
local function grabGunLoop()
    while autoGrabGun do
        task.wait(0.5)

        local map = workspace:FindFirstChild("Map")
        if map then
            local gunDrop = map:FindFirstChild("GunDrop")
            if gunDrop and gunDrop:IsA("Tool") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                -- Teleport to the dropped gun
                LocalPlayer.Character.HumanoidRootPart.CFrame = gunDrop.Handle.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
end

	local Toggle = Tab:CreateToggle({
   		Name = "Auto Get Gun",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			autoGrabGun = Value
        if autoGrabGun then
            task.spawn(grabGunLoop)
        end
   	end,
	})





	local UserInputService = game:GetService("UserInputService")


	local Keybind = Tab:CreateKeybind({
   Name = "Grab Gun",
   CurrentKeybind = "G",
   HoldToInteract = false,
   Flag = "GrabGunKeybind",
   Callback = function()
      local gun = Workspace:FindFirstChild("GunDrop")
      if gun and gun:IsA("Tool") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
         LocalPlayer.Character:PivotTo(gun.CFrame + Vector3.new(0, 3, 0))
      else
         Rayfield:Notify({
            Title = "Gun Not Found",
            Content = "No dropped gun was detected.",
            Duration = 3
         })
      end
   end,
})


local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")

local selectedSilentAim = "None"  -- Default Silent Aim
local selectedAimMode = "None"    -- Default Aim Mode
local enabledSilentAim = false    -- To enable/disable Silent Aim
local enabledAimMode = false      -- To enable/disable Aim Mode

-- Silent Aim Function (aims at the player's head or body)
local function silentAim()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
            if onScreen then
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Aim Mode Function (Static vs. Dynamic Aim)
local function dynamicAim()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Hook logic for Silent Aim or Aim Mode
RunService.RenderStepped:Connect(function()
    if enabledSilentAim or enabledAimMode then
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if not tool then return end

        local target = nil

        if enabledSilentAim and selectedSilentAim == "Silent" then
            target = silentAim()
        end

        if enabledAimMode then
            if selectedAimMode == "Static" then
                target = silentAim()  -- Static aim uses head aim
            elseif selectedAimMode == "Dynamic" then
                target = dynamicAim()  -- Dynamic aim adjusts continuously
            end
        end

        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = target.Character.HumanoidRootPart
            -- Adjust aim for knife or gun
            if tool.Name == "Knife" then
                tool.Handle.CFrame = CFrame.lookAt(tool.Handle.Position, hrp.Position)
            elseif tool.Name == "Gun" then
                tool.Handle.CFrame = CFrame.lookAt(tool.Handle.Position, hrp.Position)
            end
        end
    end
end)


Tab:CreateDropdown({
    Name = "Silent Aim",
    Options = {"None", "Silent"},
    CurrentOption = "None",  -- Default option
    Flag = "SilentAimDropdown",
    Callback = function(Option)
        selectedSilentAim = Option
        enabledSilentAim = (Option == "Silent")  -- Enable Silent Aim if selected
    end,
})

-- Aim Mode Dropdown (Static vs Dynamic)
Tab:CreateDropdown({
    Name = "Aim Mode",
    Options = {"None", "Static", "Dynamic"},
    CurrentOption = "None",  -- Default option
    Flag = "AimModeDropdown",
    Callback = function(Option)
        selectedAimMode = Option
        enabledAimMode = (Option ~= "None")  -- Enable Aim Mode if Static or Dynamic is selected
    end,
})




	local Label = Tab:CreateLabel("Checking gun status...")

	 -- Gun Check Loop
	task.spawn(function()
		while true do
			local gunDropped = Workspace:FindFirstChild("GunDrop")
			local sheriffAlive = false
	 
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player:FindFirstChild("Backpack") then
					local hasGun = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")
					if hasGun then
						sheriffAlive = true
						break
					end
				end
			end
	 
			if gunDropped then
				gunLabel:Set("🟢 Gun Dropped")
			else
				if sheriffAlive then
					gunLabel:Set("🔴 Gun not dropped")
				else
					gunLabel:Set("🔴 Gun not dropped (Sheriff may be dead)")
				end
			end
	 
			task.wait(1)
		end
	end)

	local Sheriff = Tab:CreateSection("Sheriff")

	local function getMurderer()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player:FindFirstChild("Character") then
            local role = player:FindFirstChild("MM2_Role")
            if role and role.Value == "Murderer" then
                return player
            end
        end
    end
    return nil
end

local function teleportBehind(target)
    local localChar = game.Players.LocalPlayer.Character
    local targetChar = target.Character
    if localChar and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
        local hrp = localChar:FindFirstChild("HumanoidRootPart")
        hrp.CFrame = targetChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4) -- Teleport behind
    end
end

local function shootGun()
    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool and tool.Name == "Gun" then
        tool:FindFirstChild("Handle"):FireServer()
    end
end



Tab:CreateButton({
   Name = "Auto Shoot Murderer",
   Callback = function()
       local murderer = getMurderer()
       if murderer then
           teleportBehind(murderer)
           task.wait(0.2)
           shootGun()
       else
           Rayfield:Notify({
               Title = "Murderer Not Found",
               Content = "Could not detect murderer!",
               Duration = 3
           })
       end
   end
})




local bankScannerEnabled = false

-- Function to disable the bank scanner for all players
local function disableBankScanner()
    -- Assuming the scanner has a script or functionality that can be disabled
    if bankScanner then
        -- Example: If there's a script that handles the scanner, you can disable it
        local scannerScript = bankScanner:FindFirstChild("ScannerScript")
        if scannerScript then
            scannerScript.Disabled = true
        end
        -- You can also manipulate other properties (e.g., visibility or interactions)
        bankScanner:Destroy()  -- If you want to remove the scanner completely, this destroys the part.
    end
end

-- Function to enable the bank scanner again
local function enableBankScanner()
    -- Example: If you just disable the scanner and want to re-enable it later
    if bankScanner then
        local scannerScript = bankScanner:FindFirstChild("ScannerScript")
        if scannerScript then
            scannerScript.Disabled = false
        end
        -- You can restore any other properties or reset the scanner here
    end
end

-- Create the toggle button for enabling/disabling the bank scanner
Tab:CreateToggle({
    Name = "Disable Bank Scanner",
    CurrentValue = bankScannerEnabled,  -- Set the default value based on whether the scanner is enabled
    Flag = "DisableBankScannerToggle",  -- Unique flag for saving the config
    Callback = function(Value)
        bankScannerEnabled = Value
        if bankScannerEnabled then
            enableBankScanner()  -- Re-enable the scanner if toggle is on
        else
            disableBankScanner()  -- Disable the scanner if toggle is off
        end
    end,
})

	local Murder = Tab:CreateSection("Murderer")



	local function isMurderer()
    local role = LocalPlayer:FindFirstChild("MM2_Role")
    return role and role.Value == "Murderer"
end

local function getKnifeTool()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
end

local function killAll()
    if not isMurderer() then
        Rayfield:Notify({
            Title = "You Are Not the Murderer",
            Content = "This feature only works when you're the Murderer.",
            Duration = 4
        })
        return
    end

    local knife = getKnifeTool()
    if not knife then
        Rayfield:Notify({
            Title = "Knife Not Found",
            Content = "Equip your knife before using Kill All.",
            Duration = 3
        })
        return
    end

    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local enemyHRP = player.Character.HumanoidRootPart
            local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myHRP then
                myHRP.CFrame = enemyHRP.CFrame * CFrame.new(0, 0, 2) -- Teleport close
                task.wait(0.2)
                pcall(function()
                    knife:FindFirstChild("Handle"):FireServer(enemyHRP)
                end)
            end
        end
    end
end

Tab:CreateButton({
   Name = "Kill All (Murderer Only)",
   Callback = function()
       killAll()
   end
})

	
	




	local lagging = false

-- Function to simulate global server lag by creating many parts for everyone
local function createGlobalLag()
    while lagging do
        -- Create a part in the Workspace to add load to the server
        local part = Instance.new("Part")
        part.Size = Vector3.new(100, 100, 100)
        part.Position = Vector3.new(math.random(-500, 500), math.random(0, 50), math.random(-500, 500))
        part.Anchored = true
        part.Parent = Workspace
        wait(0.01)  -- Adjust the frequency to control lag intensity
    end
end

-- Function to clean up lag by removing all the parts
local function stopGlobalLag()
    for _, part in pairs(Workspace:GetChildren()) do
        if part:IsA("Part") then
            part:Destroy()  -- Destroy any part that was created to simulate lag
        end
    end
end


	local Toggle = Tab:CreateToggle({
   		Name = "Make Server Lag",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			lagging = Value
        if lagging then
            createGlobalLag()  -- Start the loop to create parts and simulate lag
        else
            stopGlobalLag()  -- Stop creating parts and clean up the workspace
        end
   	end,
	})



	local Teleport = Tab:CreateSection("Teleport")

	
-- Function to find the lobby location
local function findLobbyPosition()
    local map = workspace:FindFirstChild("Lobby") or workspace:FindFirstChild("Map")
    if map then
        -- Look for a part or spawn named "Lobby" or something similar
        for _, part in pairs(map:GetDescendants()) do
            if part:IsA("BasePart") and part.Name:lower():find("lobby") then
                return part.Position
            end
        end
    end

    -- Fallback: Look for a SpawnLocation
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("SpawnLocation") and v.Name:lower():find("lobby") then
            return v.Position
        end
    end

    return nil
end

-- Function to teleport
local function teleportToLobby()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local lobbyPos = findLobbyPosition()
    if lobbyPos then
        root.CFrame = CFrame.new(lobbyPos + Vector3.new(0, 5, 0)) -- Offset slightly above ground
    else
        Rayfield:Notify({
            Title = "Lobby Not Found",
            Content = "Could not locate the lobby.",
            Duration = 4
        })
    end
end

	local Button = Tab:CreateButton({
   		Name = "Lobby",
   		Callback = function()
			teleportToLobby()
   		end,
	})

	local Button = Tab:CreateButton({
   		Name = "Map",
   		Callback = function()
			
   		end,
	})

	local Button = Tab:CreateButton({
   		Name = "Above Map",
   		Callback = function()
			
   		end,
	})

	local Button = Tab:CreateButton({
   		Name = "Murderer",
   		Callback = function()
			
   		end,
	})

	local Button = Tab:CreateButton({
   		Name = "Sheriff",
   		Callback = function()
			local function teleportToSheriff()
    -- Search for the Sheriff in the player list
    for _, player in pairs(Players:GetPlayers()) do
        -- Check if the player is not the LocalPlayer and has the Sheriff role
        if player ~= LocalPlayer and player.Character and player:FindFirstChild("HumanoidRootPart") then
            -- Assuming the role is stored in a Leaderboard or similar
            local playerRole = player:FindFirstChild("Role") -- Replace with actual role variable in your game

            -- If the player has the Sheriff role, teleport the LocalPlayer to them
            if playerRole and playerRole.Value == roleTag then
                local sheriffPosition = player.Character.HumanoidRootPart.Position
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(sheriffPosition)
                return
            end
        end
    end
    -- If no Sheriff found, notify the user
    print("No Sheriff found in the game.")
end
   		end,
	})

	local Spectate = Tab:CreateSection("Spectate")


	local Input = Tab:CreateInput({
   Name = "Spectate Player",
   CurrentValue = "",
   PlaceholderText = "Username",
   RemoveTextAfterFocusLost = true,
   Flag = "UsernameInput",
   Callback = function(inputText)
        inputText = inputText:lower() -- Make input lowercase
		local playerToSpectate = nil

        -- Find player ignoring case sensitivity
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Name:lower() == inputText then
                playerToSpectate = player
                break
            end
        end

        if playerToSpectate and playerToSpectate.Character and playerToSpectate.Character:FindFirstChild("Humanoid") then
            -- Switch the camera to spectate the player's humanoid
            workspace.CurrentCamera.CameraSubject = playerToSpectate.Character.Humanoid
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

            game.StarterGui:SetCore("SendNotification", {
                Title = "Spectating",
                Text = "Now Spectating: " .. playerToSpectate.Name,
                Duration = 3
            })
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error",
                Text = "Player not found or not spawned yet.",
                Duration = 3
            })
        end
   end,
})

	local Button = Tab:CreateButton({
    Name = "Stop Spectating",
    Flag = "StopSpectatingButton",
    Callback = function()
        -- Reset camera back to LocalPlayer's character when stopped
        local player = game.Players.LocalPlayer
        game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        game.StarterGui:SetCore("SendNotification", {
            Title = "Spectating Stopped",
            Text = "You are no longer spectating.",
            Duration = 3
        })
    end,
})

--Premium









local Bad = Window:CreateTab("Player", "globe")

Bad:CreateToggle({
    Name = "Esp",
    CurrentValue = false,
    Callback = function(Value)
        setESP(value)
    end,
})

Bad:CreateToggle({
    Name = "Tracers",
    CurrentValue = false,
    Callback = function(Value)
    end,
})

Bad:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(Value)
        noclip = Value
        if noclip then
            connection = game:GetService("RunService").Stepped:Connect(function()
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide == true then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
            -- Re-enable collisions when noclip is turned off
            if game.Players.LocalPlayer.Character then
                for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end,
})

Bad:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(Value)
        flying = Value
        if flying then
            startFlying()
        else
            stopFlying()
        end
    end,
})





local flingerEnabled = false

-- Function to fling another player
local function flingPlayer(player)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 500, 0) -- High Y force (upward fling)
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.P = 1e5
        bodyVelocity.Parent = hrp

        task.delay(0.3, function()
            bodyVelocity:Destroy()
        end)
    end
end

-- Touch detection
local function onTouched(hit)
    if not flingerEnabled then return end
    local character = hit:FindFirstAncestorOfClass("Model")
    local player = character and Players:GetPlayerFromCharacter(character)
    if player and player ~= LocalPlayer then
        flingPlayer(player)
    end
end

-- Connect to touch events
local function hookTouch()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.Touched:Connect(onTouched)
    end
end

-- Rehook on character added
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    hookTouch()
end)

-- Initial hook
if LocalPlayer.Character then
    hookTouch()
end

Bad:CreateToggle({
    Name = "Fling",
    CurrentValue = false,
    Callback = function(Value)
        flingerEnabled = Value
    end,
})

Bad:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").Health = 0
        end
    end,
})

Bad:CreateButton({
    Name = "God mode",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").Health = math.huge
        end
    end,
})

local Input = Bad:CreateInput({
    Name = "Set WalkSpeed",
    CurrentValue = "",
    PlaceholderText = "Enter WalkSpeed (e.g. 50)",
    RemoveTextAfterFocusLost = true,
    Flag = "WalkSpeedInput",
    Callback = function(Text)
        local speed = tonumber(Text)
        if speed and game.Players.LocalPlayer.Character then
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
        end
    end,
})

local Input = Bad:CreateInput({
    Name = "Set JumpPower",
    CurrentValue = "",
    PlaceholderText = "Enter JumpPower (e.g. 100)",
    RemoveTextAfterFocusLost = true,
    Flag = "JumpPowerInput",
    Callback = function(Text)
        local power = tonumber(Text)
        if power and game.Players.LocalPlayer.Character then
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = power
            end
        end
    end,
})

local InfiniteJumpEnabled = false

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)


local Toggle = Bad:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end,
})





















	local Misc = Window:CreateTab("Scripts", "code")

	local Label = Misc:CreateLabel("We are working on other games!")

	local Dropdown = Misc:CreateDropdown({
		Name = "Murder Mystery 2",
		Options = {"Copy"},
		CurrentOption = {""},
		MultipleOptions = false,
		Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
		Callback = function(Options)
			setclipboard("142823291")
		end,
	})

	local Premium = Window:CreateTab("Premium", "star")

	local Robux = Premium:CreateLabel("Get more Features with Unfair Hub Premium")
	local Legit = Premium:CreateLabel("Very Cheap and fun, just for 400 Robux!")

	Premium:CreateParagraph({
    	Title = "Features",
    	Content = [[  
   [*] Breaking Game features
      [*] Commands For Alt!
	 [*] More Scripts!
        ]]
    })

	Premium:CreateParagraph({
    	Title = "Steps to get Premium",
		Content = [[
    [1] Join the copied discord link
	[2] go to the support ticket
	[3] create ticket
	[4] wait for dev or admin
	[5] Buy gamepass that linked
	[6] Give Hwid (required)
        ]]
    })

	local FE = Window:CreateTab("FE Scripts", "scroll")

	local Button = FE:CreateButton({
        Name = "Infinity yield (OP)",
        Callback = function()
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "System Broken",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"))()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "FE YEET GUI (Troll Face Edition)",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/zJYDDPS3",true))()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "Eclipse Hub",
        Callback = function()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "Dark Dex",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Keyless-dex-working-new-25658"))()

            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "Quirky Cmd",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Cubbbe/CMD-Thingy/refs/heads/main/Quirky%20CMD",true))()
            
            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

    local Button = FE:CreateButton({
        Name = "Chat Bypasser",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/shadow62x/catbypass/main/upfix"))()
            
            Rayfield:Notify({
               Title = "Script Loaded",
               Content = "fe script loaded sucessfully",
               Duration = 6.5,
               Image = "check",
            })
       end,
    })

	local Leel = FE:CreateSection("Custom Script")


	local inputCode = ""

-- Input Box
FE:CreateInput({
    Name = "Custom Loadstring",
    CurrentValue = "",
    PlaceholderText = 'Paste full loadstring here...',
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(Text)
        inputCode = Text
    end,
})

-- Button to run the loadstring
FE:CreateButton({
    Name = "Execute Loadstring",
    Callback = function()
        if inputCode ~= "" and inputCode:lower():find("loadstring") then
            local success, err = pcall(function()
                loadstring(inputCode)()
            end)
            if not success then
                warn("Error executing script:", err)
            end
        else
            warn("Invalid or empty loadstring.")
        end
    end,
})








	local No = Window:CreateTab("Troll", 2005276185)



	local PlayerList = {}
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(PlayerList, player.Name)
    end
end

-- Dropdown for Player Selection
local Dropdown = No:CreateDropdown({
    Name = "Select Player",
    Options = PlayerList,
    CurrentOption = PlayerList[1],  -- Default to the first player in the list
    MultipleOptions = false,
    Flag = "PlayerDropdown",  -- A unique flag for configuration saving
    Callback = function(Options)
        selectedPlayerName = Options[1]  -- Only one option can be selected, so it's the first in the table
    end,
})

-- Auto update player list
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        table.insert(PlayerList, player.Name)
        Dropdown:Set(PlayerList)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(PlayerList) do
        if name == player.Name then
            table.remove(PlayerList, i)
            break
        end
    end
    Dropdown:Set(PlayerList)
end)

-- Fling logic
local function startFling(target)
    if not target then return end
    local character = target.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local hrp = character.HumanoidRootPart
    flingConnection = game:GetService("RunService").Heartbeat:Connect(function()
        hrp.Velocity = Vector3.new(9999, 9999, 9999)
    end)
end

local function stopFling()
    if flingConnection then
        flingConnection:Disconnect()
        flingConnection = nil
    end
end

-- Fling Button
No:CreateButton({
    Name = "Fling",
    Callback = function()
        local targetPlayer = Players:FindFirstChild(selectedPlayerName)
        if targetPlayer then
            startFling(targetPlayer)
        end
    end,
})

-- Stop Fling Button
No:CreateButton({
    Name = "Stop Fling",
    Callback = function()
        stopFling()
    end,
})

local Sniper = No:CreateSection("Stream Snipe / snipe")

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")


No:CreateInput({
    Name = "Target Username",
    PlaceholderText = "Enter exact username",
    RemoveTextAfterFocusLost = false,
    Flag = "TargetUserInput",
    Callback = function(input)
        TargetUsername = input
    end,
})

-- Join Button
No:CreateButton({
    Name = "Join Player's Server",
    Callback = function()
        if not TargetUsername or TargetUsername == "" then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please enter a username.",
                Duration = 4,
            })
            return
        end

        -- Step 1: Get userId from username
        local success, result = pcall(function()
            return game:HttpGet("https://api.roblox.com/users/get-by-username?username=" .. TargetUsername)
        end)

        if not success then
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to get user info.",
                Duration = 4,
            })
            return
        end

        local data = HttpService:JSONDecode(result)
        if not data.Id then
            Rayfield:Notify({
                Title = "Invalid Username",
                Content = "User not found.",
                Duration = 4,
            })
            return
        end

        local userId = data.Id

        -- Step 2: Check online status
        local success2, presenceRaw = pcall(function()
            return game:HttpGet("https://api.roblox.com/users/" .. userId .. "/onlinestatus/")
        end)

        if not success2 then
            Rayfield:Notify({
                Title = "Error",
                Content = "Could not check online status.",
                Duration = 4,
            })
            return
        end

        local presence = HttpService:JSONDecode(presenceRaw)
        if presence.IsOnline and presence.PlaceId and presence.GameId then
            -- Step 3: Teleport
            TeleportService:TeleportToPlaceInstance(presence.PlaceId, presence.GameId, Players.LocalPlayer)
        else
            Rayfield:Notify({
                Title = "Not In Game",
                Content = "User is not in a public server.",
                Duration = 4,
            })
        end
    end,
})

local May = Window:CreateTab("Tools", "book") --- Lucide Icons on : lucide.de

local urlInput = ""

-- Input for raw script URL
May:CreateInput({
    Name = "Script URL",
    CurrentValue = "",
    PlaceholderText = "Paste raw link here...",
    RemoveTextAfterFocusLost = false,
    Flag = "ScriptURL",
    Callback = function(Text)
        urlInput = Text
    end,
})

-- Button to convert to loadstring and copy to clipboard
May:CreateButton({
    Name = "Make Loadstring",
    Callback = function()
        if urlInput:match("^https?://") then
            local loadstringCode = 'loadstring(game:HttpGet("' .. urlInput .. '"))()'
            setclipboard(loadstringCode)
            print("Copied to clipboard:\n" .. loadstringCode)
        else
            warn("Please enter a valid URL starting with http or https.")
        end
    end,
})

local Obf = May:CreateSection("Obfuscator")

local Label = May:CreateLabel("Comming Soon...", nil)





















	local Set = Window:CreateTab("Settings", "settings")

	local Label = Set:CreateLabel("Everything is OFF so activate ur settings!", nil, Color3.fromRGB(255, 0, 0), false) -- Title, Icon, Color, IgnoreTheme

	local AntiFlingRunning = false
	local AntiFlingConnection

Set:CreateToggle({
    Name = "Anti-Fling",
    CurrentValue = false,
    Flag = "AntiFlingToggle",
    Callback = function(Value)
        if Value and not AntiFlingRunning then
            AntiFlingRunning = true

            local lp = game.Players.LocalPlayer
            local char = lp.Character or lp.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")

            AntiFlingConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if hrp.Velocity.Magnitude > 100 then -- if you're suddenly being flung
                    hrp.Anchored = true
                elseif hrp.Anchored and hrp.Velocity.Magnitude < 5 then
                    hrp.Anchored = false
                end
            end)

        elseif not Value and AntiFlingRunning then
            AntiFlingRunning = false
            if AntiFlingConnection then
                AntiFlingConnection:Disconnect()
            end

            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Anchored = false
            end
        end
    end
})

local AntiVoidEnabled = false
local AntiVoidConnection
local safePosition = nil

Set:CreateToggle({
    Name = "Anti-Void",
    CurrentValue = false,
    Flag = "AntiVoidToggle",
    Callback = function(Value)
        local lp = game.Players.LocalPlayer
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        if Value and not AntiVoidEnabled then
            AntiVoidEnabled = true
            safePosition = hrp.Position

            AntiVoidConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if hrp.Position.Y < -20 then
                    hrp.Velocity = Vector3.zero
                    hrp.CFrame = CFrame.new(safePosition + Vector3.new(0, 5, 0)) -- TP slightly above safe spot
                end
            end)

        elseif not Value and AntiVoidEnabled then
            AntiVoidEnabled = false
            if AntiVoidConnection then
                AntiVoidConnection:Disconnect()
                AntiVoidConnection = nil
            end
        end
    end
})

local Toggle = Set:CreateToggle({
   Name = "Anti AFK",
   CurrentValue = false,
   Flag = "AntiAFKToggle",
   Callback = function(Value)
      AntiAFKEnabled = Value

      if AntiAFKEnabled then
         -- Notify when Anti-AFK is activated
         game.StarterGui:SetCore("SendNotification", {
            Title = "Anti AFK",
            Text = "Anti-AFK Activated! 🕹️",
            Duration = 3
         })
      end
   end,
})

-- Function to keep player active when Anti-AFK is on
task.spawn(function()
   while true do
      if AntiAFKEnabled then
         -- Simulate minor movement or action to prevent AFK kick
         game:GetService("Players").LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 0))
         -- You can also make small chat messages or animations to simulate activity

         -- Wait a short period to avoid heavy resource usage
         task.wait(5) -- Every 5 seconds
      end
      task.wait(1)
   end
end)

Set:CreateToggle({
   Name = "Auto Rejoin (10 minutes)",
   CurrentValue = false,
   Flag = "AutoRejoinToggle",
   Callback = function(Value)
      AutoRejoinEnabled = Value

      if AutoRejoinEnabled then
         -- Show notification when enabled
         game.StarterGui:SetCore("SendNotification", {
            Title = "Auto Rejoin",
            Text = "Auto Rejoin enabled. You will rejoin after 10 minutes.",
            Duration = 5,
         })

         -- Start loop
         AutoRejoinThread = task.spawn(function()
            while AutoRejoinEnabled do
               task.wait(600) -- 10 minutes
               if AutoRejoinEnabled then
                  game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
               end
            end
         end)
      else
         -- Cancel loop if disabled
         if AutoRejoinThread then
            task.cancel(AutoRejoinThread)
            AutoRejoinThread = nil
         end

         -- Show notification when disabled
         game.StarterGui:SetCore("SendNotification", {
            Title = "Auto Rejoin",
            Text = "Auto Rejoin has been disabled.",
            Duration = 5,
         })
      end
   end,
})

Set:CreateButton({
	Name = "Rejoin Server",
	Callback = function()
		local TeleportService = game:GetService("TeleportService")
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer

		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	end
})

Set:CreateButton({
	Name = "Server Hop",
	Callback = function()
		local TeleportService = game:GetService("TeleportService")
		local HttpService = game:GetService("HttpService")
		local Players = game:GetService("Players")

		local function ServerHop()
			local Servers = {}
			local Cursor = ""
			local JobId = game.JobId

			local function FetchServers()
				local URL = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"..(Cursor ~= "" and "&cursor="..Cursor or "")
				local Response = HttpService:JSONDecode(game:HttpGet(URL))
				return Response
			end

			local function TryHop()
				local Data = FetchServers()
				if Data and Data.data then
					for _, server in ipairs(Data.data) do
						if server.playing < server.maxPlayers and server.id ~= JobId then
							TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Players.LocalPlayer)
							return true
						end
					end
				end
				Cursor = Data.nextPageCursor or ""
				return false
			end

			repeat until TryHop() or Cursor == ""
		end

		ServerHop()
	end
})

local Toggle = Set:CreateToggle({
   Name = "Anti Kick",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      getgenv().AntiKick = Value

      -- Roblox Notification
      game.StarterGui:SetCore("SendNotification", {
         Title = "AntiKick System",
         Text = Value and "Anti Kick Activated 🛡️" or "Anti Kick Deactivated ❌",
         Duration = 5
      })
   end,
})

local Toggle = Set:CreateToggle({
   Name = "Anti HWID Ban",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      getgenv().AntiHwidBan = Value

      -- Roblox Notification
      game.StarterGui:SetCore("SendNotification", {
         Title = "AntiBan System",
         Text = Value and "Anti HWID Ban active 🛡️" or "Anti HWID Ban inactive ❌",
         Duration = 5
      })
   end,
})

local Toggle = Set:CreateToggle({
   Name = "Anti IP Ban",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      getgenv().AntiIpBan = Value

      -- Roblox Notification
      game.StarterGui:SetCore("SendNotification", {
         Title = "AntiBan System",
         Text = Value and "Anti Ip Ban active 🛡️" or "Anti ip Ban inactive ❌",
         Duration = 5
      })
   end,
})

local Button = Set:CreateButton({
   Name = "Kill UI",
   Callback = function()
		Rayfield:Destroy()
   end,
})








	local function showNotification(title, text)
    -- Ensure it runs on the local player to show the notification
    local success, errorMsg = pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
			Icon = "rbxassetid://607866915",
            Duration = 10  -- Duration in seconds (adjust as needed)
        })
    end)

    if not success then
        warn("Failed to send notification:", errorMsg)
    end
end

-- Example usage
showNotification("Unfair Hub Loaded", "The Script loaded sucessfully.")




	local function Sound()
        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://9068539820"
        Sound.Volume = 1
        Sound.Parent = game:GetService("SoundService")
        Sound:Play()
        game:GetService("Debris"):AddItem(Sound, 2)
    end

    Sound()

--end
