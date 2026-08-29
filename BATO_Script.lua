repeat wait() until game:IsLoaded()

--====================================================================--
--   ██████╗  █████╗ ████████╗ ██████╗                                 --
--   ██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗                                --
--   ██████╔╝███████║   ██║   ██║   ██║                                --
--   ██╔══██╗██╔══██║   ██║   ██║   ██║                                --
--   ██████╔╝██║  ██║   ██║   ╚██████╔╝                                --
--   ╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝                                 --
--                                                                      --
--   Script : BATO Hub [NO KEY]                                        --
--   Owner  : BATO                                                    --
--   Rights : © 2026 BATO - All Rights Reserved                       --
--   هذا السكربت يعمل بدون أي مفتاح                                     --
--====================================================================--

if LPH_OBFUSCATED == nil then
	LPH_NO_VIRTUALIZE = function(...) return (...) end
	LPH_ENCSTR = function(...) return (...) end
	LRM_SANITIZE = function(...) return ... end
end

local cloneref = cloneref or function(o) return o end
local StarterGui = cloneref(game:GetService("StarterGui"))

local GameId = tostring(game.GameId)

--====================================================================--
-- [BATO] قائمة الألعاب المدعومة                                     --
--====================================================================--

local GameList = {
	["9584852943"] = "61e0f394c005902cda5643069ac59226",
	["7326934954"] = "00e140acb477c5ecde501c1d448df6f9",
	["10148749921"] = "0d120852a6e2eb65c691e5ce2c628429",
	["4658598196"] = "d383a1d5c0a779bbfd0a2b74437923d5",
	["5130394318"] = "3e7a75a970118d0f0cf629369524dc7d",
	["994732206"] = "e2718ddebf562c5c4080dfce26b09398",
	["10200395747"] = "535322ccaa7a6ba59febea91b085c89c",
	["3808223175"] = "4fe2dfc202115670b1813277df916ab2",
	["66654135"] = "1bc67a62ae73efe4babe9f2b6b7e4646",
	["7395930870"] = "d3191d52e71790d40a4d169f5becd325",
	["1511883870"] = "fefdf5088c44beb34ef52ed6b520507c",
	["7219654364"] = "a5182e78f7af6810e08e05cb72542dbf",
	["10475794799"] = "7c9b5f90b8e6b7f89698e773feb9eac2",
	["7613921865"] = "46d43d3868af285218f28453704b620b",
	["10563114921"] = "82f55d768183c258359d9a7c093d5a60",
	["10440833423"] = "19c44f6c67f0e82e45e456bf81646e01",
}

--====================================================================--
-- [BATO] التشغيل المباشر بدون مفتاح                                 --
--====================================================================--

local ScriptId = GameList[GameId]

if not ScriptId then
	StarterGui:SetCore("SendNotification", {
		Title = "BATO Hub",
		Text = "هذه اللعبة غير مدعومة",
		Duration = 5,
	})
	return
end

local LoaderUrl = "https://api.luarmor.net/files/v4/loaders/" .. ScriptId .. ".lua"

-- تحميل وتشغيل السكربت مباشرة
loadstring(game:HttpGet(LoaderUrl))()
