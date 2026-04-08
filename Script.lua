-- 🔗 โหลดสคริปหลัก (RAW)
loadstring(game:HttpGet("https://raw.githubusercontent.com/xidin861-star/Script-tsb-boots-fps-kjhj/main/Script.lua"))()

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- 🌇 เวลา 17:10
Lighting.ClockTime = 17.17

-- 💇 ลบผมทุกคน
local function removeHair(char)
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("Accessory") then
            local n = v.Name:lower()
            if n:find("hair") or n:find("hat") then
                v:Destroy()
            end
        end
    end
end

for _,plr in pairs(Players:GetPlayers()) do
    if plr.Character then removeHair(plr.Character) end
    plr.CharacterAdded:Connect(function(c)
        task.wait(1)
        removeHair(c)
    end)
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(c)
        task.wait(1)
        removeHair(c)
    end)
end)

-- 💥 ลบเอฟเฟคทั้งหมด
local function removeEffects(obj)
    for _,v in pairs(obj:GetDescendants()) do
        if v:IsA("ParticleEmitter")
        or v:IsA("Trail")
        or v:IsA("Beam")
        or v:IsA("Explosion")
        or v:IsA("Fire")
        or v:IsA("Smoke")
        or v:IsA("Sparkles") then
            v:Destroy()
        end
    end
end

-- 📱 GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FPS_PRO_UI"
gui.ResetOnSpawn = false

-- 🌈 ฟังก์ชั่นสร้างขอบรุ้ง
local function addRainbowStroke(obj)
    local stroke = Instance.new("UIStroke", obj)
    stroke.Thickness = 2
    spawn(function()
        while true do
            for i=0,1,0.01 do
                stroke.Color = Color3.fromHSV(i,1,1)
                task.wait()
            end
        end
    end)
end

-- 📊 FPS Counter (สีรุ้ง)
local fpsLabel = Instance.new("TextLabel", gui)
fpsLabel.Position = UDim2.new(1,-120,0,10)
fpsLabel.Size = UDim2.new(0,110,0,30)
fpsLabel.BackgroundColor3 = Color3.fromRGB(20,20,20)
fpsLabel.TextColor3 = Color3.new(1,1,1)
fpsLabel.Text = "FPS: 0"
fpsLabel.TextScaled = true

addRainbowStroke(fpsLabel)

-- FPS คำนวณจริง
local frames = 0
local last = tick()

RunService.RenderStepped:Connect(function()
    frames += 1
    if tick() - last >= 1 then
        fpsLabel.Text = "FPS: "..frames
        frames = 0
        last = tick()
    end
end)

-- 🔇 ปุ่มปิดเสียง
local soundBtn = Instance.new("TextButton", gui)
soundBtn.Size = UDim2.new(0,140,0,40)
soundBtn.Position = UDim2.new(0,20,0,100)
soundBtn.Text = "SOUND : OFF"
soundBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
soundBtn.TextColor3 = Color3.new(1,1,1)
soundBtn.Active = true
soundBtn.Draggable = true

addRainbowStroke(soundBtn)

local soundOn = false

soundBtn.MouseButton1Click:Connect(function()
    soundOn = not soundOn
    
    if soundOn then
        soundBtn.Text = "SOUND : ON"
        for _,s in pairs(SoundService:GetDescendants()) do
            if s:IsA("Sound") then
                s.Volume = 1
            end
        end
    else
        soundBtn.Text = "SOUND : OFF"
        for _,s in pairs(SoundService:GetDescendants()) do
            if s:IsA("Sound") then
                s.Volume = 0
            end
        end
    end
end)

-- 💥 ปุ่มลบเอฟเฟค
local fxBtn = Instance.new("TextButton", gui)
fxBtn.Size = UDim2.new(0,140,0,40)
fxBtn.Position = UDim2.new(0,20,0,160)
fxBtn.Text = "EFFECT : OFF"
fxBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
fxBtn.TextColor3 = Color3.new(1,1,1)
fxBtn.Active = true
fxBtn.Draggable = true

addRainbowStroke(fxBtn)

local fxOn = false

fxBtn.MouseButton1Click:Connect(function()
    fxOn = not fxOn
    
    if fxOn then
        fxBtn.Text = "EFFECT : ON"
        removeEffects(workspace)
    else
        fxBtn.Text = "EFFECT : OFF"
    end
end)

print("🔥 FPS UI + ลบผม + เวลา + เอฟเฟค + เสียง พร้อม")
