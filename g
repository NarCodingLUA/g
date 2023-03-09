--[[

    i will try explain what everything does so u can read it and understand

]]--

-- Awaiting until game is fully loaded
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Workspace").Players:FindFirstChild(game:GetService("Players").LocalPlayer.Name)

-- Preventing double loading (stopping people from loading the script 2 times breaking functions)
if getgenv().__LOADED then
    return
end
getgenv().__LOADED = true

-- Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local LocalPlayer = Players.LocalPlayer
local UserID = LocalPlayer.UserId
local SetFPS = setfpscap or set_fps_cap
local Locations = {
    "-805.525635, 21.7499943, -286.839417, 0.0203150008, 5.37985869e-08, 0.999793649, 1.02281676e-08, 1, -5.40175193e-08, -0.999793649, 1.13234222e-08, 0.0203150008",
    "-858.259216, 21.5999546, -86.8053741, 0.997427404, -7.91406496e-09, 0.0716836229, 1.16351737e-08, 1, -5.14926022e-08, -0.0716836229, 5.2194185e-08, 0.997427404",
    "-875.610901, 21.5999527, -86.888916, 0.997768283, -2.35477771e-09, -0.0667718723, 1.4572733e-09, 1, -1.34900624e-08, 0.0667718723, 1.33626514e-08, 0.997768283",
    "-937.419067, 21.3749943, -164.808121, 0.0668821707, 1.03854603e-07, 0.997760892, 2.84906481e-08, 1, -1.05997465e-07, -0.997760892, 3.55161944e-08, 0.0668821707",
    "-955.449097, 21.3749943, -165.67778, -0.0206132941, -1.06308235e-07, -0.999787509, 1.81729316e-08, 1, -1.06705514e-07, 0.999787509, -2.03686223e-08, -0.0206132941",
    "-940.674866, 22.005003, -654.267761, -0.00773210265, -1.01665822e-08, -0.999970078, 1.2252328e-08, 1, -1.02616253e-08, 0.999970078, -1.23313058e-08, -0.00773210265",
    "-940.628662, 22.005003, -667.258423, 0.00474762311, -6.66917686e-08, -0.999988735, 2.34421762e-08, 1, -6.65812223e-08, 0.999988735, -2.31258088e-08, 0.00474762311",
    "-856.673035, 22.005003, -663.828552, -0.999457419, 1.5336491e-09, 0.0329378992, 2.07036299e-09, 1, 1.62606124e-08, -0.0329378992, 1.63199818e-08, -0.999457419",
    "-799.142578, 21.8799992, -658.857117, -0.999988735, 2.20798917e-08, -0.00474495068, 2.19398988e-08, 1, 2.95555029e-08, 0.00474495068, 2.94510656e-08, -0.999988735",
    "98.8265839, 21.7549973, -521.099609, -0.998023927, -6.27840135e-09, 0.0628353283, -4.4206061e-09, 1, 2.97051184e-08, -0.0628353283, 2.9368648e-08, -0.998023927",
    "-250.098602, 21.8457966, -405.619781, 0.999968588, 7.94095953e-08, -0.00792608317, -7.9880877e-08, 1, -5.91435239e-08, 0.00792608317, 5.97748127e-08, 0.999968588",
    "-7.58126879, 21.7499943, -101.037659, 0.999642074, 5.74888901e-08, -0.0267521311, -5.87195679e-08, 1, -4.52174085e-08, 0.0267521311, 4.67720973e-08, 0.999642074",
    "517.569092, 47.9999886, -306.42569, -0.999872983, 4.37199041e-08, -0.0159391221, 4.49523405e-08, 1, -7.6963218e-08, 0.0159391221, -7.76699451e-08, -0.999872983",
    "580.416077, 49.0000343, -276.512207, -0.999228477, 1.82456317e-09, 0.0392741412, 2.01809991e-09, 1, 4.8881974e-09, -0.0392741412, 4.96368502e-09, -0.999228477",
    "577.401184, 51.0576668, -466.924469, 0.999621153, -1.58693414e-09, -0.0275245532, -7.53188623e-10, 1, -8.50090984e-08, 0.0275245532, 8.49976232e-08, 0.999621153",
    "600.647217, 51.0576668, -467.194397, 0.998183131, -2.65500617e-08, -0.0602535829, 2.65580518e-08, 1, -6.68222089e-10, 0.0602535829, -9.33209732e-10, 0.998183131",
    "-615.705994, 21.8749924, 273.813416, 0.999968708, -2.98324991e-08, -0.0079086218, 3.03379579e-08, 1, 6.37926263e-08, 0.0079086218, -6.40305657e-08, 0.999968708",
    "-559.927063, 21.8749943, 269.400726, -0.0333441272, -7.48103857e-10, -0.999443948, -1.13968168e-09, 1, -7.10497217e-10, 0.999443948, 1.11535703e-09, -0.0333441272",
    "-450.778259, 21.7499943, -335.376007, -0.988953829, 3.44585587e-08, 0.148223907, 2.5932307e-08, 1, -5.94553455e-08, -0.148223907, -5.49548034e-08, -0.988953829",
    "-477.772461, 23.087595, -271.5448, -0.0204615537, 4.86465268e-08, -0.999790668, 1.06913909e-07, 1, 4.64686316e-08, 0.999790668, -1.05940707e-07, -0.0204615537",
    "-478.63678, 23.0899124, -283.820374, 0.010947641, 2.68430274e-08, -0.999940097, -1.16782326e-08, 1, 2.67167781e-08, 0.999940097, 1.13850467e-08, 0.010947641",
    "-477.656403, 23.0872803, -294.954865, 0.00467211287, -3.63735992e-08, -0.999989092, -7.17903532e-08, 1, -3.67094124e-08, 0.999989092, 7.19610824e-08, 0.00467211287",
    "-620.218628, 23.2457352, -281.753784, 0.999787748, 1.56917608e-08, -0.0206027552, -1.62600227e-08, 1, -2.74143073e-08, 0.0206027552, 2.77434893e-08, 0.999787748",
    "-633.049377, 23.2457352, -288.872162, -0.55687058, 1.23192887e-08, -0.830599248, -5.45900853e-08, 1, 5.14314245e-08, 0.830599248, 7.39831307e-08, -0.55687058",
}

