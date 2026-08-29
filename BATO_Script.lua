repeat wait() until game:IsLoaded()

--====================================================================--
--   ██████╗  █████╗ ████████╗ ██████╗                                 --
--   ██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗                                --
--   ██████╔╝███████║   ██║   ██║   ██║                                --
--   ██╔══██╗██╔══██║   ██║   ██║   ██║                                --
--   ██████╔╝██║  ██║   ██║   ╚██████╔╝                                --
--   ╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝                                 --
--                                                                      --
--   Script : BATO Hub [FIXED - Auto Key]                              --
--   Owner  : BATO                                                    --
--   Rights : © 2026 BATO - All Rights Reserved                       --
--   هذا السكربت يمسح المفتاح القديم ويحفظ الجديد تلقائياً            --
--====================================================================--

if LPH_OBFUSCATED == nil then
	LPH_NO_VIRTUALIZE = function(...) return (...) end
	LPH_ENCSTR = function(...) return (...) end
	LRM_SANITIZE = function(...) return ... end
end

local cloneref = cloneref or function(o) return o end
local TweenService = cloneref(game:GetService("TweenService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local Players = cloneref(game:GetService("Players"))
local TextService = cloneref(game:GetService("TextService"))
local HttpService = cloneref(game:GetService("HttpService"))
local Lighting = cloneref(game:GetService("Lighting"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local Workspace = cloneref(game:GetService("Workspace"))

local LocalPlayer = cloneref(Players.LocalPlayer)

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

if identifyexecutor and identifyexecutor() == "Wave" then
	getgenv().gethui = function()
		return game:GetService("CoreGui")
	end
end

--====================================================================--
-- [BATO] نظام المجلدات                                              --
--====================================================================--

local Folder_Configs = {
	Directory = "batohub",
	Assets = "batohub/Assets",
	Configs = "batohub/Configs",
	Datas = "batohub/Datas",
	Images = "batohub/Images",
	Themes = "batohub/Themes"
}

for _, Folder in Folder_Configs do
	if not isfolder(Folder) then
		makefolder(Folder)
	end
end

local GameId = tostring(game.GameId)
local GameConfigFolder = Folder_Configs.Configs .. "/" .. GameId

if not isfolder(GameConfigFolder) then
	makefolder(GameConfigFolder)
end

--====================================================================--
-- [BATO] تصحيح المفتاح - حذف القديم وحفظ الجديد                     --
--====================================================================--

local function FixKey()
	local keyFile = "batohub/savedkey.txt"
	local newKey = "BATO-KEY-2026" -- المفتاح الصحيح
	
	-- حذف المفتاح القديم (الغلط)
	if isfile(keyFile) then
		local oldKey = readfile(keyFile)
		if oldKey and oldKey ~= newKey then
			delfile(keyFile)
			print("✅ BATO Hub: تم حذف المفتاح القديم (" .. oldKey .. ")")
		end
	end
	
	-- حفظ المفتاح الجديد
	if not isfile(keyFile) then
		writefile(keyFile, newKey)
		print("✅ BATO Hub: تم حفظ المفتاح الجديد (" .. newKey .. ")")
	end
end

-- تنفيذ تصحيح المفتاح فوراً
FixKey()

--====================================================================--
-- [BATO] قائمة الألعاب المدعومة                                     --
--====================================================================--

local GameList = {
	["9584852943"] = { id = "61e0f394c005902cda5643069ac59226", keyless = false },
	["7326934954"] = { id = "00e140acb477c5ecde501c1d448df6f9", keyless = true },
	["10148749921"] = { id = "0d120852a6e2eb65c691e5ce2c628429", keyless = false },
	["4658598196"] = { id = "d383a1d5c0a779bbfd0a2b74437923d5", keyless = true },
	["5130394318"] = { id = "3e7a75a970118d0f0cf629369524dc7d", keyless = false },
	["994732206"] = { id = "e2718ddebf562c5c4080dfce26b09398", keyless = false },
	["10200395747"] = { id = "535322ccaa7a6ba59febea91b085c89c", keyless = true },
	["3808223175"] = { id = "4fe2dfc202115670b1813277df916ab2", keyless = false },
	["66654135"] = { id = "1bc67a62ae73efe4babe9f2b6b7e4646", keyless = true },
	["7395930870"] = { id = "d3191d52e71790d40a4d169f5becd325", keyless = true },
	["1511883870"] = { id = "fefdf5088c44beb34ef52ed6b520507c", keyless = false },
	["7219654364"] = { id = "a5182e78f7af6810e08e05cb72542dbf", keyless = true },
	["10475794799"] = { id = "7c9b5f90b8e6b7f89698e773feb9eac2", keyless = true },
	["7613921865"] = { id = "46d43d3868af285218f28453704b620b", keyless = true },
	["10563114921"] = { id = "82f55d768183c258359d9a7c093d5a60", keyless = false },
	["10440833423"] = { id = "19c44f6c67f0e82e45e456bf81646e01", keyless = true },
}

--====================================================================--
-- [BATO] إعدادات المفاتيح الخاصة بك                                  --
--====================================================================--

local Config = {
	File = "batohub/savedkey.txt",
	Discord = "https://discord.gg/batohub",
	Shop = "https://batohub.com",
	BATO_Keys = {
		["BATO-KEY-2026"] = { expire = os.time() + 31536000, note = "VIP Access" },
		-- أضف مفاتيحك هنا
	},
}

--====================================================================--
-- [BATO] نظام التحقق من المفتاح الخاص بك                            --
--====================================================================--

local function ValidateBATOKey(key)
	local cleaned = key:gsub("%s", "")
	
	if Config.BATO_Keys[cleaned] then
		local keyData = Config.BATO_Keys[cleaned]
		if keyData.expire and keyData.expire < os.time() then
			return false, "KEY_EXPIRED"
		end
		return true, keyData
	end
	
	if #cleaned >= 8 then
		return true, { note = "Trial Access", expire = os.time() + 86400 }
	end
	
	return false, "KEY_INVALID"
end

--====================================================================--
-- [BATO] واجهة المستخدم                                             --
--====================================================================--

local function Notify(data)
	StarterGui:SetCore("SendNotification", {
		Title = "BATO Hub",
		Text = data.Description or "Welcome!",
		Icon = "rbxassetid://137698471325689",
		Duration = data.Duration or 5,
	})
end

--====================================================================--
-- [BATO] التحقق من اللعبة والتحميل                                  --
--====================================================================--

local GameConfig = GameList[GameId]

if not GameConfig then
	Notify({
		Description = "This game is not supported by BATO Hub.",
		Duration = 5,
	})
	return
end

local ScriptId = GameConfig.id
local IsKeyless = GameConfig.keyless

local LuarmorApi = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
LuarmorApi.script_id = ScriptId

local LoaderUrl = "https://api.luarmor.net/files/v4/loaders/" .. ScriptId .. ".lua"

--====================================================================--
-- [BATO] نظام المفاتيح الخاص بك                                     --
--====================================================================--

local function LoadScript()
	Notify({
		Description = "Loading script... | BATO Hub © 2026",
		Duration = 3,
	})
	loadstring(game:HttpGet(LoaderUrl))()
end

if IsKeyless then
	LoadScript()
	return
end

--====================================================================--
-- [BATO] واجهة إدخال المفتاح (مع مفتاح تلقائي)                      --
--====================================================================--

do
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = game:GetService("CoreGui")
	ScreenGui.Name = "BATO_Hub"
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	ScreenGui.ResetOnSpawn = false

	local Main = Instance.new("Frame")
	Main.Parent = ScreenGui
	Main.Size = UDim2.new(0, 380, 0, 220)
	Main.Position = UDim2.new(0.5, -190, 0.5, -110)
	Main.BackgroundColor3 = Color3.fromRGB(14, 13, 18)
	Main.BackgroundTransparency = 0
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true

	local Corner = Instance.new("UICorner")
	Corner.Parent = Main
	Corner.CornerRadius = UDim.new(0, 8)

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Parent = Main
	UIStroke.Color = Color3.fromRGB(215, 40, 114)
	UIStroke.Thickness = 1
	UIStroke.Transparency = 0.2

	local Title = Instance.new("TextLabel")
	Title.Parent = Main
	Title.Size = UDim2.new(1, 0, 0, 50)
	Title.Position = UDim2.new(0, 0, 0, 10)
	Title.BackgroundTransparency = 1
	Title.Text = "BATO HUB"
	Title.TextColor3 = Color3.fromRGB(215, 40, 114)
	Title.TextSize = 22
	Title.Font = Enum.Font.GothamBold
	Title.TextScaled = false

	local SubTitle = Instance.new("TextLabel")
	SubTitle.Parent = Main
	SubTitle.Size = UDim2.new(1, 0, 0, 20)
	SubTitle.Position = UDim2.new(0, 0, 0, 38)
	SubTitle.BackgroundTransparency = 1
	SubTitle.Text = "© 2026 BATO - All Rights Reserved"
	SubTitle.TextColor3 = Color3.fromRGB(148, 144, 162)
	SubTitle.TextSize = 12
	SubTitle.Font = Enum.Font.Gotham

	local KeyBox = Instance.new("Frame")
	KeyBox.Parent = Main
	KeyBox.Size = UDim2.new(0, 340, 0, 40)
	KeyBox.Position = UDim2.new(0.5, -170, 0, 70)
	KeyBox.BackgroundColor3 = Color3.fromRGB(32, 30, 40)
	KeyBox.BorderSizePixel = 0

	local KeyCorner = Instance.new("UICorner")
	KeyCorner.Parent = KeyBox
	KeyCorner.CornerRadius = UDim.new(0, 6)

	local KeyInput = Instance.new("TextBox")
	KeyInput.Parent = KeyBox
	KeyInput.Size = UDim2.new(1, -20, 1, 0)
	KeyInput.Position = UDim2.new(0, 10, 0, 0)
	KeyInput.BackgroundTransparency = 1
	KeyInput.Text = ""
	KeyInput.TextColor3 = Color3.fromRGB(242, 240, 248)
	KeyInput.TextSize = 14
	KeyInput.Font = Enum.Font.Gotham
	KeyInput.PlaceholderText = "Enter BATO Key"
	KeyInput.PlaceholderColor3 = Color3.fromRGB(148, 144, 162)
	KeyInput.ClearTextOnFocus = false

	local SubmitBtn = Instance.new("TextButton")
	SubmitBtn.Parent = Main
	SubmitBtn.Size = UDim2.new(0, 340, 0, 40)
	SubmitBtn.Position = UDim2.new(0.5, -170, 0, 125)
	SubmitBtn.BackgroundColor3 = Color3.fromRGB(215, 40, 114)
	SubmitBtn.BorderSizePixel = 0
	SubmitBtn.Text = "Verify Key"
	SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	SubmitBtn.TextSize = 16
	SubmitBtn.Font = Enum.Font.GothamBold

	local SubmitCorner = Instance.new("UICorner")
	SubmitCorner.Parent = SubmitBtn
	SubmitCorner.CornerRadius = UDim.new(0, 6)

	local Status = Instance.new("TextLabel")
	Status.Parent = Main
	Status.Size = UDim2.new(1, 0, 0, 20)
	Status.Position = UDim2.new(0, 0, 0, 180)
	Status.BackgroundTransparency = 1
	Status.Text = "Enter your key to continue"
	Status.TextColor3 = Color3.fromRGB(148, 144, 162)
	Status.TextSize = 12
	Status.Font = Enum.Font.Gotham

	--==================================================================--
	-- [BATO] منطق التحقق                                               --
	--==================================================================--

	local function CheckKey()
		local key = KeyInput.Text
		if key == "" then
			Status.Text = "Please enter a key."
			Status.TextColor3 = Color3.fromRGB(255, 200, 0)
			return
		end

		Status.Text = "Checking key..."
		Status.TextColor3 = Color3.fromRGB(255, 200, 0)
		SubmitBtn.Text = "Checking..."

		task.wait(0.5)

		local valid, data = ValidateBATOKey(key)

		if valid then
			Status.Text = "✔ Key verified! Loading script..."
			Status.TextColor3 = Color3.fromRGB(0, 255, 100)
			SubmitBtn.Text = "✔ Verified"

			task.wait(0.5)

			pcall(writefile, Config.File, key)

			ScreenGui:Destroy()
			LoadScript()
		else
			Status.Text = "✘ Invalid key. Please try again."
			Status.TextColor3 = Color3.fromRGB(255, 50, 50)
			SubmitBtn.Text = "Verify Key"
			KeyInput.Text = ""
		end
	end

	SubmitBtn.MouseButton1Click:Connect(CheckKey)

	KeyInput.FocusLost:Connect(function(enter)
		if enter then
			CheckKey()
		end
	end)

	KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
		if #KeyInput.Text >= 8 then
			SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
		else
			SubmitBtn.BackgroundColor3 = Color3.fromRGB(215, 40, 114)
		end
	end)

	SubmitBtn.MouseEnter:Connect(function()
		SubmitBtn.BackgroundColor3 = Color3.fromRGB(235, 70, 140)
	end)
	SubmitBtn.MouseLeave:Connect(function()
		if #KeyInput.Text >= 8 then
			SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
		else
			SubmitBtn.BackgroundColor3 = Color3.fromRGB(215, 40, 114)
		end
	end)

	--==================================================================--
	-- [BATO] التحقق التلقائي من المفتاح المحفوظ                       --
	--==================================================================--

	task.wait(0.5)
	local savedKey = isfile(Config.File) and readfile(Config.File)
	if savedKey and savedKey ~= "" then
		KeyInput.Text = savedKey
		task.wait(0.3)
		CheckKey()
	end
end
