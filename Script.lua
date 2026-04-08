-- 🔗 โหลดสคริปหลัก (RAW)
loadstring(game:HttpGet("https://raw.githubusercontent.com/xidin861-star/Script-tsb-boots-fps-kjhj/main/Script.lua"))()

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

-- 🌇 เวลา 17:10
Lighting.ClockTime = 17.17

-- 💇 ลบผมทุกคน
local function removeHair(char)
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("Accessory") then
            local n = v.Name:lower()
            if n:find("hair") then
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

removeEffects(workspace)

workspace.DescendantAdded:Connect(function(v)
    task.wait()
    if v:IsA("ParticleEmitter")
    or v:IsA("Trail")
    or v:IsA("Beam")
    or v:IsA("Explosion")
    or v:IsA("Fire")
    or v:IsA("Smoke")
    or v:IsA("Sparkles") then
        v:Destroy()
    end
end)

-- 📊 FPS Counter สีรุ้ง
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local fpsLabel = Instance.new("TextLabel", gui)
fpsLabel.Position = UDim2.new(1,-120,0,10)
fpsLabel.Size = UDim2.new(0,110,0,30)
fpsLabel.BackgroundColor3 = Color3.fromRGB(20,20,20)
fpsLabel.TextColor3 = Color3.new(1,1,1)
fpsLabel.TextScaled = true

-- 🌈 ขอบรุ้ง
local stroke = Instance.new("UIStroke", fpsLabel)
stroke.Thickness = 2

spawn(function()
    while true do
        for i=0,1,0.01 do
            stroke.Color = Color3.fromHSV(i,1,1)
            task.wait()
        end
    end
end)

-- FPS จริง
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

print("🔥 FPS + ลบผม + ลบเอฟเฟค + เวลา 17:10 พร้อม")