-- Anti AFK
for _, v in pairs(getconnections(LocalPlayer.Idled)) do
    v:Disable()
end

-- Checking if the user is inside of the config
if UserID == getgenv().config.Host or table.find(getgenv().config.ALTs, UserID) then
    -- Just checking if user is a alt or not
    if table.find(getgenv().config.ALTs, UserID) then
        pcall(SetFPS, tonumber(getgenv().config.FPS)) -- Setting alts fps to configs number
        for _, v in pairs(Workspace:GetDescendants()) do -- Disabling the map to save more cpu
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
        RunService:Set3dRenderingEnabled(false) -- Setting 3d rendering to false to save more cpu again
        for _, v in pairs(Workspace.Ignored.Drop:GetChildren()) do -- Disabling cash on alts but not breaking cash counter
            v.Transparency = 1
            for _, v in pairs(v:GetChildren()) do
                if v:IsA("Decal") then
                    v.Transparency = 1
                elseif v:IsA("BillboardGui") then
                    v.Enabled = false
                end
            end
        end
        Workspace.Ignored.Drop.ChildAdded:Connect(function(Cash)
            if Cash then
                for _, v in pairs(Workspace.Ignored.Drop:GetChildren()) do
                    v.Transparency = 1
                    for _, v in pairs(v:GetChildren()) do
                        if v:IsA("Decal") then
                            v.Transparency = 1
                        elseif v:IsA("BillboardGui") then
                            v.Enabled = false
                        end
                    end
                end
            end
        end)
        settings().Rendering.QualityLevel = 1 -- Setting graphics settings to 1 for lower cpu
        UserSettings().GameSettings.MasterVolume = 0 -- Setting volume settings to 0 for no audio
        local CPUSaver = Instance.new("ScreenGui") -- Screen gui to block off that annoying white shit
        local Frame = Instance.new("Frame")
        local TextLabel = Instance.new("TextLabel")
        local TextLabel_2 = Instance.new("TextLabel")
        CPUSaver.Name = "CPUSaver"
        CPUSaver.Parent = game.CoreGui
        CPUSaver.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        Frame.Parent = CPUSaver
        Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        Frame.Position = UDim2.new(-0.358185619, 0, -0.832251132, 0)
        Frame.Size = UDim2.new(0, 3291, 0, 2462)
        TextLabel.Parent = Frame
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.Position = UDim2.new(0.438468546, 0, 0.479691327, 0)
        TextLabel.Size = UDim2.new(0, 404, 0, 50)
        TextLabel.Font = Enum.Font.GothamBlack
        TextLabel.Text = "CPU/MEM Saver"
        TextLabel.TextColor3 = Color3.fromRGB(77, 77, 77)
        TextLabel.TextSize = 42.000
        TextLabel.TextWrapped = true
        TextLabel_2.Parent = Frame
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.BackgroundTransparency = 1.000
        TextLabel_2.Position = UDim2.new(0.438468546, 0, 0.5, 0)
        TextLabel_2.Size = UDim2.new(0, 404, 0, 50)
        TextLabel_2.Font = Enum.Font.GothamBlack
        TextLabel_2.Text = "Welcome, nar"
        TextLabel_2.TextColor3 = Color3.fromRGB(71, 71, 71)
        TextLabel_2.TextSize = 25.000
        TextLabel_2.TextWrapped = true
        local function HJUYPTD_fake_script()
            local script = Instance.new('LocalScript', TextLabel_2)
            script.Parent.Text = "Welcome, " .. LocalPlayer.Name
        end
        coroutine.wrap(HJUYPTD_fake_script)()
    end
    if UserID == getgenv().config.Host then
        local ScreenGui = Instance.new("ScreenGui") -- Cash counter for host
        local CCHolderFrame = Instance.new("Frame")
        local CCText = Instance.new("TextLabel")
        local UICorner = Instance.new("UICorner")
        ScreenGui.Parent = game.CoreGui
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        CCHolderFrame.Name = "CCHolderFrame"
        CCHolderFrame.Parent = ScreenGui
        CCHolderFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        CCHolderFrame.Position = UDim2.new(0.0166840293, 0, 0.0357142836, 0)
        CCHolderFrame.Size = UDim2.new(0, 250, 0, 80)
        CCText.Name = "CCText"
        CCText.Parent = CCHolderFrame
        CCText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        CCText.BackgroundTransparency = 1.000
        CCText.Size = UDim2.new(0, 250, 0, 80)
        CCText.Font = Enum.Font.GothamBlack
        CCText.Text = "$0"
        CCText.TextColor3 = Color3.fromRGB(111, 111, 111)
        CCText.TextSize = 20.000
        UICorner.Parent = CCHolderFrame
        local function NYKOTQ_fake_script()
        local script = Instance.new('LocalScript', CCText)
        local function CommaNumbers(Amount)
            local Formatted = Amount
            while wait() do
                Formatted, K = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
                if (K == 0) then
                    break
                end
            end
            return Formatted
        end
        while task.wait() do
            local Cash = 0
            for _, v in pairs(Workspace.Ignored.Drop:GetChildren()) do
                if v.Name == "MoneyDrop" then
                    local CashAmounts = string.gsub(v.BillboardGui.TextLabel.Text, "%D", "")
                    Cash = Cash + CashAmounts
                end
            end
            script.Parent.Text = "$"..CommaNumbers(Cash)
        end
        end
        coroutine.wrap(NYKOTQ_fake_script)()
        local function UJMPMCF_fake_script()
        local script = Instance.new('LocalScript', CCHolderFrame)
        script.Parent.Active = true
        script.Parent.Draggable = true
        local Mouse = game.Players.LocalPlayer:GetMouse()
        local Toggle = true
        Mouse.KeyDown:Connect(function(Key)
            if Key == "c" and not script.Parent.Visible then
                script.Parent.Visible = false
            elseif Key == "c" and script.Parent.Visible then
                script.Parent.Visible = true
            end
        end)
        end
        coroutine.wrap(UJMPMCF_fake_script)()
    end
