repeat wait() until game:IsLoaded()

--====================================================================--
--   ██████╗  █████╗ ████████╗ ██████╗                                 --
--   ██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗                                --
--   ██████╔╝███████║   ██║   ██║   ██║                                --
--   ██╔══██╗██╔══██║   ██║   ██║   ██║                                --
--   ██████╔╝██║  ██║   ██║   ╚██████╔╝                                --
--   ╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝                                 --
--                                                                      --
--   Script : BATO Egg Stealer [OPEN SOURCE]                           --
--   Owner  : BATO                                                    --
--   Rights : © 2026 BATO - All Rights Reserved                       --
--   هذا السكربت مفتوح المصدر بدون أي حماية                           --
--====================================================================--

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

--====================================================================--
-- [BATO] إعدادات السكربت                                            --
--====================================================================--

local Settings = {
    EggDistance = 15,        -- مسافة البحث عن البيضة
    Speed = 16,              -- سرعة الجري
    JumpPower = 50,          -- قوة القفز
    AutoCollect = true,      -- جمع تلقائي
    AutoRun = true,          -- جري تلقائي
}

--====================================================================--
-- [BATO] تحسين الشخصية                                              --
--====================================================================--

local function SetupCharacter()
    if Humanoid then
        Humanoid.WalkSpeed = Settings.Speed
        Humanoid.JumpPower = Settings.JumpPower
        Humanoid.AutoRotate = true
    end
end

SetupCharacter()

CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    SetupCharacter()
end)

--====================================================================--
-- [BATO] البحث عن البيضة                                            --
--====================================================================--

local function FindEgg()
    local egg = nil
    local searchRadius = Settings.EggDistance
    
    -- البحث في نطاق
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("egg") then
            local distance = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if distance <= searchRadius then
                egg = v
                break
            end
        end
    end
    
    return egg
end

--====================================================================--
-- [BATO] سرقة البيضة                                               --
--====================================================================--

local function StealEgg(egg)
    if not egg then return end
    
    -- التوجه للبيضة
    local targetPos = egg.Position
    local hrp = Character.HumanoidRootPart
    
    -- التحرك نحو البيضة
    local function MoveToEgg()
        local distance = (targetPos - hrp.Position).Magnitude
        if distance > 3 then
            local direction = (targetPos - hrp.Position).Unit
            hrp.CFrame = CFrame.new(hrp.Position, targetPos)
            Humanoid:MoveTo(targetPos)
            return true
        end
        return false
    end
    
    -- محاولة السرقة
    local attempts = 0
    while attempts < 10 and egg and egg.Parent do
        if not MoveToEgg() then
            -- كسر البلوكة تحت البيضة
            local below = egg:GetPositionBelow(1)
            if below and below:IsA("BasePart") then
                -- محاكاة الكسر
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end
            
            -- محاولة جمع البيضة
            egg.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
            wait(0.2)
            
            -- التحقق من جمعها
            if not egg.Parent or egg.Parent ~= Workspace then
                return true
            end
        end
        attempts = attempts + 1
        wait(0.2)
    end
    
    return false
end

--====================================================================--
-- [BATO] تشغيل السكربت                                              --
--====================================================================--

local function MainLoop()
    while task.wait(0.5) do
        if not Character or not Humanoid or Humanoid.Health <= 0 then
            Character = LocalPlayer.Character
            if Character then
                Humanoid = Character:WaitForChild("Humanoid")
                SetupCharacter()
            end
            continue
        end
        
        local egg = FindEgg()
        if egg then
            print("✅ BATO: تم العثور على البيضة!")
            local success = StealEgg(egg)
            if success then
                print("✅ BATO: تم سرقة البيضة بنجاح!")
                LocalPlayer:Chat("سرقت البيضة 🔥 - BATO")
                -- إيقاف مؤقت بعد السرقة
                wait(5)
            end
        else
            -- بحث عشوائي عن البيضة
            local randomPos = Vector3.new(
                math.random(-50, 50),
                10,
                math.random(-50, 50)
            )
            Humanoid:MoveTo(randomPos)
        end
    end
end

--====================================================================--
-- [BATO] بداية السكربت                                              --
--====================================================================--

print("✅ BATO Hub: جاري تشغيل سكربت سرقة البيضة...")
LocalPlayer:Chat("BATO Hub Activated! 🔥")

-- تشغيل الحلقة الرئيسية
spawn(MainLoop)

--====================================================================--
-- [BATO] أوامر التحكم                                               --
--====================================================================--

-- كتابة في الشات:
-- /steal  - يبدأ سرقة البيضة
-- /speed 16 - يغير السرعة

LocalPlayer.Chatted:Connect(function(msg)
    if msg:lower():find("/steal") then
        local egg = FindEgg()
        if egg then
            StealEgg(egg)
        else
            LocalPlayer:Chat("مافي بيضة بالقرب! 🥚")
        end
    elseif msg:lower():find("/speed") then
        local speed = tonumber(msg:match("%d+"))
        if speed and speed > 0 and speed < 100 then
            Settings.Speed = speed
            if Humanoid then
                Humanoid.WalkSpeed = speed
            end
            LocalPlayer:Chat("السرعة تغيرت لـ " .. speed)
        end
    end
end)