end

-- Chat commands
ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Chatted)
    local args = string.split(string.lower(Chatted.Message), " ")
    if game.Players[Chatted.FromSpeaker].UserId == getgenv().config.Host then
        if args[1] == "/start" then -- Creating a command
            getgenv().__FARM = true
            if UserID ~= getgenv().config.Host then -- Checking that the user isnt the host
                task.spawn(function()
                    if not LocalPlayer.Backpack:FindFirstChild("[Bat]") and not LocalPlayer.Character:FindFirstChild("[Bat]") then
                        if tonumber(LocalPlayer.DataFolder.Currency.Value) >= 258 then
                            local Old_POS;
                            Old_POS = LocalPlayer.Character.HumanoidRootPart.CFrame.Position
                            repeat
                                task.wait()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Ignored.Shop["[Bat] - $258"].Head.Position) * CFrame.new(0, 3, 0)
                                fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Bat] - $258"].ClickDetector, 3)
                            until LocalPlayer.Character:FindFirstChild("[Bat]") or LocalPlayer.Backpack:FindFirstChild("[Bat]")
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Old_POS)
                        end
                    end
                end)
                -- TPing to selected location
                task.spawn(function()
                    repeat task.wait() until LocalPlayer.Character:FindFirstChild("[Bat]") or LocalPlayer.Backpack:FindFirstChild("[Bat]")
                    local _Index;
                    _Index = 0;
                    for _, v in pairs(getgenv().config.ALTs) do
                        if v == UserID then
                            _Index = _Index + 1;
                            local POS = string.split(Locations[tonumber(_Index)])
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(POS[1], POS[2], POS[3], POS[4], POS[5], POS[6], POS[7], POS[8], POS[9], POS[10], POS[11], POS[12])
                            LocalPlayer.Humanoid.Anchored = true
                        else
                            _Index = _Index + 1; 
                        end
                    end
                end)
                -- Equiping bat
                task.spawn(function()
                    repeat task.wait() until LocalPlayer.Character:FindFirstChild("[Bat]") or LocalPlayer.Backpack:FindFirstChild("[Bat]")
                    while getgenv().__FARM do
                        task.wait()
                        if LocalPlayer.Backpack:FindFirstChild("[Bat]") then
                            LocalPlayer.Backpack:FindFirstChild("[Bat]").Parent = LocalPlayer.Character
                        end
                    end
                end)
                -- Farming operation
                task.spawn(function()
                    repeat task.wait() until LocalPlayer.Character:FindFirstChild("[Bat]") or LocalPlayer.Backpack:FindFirstChild("[Bat]")
                    while getgenv().__FARM do
                        task.wait()
                        if LocalPlayer.Character:FindFirstChild("[Bat]") then
                            LocalPlayer.Character:FindFirstChild("[Bat]"):Activate()
                        end
                    end
                end)
            end
        elseif args[1] == "/stop" then -- Creating another command
            getgenv().__FARM = false
        elseif args[1] == "/kick" then -- Creating another another command
            if UserID ~= getgenv().config.Host then
                game:Shutdown()
            end
        end
    end
end)
