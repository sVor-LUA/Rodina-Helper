-- [ Hey! The script was written by the developer "sVor". Copying is possible only with the indication of the author! ]
-- [ Maybe everything is crooked here, but still - this is my first script in this language. Good luck :) ]

script_name("Rodina Helper")
script_author("sVor")
script_description("None")

require("lib.moonloader")
local dlstatus = require("lib.moonloader").download_status
local memory = require("memory")
local sampev = require("lib.samp.events")
local weap = require('game.weapons')
local encoding = require("lib.encoding")
local imgui = require("imgui")
local inicfg = require("inicfg")
local directIni = "moonloader\\Rodina Helper\\config.ini"
local mainIni = inicfg.load(nil, directIni)

local cfg = inicfg.load({
    config = {
        LastConnectTime = ""
    }
}, "LastConnectTime.ini")

local AccentInputBuffer =  imgui.ImBuffer(256)
local SizeInfoInputBuffer = imgui.ImInt(200)
local SizeNotesInputBuffer = imgui.ImInt(0)
local SizeCompetitorsInputBuffer = imgui.ImInt(0)
local SizeOpenBoxPandoraInputBuffer = imgui.ImInt(1)
local HotKey1InputBuffer = imgui.ImBuffer(256)
local HotKey2InputBuffer =  imgui.ImBuffer(256)
local HotKey3InputBuffer =  imgui.ImBuffer(256)
local HotKey4InputBuffer =  imgui.ImBuffer(256)
local HotKey5InputBuffer =  imgui.ImBuffer(256)
local chatcleaner = imgui.ImBool(false)
local CheckBoxShow = imgui.ImBool(false)
local CheckBoxCopy = imgui.ImBool(false)
local CheckBoxSend = imgui.ImBool(false)
local CheckBoxShow3DText = imgui.ImBool(false)
local CheckBoxNotice = imgui.ImBool(false)
local CheckBoxMarker = imgui.ImBool(false)
local CheckBoxLine = imgui.ImBool(false)
local CheckBoxAdvance = imgui.ImBool(false)
local CheckBoxShow3DTextTime = imgui.ImBool(false)

local arrSelectable = {false, false}
local arrSelectable1 = {false, false}
local arrSelectable2 = {false, false}
local arrSelectable3 = {false, false}
local arrSelectable4 = {false, false}
local arrSelectable5 = {false, false}
local arrSelectable6 = {false, false}
local arrSelectable7 = {false, false}
local arrSelectable8 = {false, false}
local arrSelectable9 = {false, false}
local arrSelectable10 = {false, false}
local arrSelectable11 = {false, false}
local arrSelectable12 = {false, false}
local arrSelectable13 = {false, false}
local arrSelectable14 = {false, false}
local arrSelectable15 = {false, false}

local ClosedButtons = true

local CalcAFK1
local CalcAFK2

local StartMineScript = false

--local theme = import("Rodina Helper/theme.lua")
local fa = require("lib.fAwesome5")
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })

logostarter = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\Rodina Helper\\images\\logo.jpeg")
authorstarter = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\Rodina Helper\\images\\Author.png")
profilestarter = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\Rodina Helper\\images\\profile.jpeg")
groupstarter = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\Rodina Helper\\images\\group.jpeg")

Script1 = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\Rodina Helper\\images\\ScriptMine.jpeg")
Script2 = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\Rodina Helper\\images\\ScriptLock.jpeg")
Script3 = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\Rodina Helper\\images\\ScriptLock.jpeg")
Script4 = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\Rodina Helper\\images\\ScriptLock.jpeg")
Script5 = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\Rodina Helper\\images\\ScriptLock.jpeg")

encoding.default = "CP1251"
u8 = encoding.UTF8

--local InputTextBind1 = imgui.ImBuffer(tostring(u8:encode(mainIni.bindersettings.TextBind1)), 256)
local InputTextNotes = imgui.ImBuffer(tostring(u8:encode(mainIni.notes.notestext)), 256)

--InputTextBind1.v = InputTextBind1:gsub('\\n', '\n')

--local addons = require "ADDONS"
local rkeys = require("lib.rkeys")

imgui.ToggleButton = require('imgui_addons').ToggleButton
imgui.HotKey = require('imgui_addons').HotKey
imgui.Spinner = require('imgui_addons').Spinner
imgui.BufferingBar = require('imgui_addons').BufferingBar

local OpenMenu = 0
local fontsize = nil

-- ���������� ��� �����
local ffi = require("ffi")
ffi.cdef[[
	short GetKeyState(int nVirtKey);
	bool GetKeyboardLayoutNameA(char* pwszKLID);
	int GetLocaleInfoA(int Locale, int LCType, char* lpLCData, int cchData);
]]
local BuffSize = 32
local KeyboardLayoutName = ffi.new("char[?]", BuffSize)
local LocalInfo = ffi.new("char[?]", BuffSize)

-- ����� ����
local window_two_loaded = false
local ChoiceSettings = false

local ToggleButton_CalcChat = imgui.ImBool(false)
local ToggleButton_HelpChat = imgui.ImBool(false)
local ToggleButton_Accent = imgui.ImBool(false)
local ToggleButton_InfoWindow = imgui.ImBool(false)
local ToggleButton_HP = imgui.ImBool(true)
local ToggleButton_Armor = imgui.ImBool(true)
local ToggleButton_FPS = imgui.ImBool(true)
local ToggleButton_Ping = imgui.ImBool(true)
local ToggleButton_City = imgui.ImBool(true)
local ToggleButton_District = imgui.ImBool(true)
local ToggleButton_HPAuto = imgui.ImBool(true)
local ToggleButton_SessionOnline = imgui.ImBool(true)
local ToggleButton_Time = imgui.ImBool(true)
local ToggleButton_Weather = imgui.ImBool(false)
local ToggleButton_ClearChat = imgui.ImBool(false)
local ToggleButton_AD = imgui.ImBool(false)
local ToggleButton_ChatAdministration = imgui.ImBool(false)
local ToggleButton_ChatGOV = imgui.ImBool(false)
local ToggleButton_NEWS = imgui.ImBool(false)
local ToggleButton_Events = imgui.ImBool(false)
local ToggleButton_Exit = imgui.ImBool(false)
local ToggleButton_ServerInfo = imgui.ImBool(false)
local ToggleButton_HotKey = imgui.ImBool(false)
local ToggleButton_OpenBoxPandora = imgui.ImBool(false)
local ToggleButton_TPMP = imgui.ImBool(false)
local ToggleButton_SkinChange = imgui.ImBool(false)
local ToggleButton_SaveSkin = imgui.ImBool(false)
local ToggleButton_SkinChangeAll = imgui.ImBool(false)

local ToggleButton_Bind1 = imgui.ImBool(false)
local ToggleButton_Bind2 = imgui.ImBool(false)
local ToggleButton_Bind3 = imgui.ImBool(false)
local ToggleButton_Bind4 = imgui.ImBool(false)
local ToggleButton_Bind5 = imgui.ImBool(false)
local ToggleButton_Bind6 = imgui.ImBool(false)
local ToggleButton_Bind7 = imgui.ImBool(false)
local ToggleButton_Bind8 = imgui.ImBool(false)
local ToggleButton_Bind9 = imgui.ImBool(false)
local ToggleButton_Bind10 = imgui.ImBool(false)
local ToggleButton_Bind11 = imgui.ImBool(false)
local ToggleButton_Bind12 = imgui.ImBool(false)
local ToggleButton_Bind13 = imgui.ImBool(false)
local ToggleButton_Bind14 = imgui.ImBool(false)
local ToggleButton_Bind15 = imgui.ImBool(false)
local ToggleButton_Bind16 = imgui.ImBool(false)

local main_window_state = imgui.ImBool(false)
local Competitors_Main_Window_State = imgui.ImBool(false)
local biography_window_state = imgui.ImBool(false)
local settings_window_state_one = imgui.ImBool(false)
local settings_window_state_two = imgui.ImBool(false)
local Shadow_Window_State = imgui.ImBool(false)
local InfoWindow = imgui.ImBool(true)
local NotesShowWindow = imgui.ImBool(true)
local calcWindow = imgui.ImBool(false)
local helpChatWindow = imgui.ImBool(false)
local comboAccent = imgui.ImInt(0)
local selectedAccent
local AccentSettings = false
local InfoWindowSettings = false
local WeatherTimeSettings = false
local ClearChatSettings = false
local weather = imgui.ImInt(-1)
local gametime = imgui.ImInt(-1)
local FirstPage = true
local TwoPage = false
local BasicSettings = true
local ScriptMineSettings = false
local ScriptsSettings = false
local MyAnalitics = false
local Notes = false
local HotKeySettings = false
local SkinSettings = false
local ChangeHotKey_1 = false
local ChangeHotKey_2 = false
local ChangeHotKey_3 = false
local ChangeHotKey_4 = false
local ChangeHotKey_5 = false
local ShadowWindow_InfoWindow = false
local ShadowWindow_Distance3DTextMine = false
local ShadowWindow_NotesWindow = false
local ShadowWindow_OpenBoxPandora = false
local ShadowWindow_Succesful = false
local SaveButtonOn = true
local SaveSkinParam
local LastConnectData
local LastConnectTime

local StoneSession = 0
local MetalSession = 0
local SilverSession = 0
local GoldSession = 0

local ipadress
local country

--- ������� �������

local tWeekdays = {
    [0] = '�����������',
    [1] = '�����������', 
    [2] = '�������', 
    [3] = '�����', 
    [4] = '�������', 
    [5] = '�������', 
    [6] = '�������'
}

mainIni = inicfg.load({
    OnDay = {
        today = os.date("%a"),
        online = 0,
        afk = 0,
        full = 0
    },
    onWeek = {
		week = 1,
		online = 0,
		afk = 0,
		full = 0
	},
    myWeekOnline = {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0
    }
}, directIni)

local sessionOnline = imgui.ImInt(0)
local sessionAfk = imgui.ImInt(0)
local sessionFull = imgui.ImInt(0)
local dayFull = imgui.ImInt(mainIni.onDay.full)
local weekFull = imgui.ImInt(mainIni.onWeek.full)
local nowTime = os.date("%H:%M:%S", os.time())

----

local ClearPayDaysHour = tonumber(os.date("%H"))

if mainIni.HotKey == nil then
    mainIni.HotKey = {
        HotKey_1 = "[76]",
        HotKey_2 = "[75]",
        HotKey_3 = "[76]",
        HotKey_4 = "[76]",
        HotKey_5 = "[76]"
    }
end

local tLastKeys = {}
local HotKey_1Menu = {
    v = decodeJson(mainIni.HotKey.HotKey_1)
}
local HotKey_2Menu = {
    v = decodeJson(mainIni.HotKey.HotKey_2)
}
local HotKey_3Menu = {
    v = decodeJson(mainIni.HotKey.HotKey_3)
}
local HotKey_4Menu = {
    v = decodeJson(mainIni.HotKey.HotKey_4)
}
local HotKey_5Menu = {
    v = decodeJson(mainIni.HotKey.HotKey_5)
}

local changePositionInfoWindow = false
local changePositionNotesWindow = false
local changePositionCompetitorsWindow = false

---- �������� ������ � github
--- ENB
local ENBInstalled = false
local enb_url_1 = "https://raw.githubusercontent.com/sVor-LUA/enb/main/enbeffect.fx"
local enb_url_2 = "https://raw.githubusercontent.com/sVor-LUA/enb/main/enblocal.ini"
local enb_url_3 = "https://github.com/sVor-LUA/enb/blob/main/enbseries.asi?raw=true"
local enb_url_4 = "https://raw.githubusercontent.com/sVor-LUA/enb/main/enbseries.ini"

local enb_path = getGameDirectory()
-- ���� ����������
local enb_path_1 = getGameDirectory() .. "/enbeffect.fx"
local enb_path_2 = getGameDirectory() .. "/enblocal.ini"
local enb_path_3 = getGameDirectory() .. "/enbseries.asi"
local enb_path_4 = getGameDirectory() .. "/enbseries.ini"
--
-- �������� �� �������
local enb_search_1 = getGameDirectory() .. "/enbeffect.fx"
local enb_search_2 = getGameDirectory() .. "/enblocal.ini"
local enb_search_3 = getGameDirectory() .. "/enbseries.asi"
local enb_search_4 = getGameDirectory() .. "/enbseries.ini"
--
---
----

--[[local Field = {
    {
        coord = {-789.4875,-474.1677,-75.0960},
    },
    {
        coord = {-783.0633,-467.8243,-74.9246},
    },
    {
        coord = {-773.2971,-453.3427,-73.9133},
    },
    {
        coord = {-773.8759,-475.0224,-75.2806},
    },
    {
        coord = {-760.2528,-481.9744,-75.0337},
    },
    {
        coord = {-747.0631,-475.5784,-74.6232},
    },
    {
        coord = {-770.5701,-494.4019,-76.4250},
    },
    {
        coord = {-771.0042,-503.9158,-76.1499},
    },
    {
        coord = {-765.1661,-510.1401,-75.4690},
    },
    {
        coord = {-778.3384,-517.8847,-75.9932},
    },
    {
        coord = {-785.2090,-525.3731,-75.9344},
    },
    {
        coord = {-804.8004,-521.7570,-75.7018},
    },
    {
        coord = {-817.6358,-513.6983,-76.1133},
    },
    {
        coord = {-819.1453,-502.8906,-75.9896},
    },
    {
        coord = {-810.2122,-496.9263,-76.2229},
    },
    {
        coord = {-799.7134,-492.3407,-76.2681},
    },
    {
        coord = {-784.7955,-494.7633,-76.2790},
    },
    {
        coord = {-791.2842,-504.3061,-76.2613},
    },
    {
        coord = {-794.9775,-517.1484,-76.0863},
    },
    {
        coord = {-825.8196,-537.6431,-69.9099},
    },
    {
        coord = {-815.5457,-530.4734,-66.4338},
    },
    {
        coord = {-800.6880,-541.9293,-72.1267},
    },
    {
        coord = {-774.3265,-543.7347,-69.3655},
    },
    {
        coord = {-751.4374,-511.1516,-69.4331},
    },
    {
        coord = {-817.3894,-444.7614,-68.8440},
    },
    {
        coord = {-846.8516,-462.5489,-72.5880},
    },
    {
        coord = {-858.6082,-527.3241,-53.9115},
    },
    {
        coord = {-801.5215,-504.7993,-76.2668},
    },
}]]

local checkpoint
local marker

--- ��������������
local update_state = false

local script_vers = 1
local script_vers_text = "0.0.1"

local update_url = "https://raw.githubusercontent.com/sVor-LUA/Rodina-Helper/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://github.com/sVor-LUA/Rodina-Helper/blob/main/Rodina_Helper.luac?raw=true"
local script_path = thisScript().path
---

local theme = import("Rodina Helper/theme.lua")
----------------------------

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end

        if not isValidServer() then
            sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������� ������� ��� � ������ ���������! ������ �������� ���� ������.", -1)
            wait(3000)
            os.exit(0)
        end

        if mainIni.onDay.today ~= os.date("%a") then 
            mainIni.onDay.today = os.date("%a")
            mainIni.onDay.online = 0
            mainIni.onDay.full = 0
            mainIni.onDay.afk = 0
            dayFull.v = 0
            inicfg.save(mainIni, directIni)
       end

        if mainIni.onWeek.week ~= number_week() then
            mainIni.onWeek.week = number_week()
            mainIni.onWeek.online = 0
            mainIni.onWeek.full = 0
            mainIni.onWeek.afk = 0
            weekFull.v = 0
            for _, v in pairs(mainIni.myWeekOnline) do v = 0 end            
            inicfg.save(mainIni, directIni)
        end

        LastConnectData = os.date("%d.%m.%Y ����")

        lua_thread.create(roulette)

        HotKey_1Register = rkeys.registerHotKey(HotKey_1Menu.v, true, HotKey_1Func)
        HotKey_2Register = rkeys.registerHotKey(HotKey_2Menu.v, true, HotKey_2Func)
        HotKey_3Register = rkeys.registerHotKey(HotKey_3Menu.v, true, HotKey_3Func)
        HotKey_4Register = rkeys.registerHotKey(HotKey_4Menu.v, true, HotKey_4Func)
        HotKey_5Register = rkeys.registerHotKey(HotKey_5Menu.v, true, HotKey_5Func)

        sampRegisterChatCommand("rh", cmd_rh)
        sampRegisterChatCommand("getinfo", cmd_getinfo)
        sampRegisterChatCommand("setmyskin", cmd_setmyskin)
        sampRegisterChatCommand("setskinall", cmd_setskinall)
        sampRegisterChatCommand("search", cmd_search)
        --sampRegisterChatCommand("ruda", cmd_ruda)
        --sampRegisterChatCommand("deltext", cmd_deltext)
        getfps()
        getip(1)

        for i = 0, 500 do
            sampDestroy3dText(i)
        end

        imgui.SwitchContext()
        theme.SwitchColorTheme(2)

        local _, pID = sampGetPlayerIdByCharHandle(PLAYER_PED)

        PlayerName = sampGetPlayerNickname(pID)
        local hour = tonumber(os.date("%H"))
        local hellotime
        if hour >= 5 and hour <= 10 then hellotime = "������ ����" end
        if hour >= 11 and hour <= 16 then hellotime = "������ ����" end
        if hour >= 17 and hour <= 22 then hellotime = "������ �����" end
        if hour >= 23 or hour <= 4 then hellotime = "������ ����" end
        sampAddChatMessage("{FFFFFF}-------------------------------------------------------------------------------------------", -1)
        string = string.format("{FF0000}[Rodina Helper]{FFFFFF}: %s, %s! ��� ������������ �������� ������ ��!", hellotime, PlayerName)
        sampAddChatMessage(string, 0xFFFFFFFF)
        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������ ������� ������� � ����� � ������! {C0C0C0}( ��������� ���� - /rh )", -1)
        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ����������� - sVor. ��������� �������������!", -1)
        sampAddChatMessage("{FFFFFF}-------------------------------------------------------------------------------------------", -1)

        sampAddChatMessage("{ff0000}[Rodina Helper]{ffffff}: ��������� ������� ����������..", -1)

        downloadUrlToFile(update_url, update_path, function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                updateIni = inicfg.load(nil,update_path)
                if tonumber(updateIni.info.vers) > script_vers then
                    sampAddChatMessage("{ff0000}[Rodina Helper]{ffffff}: �������� ����� ������ ({ff0000}".. updateIni.info.vers_text .."{ffffff})! ������� ������: {ff0000}"..script_vers_text"{ffffff}.", -1)
                    update_state = true
                else
                    sampAddChatMessage("{ff0000}[Rodina Helper]{ffffff}: � ��� ����������� �������� ������ ������� ({ff0000}".. script_vers_text .."{ffffff})!", -1)
                end
                os.remove(update_path)
            end
        end)

        imgui.Process = true

        lua_thread.create(time)
        lua_thread.create(autoSave)

    while true do
        wait(0)
        LoadIni()

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("{ff0000}[Rodina Helper]{ffffff}: ������ ��� ������� �������! ������� ������: {ff0000}".. script_vers_text .."{ffffff}.", -1)
                    thisScript():reload()
                end
            end)
            break
        end

        if main_window_state.v or biography_window_state.v or settings_window_state_one.v or settings_window_state_two.v or helpChatWindow.v or calcWindow.v then -- ���� � ��������
            imgui.ShowCursor = true
        else
            imgui.ShowCursor = false
        end

        if gametime.v ~= -1 then writeMemory(0xB70153, 1, gametime.v, true) end
        if weather.v ~= -1 then writeMemory(0xC81320, 1, weather.v, true) end

        --local _, pID = sampGetPlayerIdByCharHandle(PLAYER_PED)

        if ToggleButton_CalcChat.v then
            local text = sampGetChatInputText()

            if text:find('%d+') and text:find('[-+/*^%%]') and not text:find('%a+') and text ~= nil then
                imgui.Process = true
                calcWindow.v = true
                ok, number = pcall(load('return '..text))
                result = '�����: '..number
            end
    
            if text == '' then
                ok = false
                calcWindow.v = ok
            end
        end

        if not settings_window_state_two.v then
            ChangeHotKey_1 = false
            ChangeHotKey_2 = false
            ChangeHotKey_3 = false
            ChangeHotKey_4 = false
            ChangeHotKey_5 = false
        end

        if ToggleButton_HelpChat.v then
            helpChatWindow.v = true
            FontName = "Segoe UI"
            FontSize = 11
            FontFlag = 13
            font = renderCreateFont(FontName, FontSize, FontFlag)
            if sampIsChatInputActive() then
                imgui.Process = true
            end

            text = sampGetChatInputText()
            if settings_window_state_one.v or calcWindow.v or text:find('/') then
                helpChatWindow.v = false
            end
        else
            helpChatWindow.v = false
        end

        if ToggleButton_Accent.v then
            UseAccent = true
        else
            UseAccent = false
        end

        if not settings_window_state_two.v then
            ChoiceSettings = false
        end

        if not ToggleButton_InfoWindow.v then
            InfoWindow.v = false
        else
            InfoWindow.v = true
        end

        if changePositionInfoWindow then
            InfoWindow.v = true
            showCursor(true, true)
            infoWindowX, infoWindowY = getCursorPos()
            mainIni.infowindow.PositionX = infoWindowX
            mainIni.infowindow.PositionY = infoWindowY
            if isKeyJustPressed(VK_RETURN) then
                infoWindowX = math.floor(infoWindowX)
                infoWindowY = math.floor(infoWindowY)
                inicfg.save(mainIni, directIni)
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������������ ��������������� ���� ������� ���������!", -1)
                imgui.Process = true
                settings_window_state_one.v = true
                settings_window_state_two.v = true
                InfoWindow.v = true
                changePositionInfoWindow = false
            end
        end

        if changePositionNotesWindow then
            showCursor(true, true)
            notesWindowX, notesWindowY = getCursorPos()
            mainIni.notes.notesPosX = notesWindowX
            mainIni.notes.notesPosY = notesWindowY
            if isKeyJustPressed(VK_RETURN) then
                notesWindowX = math.floor(notesWindowX)
                notesWindowY = math.floor(notesWindowY)
                inicfg.save(mainIni, directIni)
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������������ ���� � ��������� ������� ���������!", -1)
                imgui.Process = true
                settings_window_state_one.v = true
                settings_window_state_two.v = true
                changePositionNotesWindow = false
            end
        end

        if changePositionCompetitorsWindow then
            showCursor(true, true)
            CompetitorsWindowX, CompetitorsWindowY = getCursorPos()
            mainIni.minesettings.CompetitorsPosX = CompetitorsWindowX
            mainIni.minesettings.CompetitorsPosY = CompetitorsWindowY
            if isKeyJustPressed(VK_RETURN) then
                CompetitorsWindowX = math.floor(CompetitorsWindowX)
                CompetitorsWindowY = math.floor(CompetitorsWindowY)
                inicfg.save(mainIni, directIni)
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������������ ���� ������� ���������!", -1)
                imgui.Process = true
                settings_window_state_one.v = true
                settings_window_state_two.v = true
                changePositionCompetitorsWindow = false
            end
        end

        if isKeyJustPressed(0x73) then
            Restart()
            deleteCheckpoint(marker)
            removeBlip(checkpoint)
        end

        if not sampIsDialogActive() then
            DialogOpen = false
        else
            DialogOpen = true
        end

        if mainIni.PayDays.PayDaysData ~= nil then
            if mainIni.PayDays.PayDaysData ~= os.date('%x',os.time()) then
                mainIni.PayDays.PayDaysData = os.date('%x',os.time())
                mainIni.PayDays.SuccessPayDays = 0
                mainIni.PayDays.FailedPayDays = 0
                inicfg.save(mainIni, directIni)
            end
        else
            mainIni.PayDays.PayDaysData = os.date('%x',os.time())
            inicfg.save(mainIni, directIni)
        end

        if not CheckBoxShow.v then
            NotesShowWindow.v = false
        else
            NotesShowWindow.v = true
        end

        if mainIni.minesettings.MineData ~= nil then
            if mainIni.minesettings.MineData ~= os.date('%x',os.time()) then
                mainIni.minesettings.MineData = os.date('%x',os.time())
                mainIni.minesettings.StoneDay = 0
                mainIni.minesettings.MetalDay = 0
                mainIni.minesettings.SilverDay = 0
                mainIni.minesettings.GoldDay = 0
                inicfg.save(mainIni, directIni)
            end
        else
            mainIni.minesettings.MineData = os.date('%x',os.time())
            inicfg.save(mainIni, directIni)
        end

        if not isCharInArea2d(PLAYER_PED, -679.3196, -612.3732, -911.9957, -397.4157, false) then
            StartMineScript = false
            Competitors_Main_Window_State.v = false
        end

        if CheckBoxAdvance.v and StartMineScript then
            Competitors_Main_Window_State.v = true
        end
    end
end

-------------------------------------------------------- ������� --------------------------------------------------------
--[[function cmd_ruda(arg)
    --local _, pID = sampGetPlayerIdByCharHandle(PLAYER_PED)
    --local result, ped = sampGetCharHandleBySampPlayerId(pID)
    local X, Y, Z = getCharCoordinates(PLAYER_PED)
    id3dtext = sampCreate3dText("������ #"..arg, 0xFFFF0000, X, Y, Z, 20.0, true, -1, -1)
    sampAddChatMessage("3� ����� #"..arg.." ������! ID: "..id3dtext, -1)
end]]

--[[function cmd_deltext(arg)
    sampDestroy3dText(arg)
    sampAddChatMessage("3� ����� #"..arg.." �����!", -1)
end]]

--[[
������������� �8 -770.86840820313, -503.8102722168, -76.973587036133
������������� �6 -746.60015869141, -475.27471923828, -75.383903503418
������������� �20 -825.69116210938, -537.87036132813, -70.639915466309
������������� �24 -751.25091552734, -511.12908935547, -70.244316101074
������������� �17 -784.56195068359, -494.86532592773, -77.099189758301
������������� �25 -817.5712890625, -444.79592895508, -69.854766845703
������������� �16 -799.75384521484, -492.43728637695, -77.088050842285
#7 -770.92211914063, -494.55117797852, -77.249656677246
#1 -789.71997070313, -474.15475463867, -75.960960388184
#9 -765.11456298828, -509.98376464844, -76.259269714355
#5 -760.13922119141, -482.11743164063, -75.827163696289
#11 -785.21295166016, -525.48364257813, -76.74055480957
#3 -773.15869140625, -453.16439819336, -74.725547790527
#18 -791.36975097656, -504.45809936523, -77.104125976563
#21 -815.05676269531, -530.40093994141, -67.079536437988
#14 -818.67932128906, -503.12701416016, -76.798812866211
#12 -805.10235595703, -522.18481445313, -76.509552001953
#23 -774.16882324219, -543.85192871094, -70.843231201172
#13 -817.66571044922, -513.65270996094, -76.913093566895
#2 -782.87414550781, -467.52841186523, -75.738952636719
#10 -778.27117919922, -517.89770507813, -76.839736938477
#4 -773.55389404297, -474.81018066406, -76.094009399414
#15 -810.42504882813, -496.8430480957, -77.023551940918
#19 -794.85504150391, -517.11480712891, -76.919937133789
#22 -800.54931640625, -542.06457519531, -72.860763549805
#26 -846.90063476563, -462.55258178711, -73.36597442627
#27 -858.91076660156, -527.14190673828, -54.823673248291
#28 -801.57800292969, -504.98147583008, -77.086730957031
]]

function cmd_search(arg)
    if #arg == 0 then
        sampAddChatMessage("������, �� �� ������ ���������!", -1)
    else
        sampAddChatMessage("--------------------------------------------------", -1)
        for key, objectHandle in pairs(getAllObjects()) do
            local minDist = tonumber(arg)
            local mX, mY, mZ = getCharCoordinates(playerPed)
            local retId = -1
            idobj = getObjectModel(objectHandle)
            local _, posX, posY, posZ = getObjectCoordinates(objectHandle)
            local dist = getDistanceBetweenCoords3d(mX, mY, mZ, posX, posY, posZ)
            print(dist)
            if dist < minDist then
                minDist = dist
                retId = getObjectModel(objectHandle)
                if retId == 854 then
                    local _, posXX, posYY, posZZ = getObjectCoordinates(objectHandle)
                    sampAddChatMessage("������: "..retId.." ID (������). ����������: "..dist, -1)
                    sampAddChatMessage("���������� �����������!", -1)
                    setClipboardText(posXX..", "..posYY..", "..posZZ)
                end
            end
        end
    end
end

function cmd_getinfo(arg)
    _, pID = sampGetPlayerIdByCharHandle(PLAYER_PED)
    health = sampGetPlayerHealth(pID)
    ping = sampGetPlayerPing(pID)
    name = sampGetPlayerNickname(pID)
    armor = sampGetPlayerArmor(pID)
    ip, port = sampGetCurrentServerAddress()
    sampAddChatMessage("��: " .. health .. ". ����: " .. ping .. ". ���: " .. name .. ". �����: " .. armor .. ". IP: " .. ip .. ":" .. port, -1)
end

function cmd_setmyskin(arg)
    if ToggleButton_SkinChange.v then
        if #arg == 0 then 
            sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������� ID �����!", -1)
        else
            if tonumber(arg) < 0 or tonumber(arg) > 320 then
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ID �����! ��������� �������� - ( {C0C0C0}�� 0 �� 320{FFFFFF} )", -1)
            else
                changeSkin(-1, arg)
                SaveSkinParam = tonumber(arg)
                if ToggleButton_SaveSkin.v then
                    mainIni.skin.SaveSkin = SaveSkinParam
                    inicfg.save(mainIni, directIni)
                else
                    mainIni.skin.SaveSkin = nil
                    inicfg.save(mainIni, directIni)
                end
            end
        end
    else
        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������� ��������� ����������� ����� ���������.", -1)
    end
end

function cmd_setskinall(param)
    local id, arg = string.match(param, "(%d+)%s(%d+)")
    if ToggleButton_SkinChangeAll.v then
        if arg == nil then
            sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������: /setskinall [ID �����] [������]", -1)
        else
            if tonumber(id) < 0 or tonumber(id) > 320 then
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ID �����! ��������� �������� - ( {C0C0C0}�� 0 �� 320{FFFFFF} )", -1)
            elseif tonumber(arg) < 0 or tonumber(arg) > 150 then
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ������! ��������� �������� - ( {C0C0C0}�� 0 �� 150�{FFFFFF} )", -1)
            else
                local x, y, z = getCharCoordinates(PLAYER_PED)
                local _, ped = findAllRandomCharsInSphere(x, y, z, arg, true, true)
                if _ then
                    local _, pid = sampGetPlayerIdByCharHandle(ped)
                    if _ then
                        changeSkin(pid, id)
                        Kolichestvo = 
                        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �� ������ ���� - " .. id .. " � ������� - " .. arg .. "� !", -1)
                    end
                end
            end
        end
    else
        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������� ������ ����� � ������� ���������.", -1)
    end
end

function cmd_rh(arg)
    if #arg == 0 then
        if OpenMenu ~= 1 then
            --sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ���� ������� �������! ��� �������� ������� 'X' � ������ ������� ���� ����.", -1)
            OpenMenu = 1
            main_window_state.v = true
            imgui.Process = true
        else
            sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������! �������� ����.", -1)
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------
function imgui.OnDrawFrame()
    --imgui.ShowCursor = main_window_state.v or biography_window_state.v or settings_window_state_one.v or settings_window_state_two.v or helpChatWindow.v or calcWindow.v

    if not main_window_state.v and not biography_window_state.v and not settings_window_state_one.v and not settings_window_state_two.v then
        imgui.Process = false
        OpenMenu = 0
    end

    if not main_window_state.v and not biography_window_state.v and not settings_window_state_one.v and not settings_window_state_two.v and InfoWindow.v then
        imgui.Process = true
    end

    if NotesShowWindow.v then
        NotesWindowFunction()
    end

    if Competitors_Main_Window_State.v then
        CompetitorsWindowX = mainIni.minesettings.CompetitorsPosX
        CompetitorsWindowY = mainIni.minesettings.CompetitorsPosY

        imgui.SetNextWindowPos(imgui.ImVec2(CompetitorsWindowX, CompetitorsWindowY), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 61), imgui.Cond.Always)

        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.6))
            imgui.Begin('CompetitorsWindow', Competitors_Main_Window_State, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + --[[imgui.WindowFlags.NoMove + ]]imgui.WindowFlags.NoScrollbar)
                local countPlayers = sampGetPlayerCount(true)
                local countPlayersAll = sampGetPlayerCount(false)
                imgui.CenterTextColoredRGB("{FFFFFF}�����")
                imgui.CenterTextColoredRGB("{FFFFFF}���������� ������������: {FFA500}".. countPlayers ..".")
                local procentWithServer = countPlayers / countPlayersAll * 100
                local itog = math.round(procentWithServer, 2)
                imgui.CenterTextColoredRGB("{FFFFFF}({FFA500}".. tonumber(itog) .."%{ffffff} �� ����� �������)")
            imgui.End()
        imgui.PopStyleColor()
    end

    if InfoWindow.v then
        _, pID = sampGetPlayerIdByCharHandle(PLAYER_PED)
        infoWindowX = mainIni.infowindow.PositionX
        infoWindowY = mainIni.infowindow.PositionY
        SizeYInfo = mainIni.infowindow.SizeY

        imgui.SetNextWindowPos(imgui.ImVec2(infoWindowX, infoWindowY), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, SizeYInfo), imgui.Cond.Always)

        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.6))
            imgui.Begin('InfoWindow', InfoWindow, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + --[[imgui.WindowFlags.NoMove + ]]imgui.WindowFlags.NoScrollbar)

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 140))
            imgui.TextColoredRGB("{FFFFFF}����������")
            
            health = sampGetPlayerHealth(pID)
            armor = sampGetPlayerArmor(pID)
            ping = sampGetPlayerPing(pID)
            local zX, zY, zZ = getCharCoordinates(playerPed)
            local cX, cY, cZ = getCharCoordinates(PLAYER_PED)
            City = calcCity(cX, cY)
            District = calcDistrict(zX, zY)

            imgui.SetCursorPosY((imgui.GetWindowWidth() - 170))
            if ToggleButton_HP.v then
                if health >= 70 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� ����������: {00FF00}" .. health .. "%")
                elseif health >= 20 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� ����������: {ffa203}" .. health .. "%")
                elseif health < 20 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� ����������: {FF0000}" .. health .. "%")
                end
            end

            if isCharInAnyCar(PLAYER_PED) and ToggleButton_HPAuto.v then 
                car = storeCarCharIsInNoSave(playerPed)
                carhp = getCarHealth(car)
                if carhp <= 1000 and carhp > 508 then
                    carhpconvert = (carhp-508)/492*100
                elseif carhp <= 508 and carhp >= 0 then
                    carhpconvert = 0
                end

                carhpConvertRound = math.round(carhpconvert, 1)

                if carhpconvert >= 70 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� ����: {00FF00}" .. carhpConvertRound .. "%")
                elseif carhpconvert >= 30 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� ����: {ffa203}" .. carhpConvertRound .. "%")
                elseif carhpconvert < 30 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� ����: {FF0000}" .. carhpConvertRound .. "%")
                end

                --[[carhpconvert1 = carhp - 492
                carhpconvert2 = carhpconvert1 / 10
                if carhpconvert2 < 0 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� ����: {FF0000}0%")
                else
                    if carhpconvert2 >= 30 then
                        imgui.TextColoredRGB("{FFFFFF}� ��������� ����: {00ff00}" .. carhpconvert2 .. "%")
                    elseif carhpconvert2 >= 10 then
                        imgui.TextColoredRGB("{FFFFFF}� ��������� ����: {ffa203}" .. carhpconvert2 .. "%")
                    elseif carhpconvert2 < 9 then
                        imgui.TextColoredRGB("{FFFFFF}� ��������� ����: {FF0000}" .. carhpconvert2 .. "%")
                    end
                end]]
            end

            if ToggleButton_Armor.v then
                if armor == 0 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� �����: {FF0000}- ��� -")
                elseif armor >= 70 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� �����: {00FF00}" .. armor .. "%")
                elseif armor >= 20 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� �����: {ffa203}" .. armor .. "%")
                elseif armor < 20 then
                    imgui.TextColoredRGB("{FFFFFF}� ��������� �����: {FF0000}" .. armor .. "%")
                end
            end

            if ToggleButton_FPS.v then
                imgui.TextColoredRGB("{FFFFFF}� FPS: " .. tostring(fps))
            end

            if ToggleButton_Ping.v then
                if ping < 90 then
                    imgui.TextColoredRGB("{FFFFFF}� Ping: {00FF00}" .. ping)
                elseif ping >= 90 and ping < 150 then
                    imgui.TextColoredRGB("{FFFFFF}� Ping: {ffa203}" .. ping)
                elseif ping >= 150 then
                    imgui.TextColoredRGB("{FFFFFF}� Ping: {FF0000}" .. ping)
                end
            end

            if ToggleButton_City.v then
                if City:find('����������') or City:find('��������') then
                    imgui.TextColoredRGB("{FFFFFF}� ����: " .. City)
                elseif City:find('����������') or City:find('�������') or City:find('������') then
                    imgui.TextColoredRGB("{FFFFFF}� ������: " .. City)
                else
                    imgui.TextColoredRGB("{FFFFFF}� �����: " .. City)
                end
            end

            if ToggleButton_District.v then
                imgui.TextColoredRGB("{FFFFFF}� �����: " .. District)
            end

            if ToggleButton_SessionOnline.v then
                imgui.TextColoredRGB("{FFFFFF}� �� � ����: " .. get_clock(sessionFull.v))
            end

            if ToggleButton_Time.v then
                imgui.TextColoredRGB("{FFFFFF}� ������� �����: " .. nowTime)
            end

            imgui.End()
        imgui.PopStyleColor()
    end

    if helpChatWindow.v then
        local sx, sy = getScreenResolution()
        if sampIsChatInputActive() then
            imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0))
                name = sampGetPlayerNickname(pID)
                ping = sampGetPlayerPing(pID)
                score = sampGetPlayerScore(pID)
                color = sampGetPlayerColor(pID)
                capsState = ffi.C.GetKeyState(20)
                success = ffi.C.GetKeyboardLayoutNameA(KeyboardLayoutName)
                errorCode = ffi.C.GetLocaleInfoA(tonumber(ffi.string(KeyboardLayoutName), 16), 0x00000002, LocalInfo, BuffSize)
                localName = ffi.string(LocalInfo)
                text = string.format("| {ffffff}%s {ffffff}| {%0.6x}%s {ffffff}| ID: {ff8533}%d {ffffff}| LvL: {ff8533}%d {ffffff}| Ping: %s | Caps: %s | ���������: {ffff00}%s{ffffff} |", os.date("%H:%M:%S"), bit.band(color,0xffffff), name, pID, score, getStrByPing(ping), getStrByState(capsState), localName)
                imgui.SetNextWindowPos(imgui.ImVec2(sx / 2 - 860, sy / 2 - 205), imgui.Cond.FirstUseEver)
                imgui.SetNextWindowSize(imgui.ImVec2(650, 50))
                imgui.Begin('HelpChat', helpChatWindow, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
                renderFontDrawText(font, text, sx / 2 - 917, sy / 2 - 205, -1)
                imgui.End()
            imgui.PopStyleColor()
        end
    end

    if calcWindow.v then
        if sampIsChatInputActive() then
            local input = sampGetInputInfoPtr()
            local input = getStructElement(input, 0x8, 4)
            local windowPosX = getStructElement(input, 0x8, 4)
            local windowPosY = getStructElement(input, 0xC, 4)
            imgui.SetNextWindowPos(imgui.ImVec2(windowPosX, windowPosY + 30 + 15), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowSize(imgui.ImVec2(result:len()*10, 30))
            imgui.Begin('Calc', calcWindow, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
            imgui.CenterText(u8(result))
            imgui.End()
        end
    end

    if main_window_state.v then
        local sx, sy = getScreenResolution()

        imgui.SetNextWindowPos(imgui.ImVec2(sx / 2 + 700, sy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(400, 500), imgui.Cond.FirstUseEver)
    
        logo = logostarter
        imgui.Begin("Rodina Helper", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove)
    
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 200) / 2)
        imgui.Image(logo, imgui.ImVec2(200,200))
    
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 165) / 2)
        imgui.PushFont(fontsize)
            imgui.TextColoredRGB("{af2121}Rodina Helper")
        imgui.PopFont()
    
        imgui.BeginChild("Rodina Helper", imgui.ImVec2(392,233), true)
    
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 330) / 2)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 310) / 2)
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                if imgui.Button(fa.ICON_FA_COG .. u8" ���������", imgui.ImVec2(330,30)) then
                    main_window_state.v = false
                    settings_window_state_one.v = true
                    settings_window_state_two.v = true
                    imgui.Process = true
                end
            imgui.PopStyleVar()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 330) / 2)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 220) / 2)
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                if imgui.Button(fa.ICON_FA_USER .. u8" �� ������", imgui.ImVec2(330,30)) then
                    biography_window_state.v = true
                    main_window_state.v = false
                    imgui.Process = true
                end
            imgui.PopStyleVar()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 330) / 2)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 130) / 2)
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                if imgui.Button(fa.ICON_FA_GIFT .. u8" ���������", imgui.ImVec2(330,30)) then
                    Error("������ ������� ��������� � ����������..")
                end
            imgui.PopStyleVar()
            
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 190))
            imgui.Separator()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 230))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 183))
            imgui.TextColoredRGB("{696969}version 0.0.1")
        imgui.EndChild()
        imgui.End()
    end

    if biography_window_state.v then
        local sx, sy = getScreenResolution()

        author = authorstarter
        profile = profilestarter
        group = groupstarter

        imgui.SetNextWindowPos(imgui.ImVec2(sx / 2, sy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 300), imgui.Cond.FirstUseEver)

        imgui.Begin(fa.ICON_FA_USER .. u8" �� ������", biography_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        
        imgui.BeginChild(u8"�� ������", imgui.ImVec2(693,270), true)

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 600) / 2)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 590) / 2)
            imgui.Image(author, imgui.ImVec2(150,150))

            imgui.SetCursorPosY((imgui.GetWindowWidth() - 448))
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                if imgui.Button(fa.ICON_FA_LONG_ARROW_ALT_LEFT .. u8" �����", imgui.ImVec2(236,20)) then
                    main_window_state.v = true
                    biography_window_state.v = false
                    imgui.Process = true
                end
            imgui.PopStyleVar()

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 450))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 690) / 2)
            imgui.VerticalSeparator()

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 250))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 680) / 2)
            imgui.PushFont(fontsizeauthor)
                imgui.TextColoredRGB("{FF0000}sVor")
            imgui.PopFont()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 378))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 640))
            imgui.TextColoredRGB("{FF0000}LUA{FFFFFF} ��������. ����� ������. �������� � �������.")
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 416))
            imgui.TextColoredRGB("{FFFFFF}� ����� ������� �������� ��� - {FF0000}sVor{FFFFFF}. ����� ����� ������� {FF0000}SA{FFFFFF}:{FF0000}MP{FFFFFF}.")
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 428))
            imgui.TextColoredRGB("{FFFFFF}� ������ ����� �� ��� �� � �����, ������� ����� ������ �� ������.")
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 410))
            imgui.TextColoredRGB("{FFFFFF}����� ����������� ���� ����� � ����� ������ � ���������.")
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 428))
            imgui.TextColoredRGB("{FFFFFF}���� � ������������ ��� ��������� ����� �� ���� � ���� �������.")
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 350))
            imgui.TextColoredRGB("{FFFFFF}�������, ��� ����������� ���� ��������.")
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 230))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 520))
            imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0 ), fa.ICON_FA_HEART, imgui.sh)

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 60) / 2)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 320) / 2)
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0, 0, 0, 0))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.43, 0.37, 0.37, 0.25))
                    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.43, 0.37, 0.37, 0.45))
                        imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 40.0)
                            if imgui.Button("##1", imgui.ImVec2(70, 70)) then
                                os.execute("start https://vk.com/serrgey_vorrobey")
                            end
                        imgui.PopStyleVar()
                   imgui.PopStyleColor()
                imgui.PopStyleColor()
            imgui.PopStyleColor()

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 140))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 320) / 2)
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0, 0, 0, 0))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.43, 0.37, 0.37, 0.25))
                    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.43, 0.37, 0.37, 0.45))
                        imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 40.0)
                            if imgui.Button("##2", imgui.ImVec2(70, 70)) then
                                os.execute("start https://vk.com/rodina_helper")
                            end
                        imgui.PopStyleVar()
                   imgui.PopStyleColor()
                imgui.PopStyleColor()
            imgui.PopStyleColor()

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 140))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 320) / 2)
            imgui.Image(group, imgui.ImVec2(70,70))

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 60) / 2)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 320) / 2)
            imgui.Image(profile, imgui.ImVec2(70, 70))

        imgui.EndChild()
        imgui.End()
    end

    if settings_window_state_one.v then
        local sx, sy = getScreenResolution()

        imgui.SetNextWindowPos(imgui.ImVec2(sx / 3.5 + 50, sy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(300, 500), imgui.Cond.FirstUseEver)

        imgui.Begin("##3", settings_window_state_one, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove)

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 180) / 2)
        imgui.Image(logo, imgui.ImVec2(180,180))

        imgui.BeginChild("##5", imgui.ImVec2(292, 500 - 193), true)

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 289))
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            if imgui.Button(u8"�������� ���������", imgui.ImVec2(286,50)) then
                if not window_loaded_two then
                    Error("��������� ��������� ��������!")
                else
                    BasicSettings = true
                    ScriptsSettings = false
                    MyAnalitics = false
                    Notes = false
                    ScriptMineSettings = false

                    Shadow_Window_State.v = false
                    ShadowWindow_InfoWindow = false
                    ShadowWindow_Distance3DTextMine = false
                    ShadowWindow_NotesWindow = false
                    ShadowWindow_OpenBoxPandora = false
                end
            end
        imgui.PopStyleVar()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 289))
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            if imgui.Button(u8"��������� ( ���� / ������� )", imgui.ImVec2(286,50)) then
                if not window_loaded_two then
                    Error("��������� ��������� ��������!")
                else
                    BasicSettings = false
                    ScriptsSettings = true
                    MyAnalitics = false
                    Notes = false
                    ScriptMineSettings = false

                    Shadow_Window_State.v = false
                    ShadowWindow_InfoWindow = false
                    ShadowWindow_Distance3DTextMine = false
                    ShadowWindow_NotesWindow = false
                    ShadowWindow_OpenBoxPandora = false
                end
            end
        imgui.PopStyleVar()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 289))
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            if imgui.Button(u8"��� ����������", imgui.ImVec2(286,50)) then
                if not window_loaded_two then
                    Error("��������� ��������� ��������!")
                else
                    MyAnalitics = true
                    ScriptsSettings = false
                    BasicSettings = false
                    Notes = false
                    ScriptMineSettings = false

                    Shadow_Window_State.v = false
                    ShadowWindow_InfoWindow = false
                    ShadowWindow_Distance3DTextMine = false
                    ShadowWindow_NotesWindow = false
                    ShadowWindow_OpenBoxPandora = false
                end
            end
        imgui.PopStyleVar()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 289))
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            if imgui.Button(u8"�������", imgui.ImVec2(286,50)) then
                if not window_loaded_two then
                    Error("��������� ��������� ��������!")
                else
                    BasicSettings = false
                    ScriptsSettings = false
                    MyAnalitics = false
                    Notes = true
                    ScriptMineSettings = false

                    Shadow_Window_State.v = false
                    ShadowWindow_InfoWindow = false
                    ShadowWindow_Distance3DTextMine = false
                    ShadowWindow_NotesWindow = false
                    ShadowWindow_OpenBoxPandora = false
                end
            end
        imgui.PopStyleVar()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 289))
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            if imgui.Button(u8"������� ����", imgui.ImVec2(286,50)) then
                settings_window_state_one.v = false
                settings_window_state_two.v = false

                Shadow_Window_State.v = false
                ShadowWindow_InfoWindow = false
                ShadowWindow_Distance3DTextMine = false
                ShadowWindow_NotesWindow = false
                ShadowWindow_OpenBoxPandora = false
            end
        imgui.PopStyleVar()

        imgui.Separator()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 215))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 10))
        string = string.format("{696969}%s\t%s", os.date("%d.%m.%Y"), os.date("%H:%M:%S"))
        imgui.TextColoredRGB(string)

        imgui.EndChild()
        imgui.End()
    end

    if settings_window_state_two.v then
        local sx, sy = getScreenResolution()

        imgui.SetNextWindowPos(imgui.ImVec2(sx / 2 + 150, sy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 500), imgui.Cond.FirstUseEver)

        imgui.Begin("##4", settings_window_state_two, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove)

        if not window_loaded_two then
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 390))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 500))
            imgui.Spinner("����", 40, 10, 0x962121FF)
            TimerSpinner()
        else
            if BasicSettings then
                --imgui.BeginChild("Notes", imgui.ImVec2(692,492), true)
                    imgui.SetCursorPosX((imgui.GetWindowWidth() / 2.7))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
                    imgui.PushFont(fontsizesettings)
                        imgui.TextColoredRGB("{FF0000}�������� ���������")
                    imgui.PopFont()
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 640))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 650))
                    imgui.BeginChild("�� ���?", imgui.ImVec2(600, 170), true)
                    if FirstPage then
                        if imgui.ToggleButton("##ButtonCalc", ToggleButton_CalcChat) then
                            mainIni.settings.ButtonCalc = ToggleButton_CalcChat.v
                            inicfg.save(mainIni, directIni)
                        end
                        imgui.SameLine()
                        imgui.TextColoredRGB("{FFFFFF}����������� � ���� {696969}(?)")
                        imgui.Hint(u8"����������� � ����",u8"�� ������� ��������� ����� ��������� � ������ ����� ��������� � ������ �������� ���������� �����.\n������: 2 + 2 | �����: 4.", 0)
                        imgui.SameLine()
                        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                            imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
                            imgui.ButtonClickable(false, u8"���������", imgui.ImVec2(100,19))
                        imgui.PopStyleVar()

                        if imgui.ToggleButton("##ButtonHelpChat", ToggleButton_HelpChat) then
                            mainIni.settings.ButtonHelpChat = ToggleButton_HelpChat.v
                            inicfg.save(mainIni, directIni)
                        end
                        imgui.SameLine()
                        imgui.TextColoredRGB("{FFFFFF}���������� ��� ������� ����� {696969}(?)")
                        imgui.Hint(u8"���������� ��� ������� �����",u8"��� ������ ��������� ��� ������� ����� ���������� ��� ����������� ����������.\n�����, ��� NickName, ID, �������, Ping, ��������� � ������� �� CapsLock.", 0)
                        imgui.SameLine()
                        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                            imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
                            imgui.ButtonClickable(false, u8"���������", imgui.ImVec2(100,19))
                        imgui.PopStyleVar()
                        
                        if imgui.ToggleButton("##ButtonAccent", ToggleButton_Accent) then
                            mainIni.settings.ButtonAccent = ToggleButton_Accent.v
                            inicfg.save(mainIni, directIni)
                        end
                        imgui.SameLine()
                        imgui.TextColoredRGB("{FFFFFF}������ {696969}(?)")
                        imgui.Hint(u8"������",u8"����� ������ ����� ���������� ����� ���������� '������' ������������� �����.", 0)
                        imgui.SameLine()
                        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                            imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
                            if imgui.Button(u8"���������##1", imgui.ImVec2(100,19)) then
                                ChoiceSettings = true
                                AccentSettings = true
                                InfoWindowSettings = false
                                ClearChatSettings = false
                                WeatherTimeSettings = false
                                HotKeySettings = false
                                SkinSettings = false
                            end
                        imgui.PopStyleVar()

                        if imgui.ToggleButton("##ButtonInfoWindow", ToggleButton_InfoWindow) then
                            mainIni.settings.ButtonInfoWindow = ToggleButton_InfoWindow.v
                            inicfg.save(mainIni, directIni)
                        end
                        imgui.SameLine()
                        imgui.TextColoredRGB("{FFFFFF}�������������� ���� {696969}(?)")
                        imgui.Hint(u8"�������������� ����",u8"� ������ ����� ������ ����� ������������ ���� �� ���� ����������� �����������.", 0)
                        imgui.SameLine()
                        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                            imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
                            if imgui.Button(u8"���������##2", imgui.ImVec2(100,19)) then
                                ChoiceSettings = true
                                InfoWindowSettings = true
                                AccentSettings = false
                                WeatherTimeSettings = false
                                ClearChatSettings = false
                                HotKeySettings = false
                                SkinSettings = false
                            end
                        imgui.PopStyleVar()

                        if imgui.ToggleButton("##ButtonWeather", ToggleButton_Weather) then
                            mainIni.settings.ButtonWeather = ToggleButton_Weather.v
                            inicfg.save(mainIni, directIni)
                        end
                        imgui.SameLine()
                        imgui.TextColoredRGB("{FFFFFF}��������� �������/������ {696969}(?)")
                        imgui.Hint(u8"��������� �������/������", u8"�������������� ������ � ����� �� ����� ������ � �������������!", 0)
                        imgui.SameLine()
                        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                            imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
                            if imgui.Button(u8"���������##3", imgui.ImVec2(100,19)) then
                                if not ToggleButton_Weather.v then
                                    sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������! ��� ������ �������� '��������� �������/������'!", -1)
                                    ChoiceSettings = false
                                else
                                    ChoiceSettings = true
                                    InfoWindowSettings = false
                                    AccentSettings = false
                                    WeatherTimeSettings = true
                                    ClearChatSettings = false
                                    HotKeySettings = false
                                    SkinSettings = false
                                end
                            end
                        imgui.PopStyleVar()

                        if imgui.ToggleButton("##ButtonClearChat", ToggleButton_ClearChat) then
                            mainIni.settings.ButtonClearChat = ToggleButton_ClearChat.v
                            inicfg.save(mainIni, directIni)
                        end
                        imgui.SameLine()
                        imgui.TextColoredRGB("{FFFFFF}�������� ��������� �� ���� {696969}(?)")
                        imgui.Hint(u8"�������� ��������� �� ����", u8"�������� ��� �� �������� ��� ����������! (����������, �������� ������������� � ��.)", 0)
                        imgui.SameLine()
                        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                            imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
                            if imgui.Button(u8"���������##4", imgui.ImVec2(100,19)) then
                                ChoiceSettings = true
                                InfoWindowSettings = false
                                AccentSettings = false
                                WeatherTimeSettings = false
                                ClearChatSettings = true
                                HotKeySettings = false
                                SkinSettings = false
                            end
                        imgui.PopStyleVar()
                    end
                --imgui.EndChild()

                if TwoPage then
                    TwoPageFunc()
                end

                -- ��������

                imgui.SetCursorPosX((imgui.GetWindowWidth() - 330))
                imgui.SetCursorPosY((imgui.GetWindowWidth() - 455))
                imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                    if FirstPage then
                        imgui.ButtonClickable(false, "1", imgui.ImVec2(20,20))
                    else
                        if imgui.ButtonClickable(true, "1", imgui.ImVec2(20,20)) then
                            FirstPage = true
                            TwoPage = false
                            ChoiceSettings = false
                        end
                    end
                imgui.PopStyleVar()

                imgui.SameLine()

                imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                    if TwoPage then
                        imgui.ButtonClickable(false, "2", imgui.ImVec2(20,20))
                    else
                        if imgui.ButtonClickable(true, "2", imgui.ImVec2(20,20)) then
                            FirstPage = false
                            TwoPage = true
                            ChoiceSettings = false
                        end
                    end
                imgui.PopStyleVar()
            imgui.EndChild()

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 650))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 425))
            imgui.BeginChild("�� ���?!?!?!!?!?", imgui.ImVec2(600, 170), true)
            if not ChoiceSettings then
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 495))
                imgui.SetCursorPosY((imgui.GetWindowWidth() - 533))
                imgui.PushFont(fontsizeauthor)
                    imgui.TextColoredRGB("{3b3b3b}�������� ����� ��� ���������")
                imgui.PopFont()
            else
                if AccentSettings then
                    AccentSettingsFunction()
                end

                if InfoWindowSettings then
                    InfoWindowSettingsButton()
                end

                if WeatherTimeSettings then
                    if not ToggleButton_Weather.v then
                        ChoiceSettings = false
                    else
                        WeatherSettings()
                    end
                end

                if ClearChatSettings then
                    ClearChatButtons()
                end

                if SkinSettings then
                    SkinChange()
                end

                if HotKeySettings then
                    HotKeySettingFunction()
                end
            end
            imgui.EndChild()
            end -- BasicSettings

            if ScriptsSettings then
                FirstPage = true
                TwoPage = false
                ChoiceSettings = false
                MyAnalitics = false
                Notes = false
                ScriptMineSettings = false

                ScriptsFunction()
            end

            if MyAnalitics then
                FirstPage = true
                TwoPage = false
                ChoiceSettings = false
                ScriptsSettings = false
                Notes = false
                ScriptMineSettings = false

                MyAnaliticsFunction()
            end

            if Notes then
                FirstPage = true
                TwoPage = false
                ChoiceSettings = false
                MyAnalitics = false
                ScriptsSettings = false
                ScriptMineSettings = false

                NotesFunction()
            end

            if ScriptMineSettings then
                FirstPage = true
                TwoPage = false
                ChoiceSettings = false
                MyAnalitics = false
                ScriptsSettings = false

                ScriptMineSettingsFunction()
            end
        end
        imgui.End()
    end

    if Shadow_Window_State.v then
        ShadowWindowInfo()
    end
end


-------------------------------------------------------- ���. ������� -----------------------------------------------------
function sampGetPlayerIdByNickname(nick)
    nick = tostring(nick)
    local _, pID = sampGetPlayerIdByCharHandle(PLAYER_PED)
    if nick == sampGetPlayerNickname(pID) then return pID end
    for i = 0, 1003 do
      if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == nick then
        return i
      end
    end
end

function Restart()
    sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������ ���������������..", -1)
    wait(2000) -- �������� �� 3000
    thisScript():reload()
end

--[[function get_timer(time)
    return string.format("%s:%s:%s",string.format("%s%s",((tonumber(os.date("%H",time)) < tonumber(os.date("%H",0)) and (24 + tonumber(os.date("%H",time))) - tonumber(os.date("%H",0)) or tonumber(os.date("%H",time)) - (tonumber(os.date("%H",0)))) < 10 and 0 or ""),(tonumber(os.date("%H",time)) < tonumber(os.date("%H",0)) and (24 + tonumber(os.date("%H",time))) - tonumber(os.date("%H",0)) or tonumber(os.date("%H",time)) - (tonumber(os.date("%H",0))))),os.date("%M",time),os.date("%S",time))
end]]

--[[function convertin_sec(time)
    return strung.format("%s:%s", )
end]]

function getfps()
    lua_thread.create(function()
        wait(300)
            fps = math.floor(memory.getfloat(0xB7CB50, true))
        return true
    end)
end

function sampev.onSendSpawn()
    if ToggleButton_SaveSkin.v then
        changeSkin(-1, SkinIDLoad)
    end
	showCursor(false)

    mainIni.connecttime.LastConnectTime = os.date("%H:%M:%S")
    inicfg.save(mainIni, directIni)
end

function imgui.ButtonClickable(clickable, ...)
    if clickable then
        return imgui.Button(...)

    else
        local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()
        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a/2) )
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a/2))
        imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a/2))
        imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
            imgui.Button(...)
        imgui.PopStyleColor()
        imgui.PopStyleColor()
        imgui.PopStyleColor()
        imgui.PopStyleColor()
    end
end

function sampev.onSendChat(msg)
    if UseAccent == true then
        msg = accent(msg)
        if msg == nil then
            return false
        end
        return {msg}
    end
end

function accent(msg)
	msg = string.format("[%s]: %s", selectedAccent, msg)
	return msg
end

function getStrByState(keyState)
	if keyState == 0 then
		return "{FF0000}OFF{ffffff}"
	end
	return "{00FF00}ON{ffffff}"
end

function getStrByPing(ping)
	if ping < 100 then
		return string.format("{85cf17}%d{ffffff}", ping)
	elseif ping < 150 then
		return string.format("{ff8533}%d{ffffff}", ping)
	end
	return string.format("{BF0000}%d{ffffff}", ping)
end

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end

function imgui.Hint(tipeHint,text, delay, action)
    if imgui.IsItemHovered() then
        if go_hint == nil then go_hint = os.clock() + (delay and delay or 0.0) end
        local alpha = (os.clock() - go_hint) * 5
        if os.clock() >= go_hint then
            imgui.PushStyleVar(imgui.StyleVar.WindowPadding, imgui.ImVec2(10, 10))
            imgui.PushStyleVar(imgui.StyleVar.Alpha, (alpha <= 1.0 and alpha or 1.0))
                imgui.PushStyleColor(imgui.Col.PopupBg, imgui.ImVec4(0.11, 0.11, 0.11, 1.00))
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    string = string.format(u8"��������� (%s):", tipeHint)
                    imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], string)
                    imgui.TextUnformatted(text)
                    if action ~= nil then
                        imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.TextDisabled], '\n '..action)
                    end
                    if not imgui.IsItemVisible() and imgui.GetStyle().Alpha == 1.0 then go_hint = nil end
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()
                imgui.PopStyleColor()
            imgui.PopStyleVar(2)
        end
    end
end

function imgui.Ques(text)
    imgui.SameLine()
    imgui.TextDisabled("(?)")
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.TextUnformatted(u8(text))
        imgui.EndTooltip()
    end
end

function TimerSpinner()
    lua_thread.create(function()
    wait(2000) -- ������� ��� ��������� ������������ ( �������� �� 3000 )
    window_loaded_two = true
    end)
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end

    render_text(text)
end

function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/Rodina Helper/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
        fa_font_binder = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/Rodina Helper/fonts/fa-solid-900.ttf', 18.0, font_config2, fa_glyph_ranges)
        fa_font_Success = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/Rodina Helper/fonts/fa-solid-900.ttf', 90.0, font_config3, fa_glyph_ranges)
    end

    if fontsize == nil then
        fontsize = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 30.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
    
    if fontsizeauthor == nil then
        fontsizeauthor = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 30.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
    end

    if fontsizesettings == nil then
        fontsizesettings = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 20.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
    end

    if fontsizechathelper == nil then
        fontsizechathelper = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 17.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
    end

    if fontsizetextSuccess == nil then
        fontsizetextSuccess = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 40.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
end

function imgui.VerticalSeparator()
    local p = imgui.GetCursorScreenPos()
    imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x, p.y + imgui.GetContentRegionMax().y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.Separator]))
end

function calcCity(x, y)
    local cities = {
        {
            name = "�������",
            {836.0923,137.1198},
            {-926.5483,1069.9520},
        },
        {
            name = "�������",
            {-93.6686,2572.6885},
            {885.9571,1101.2371},
        },
        {
            name = "����������",
            {-405.7435,1849.8569},
            {-867.4938,2341.9189},
        },
        {
            name = "����������",
            {-114.7554,1367.1804},
            {-472.5378,1688.0573},
        },
        {
            name = "�����",
            {-2169.6870,2436.8511},
            {-2673.7266,2874.8918},
        },
        {
            name = "���������",
            {-1921.7549,-509.7450},
            {-2678.8569,790.2356},
        },
        {
            name = "�������",
            {-1701.6182,-1289.7214},
            {-1015.8488,-2591.5999},
        },
        {
            name = "�������",
            {-443.0625,-2577.4478},
            {-1034.1122,-2005.3527},
        },
        {
            name = "�������",
            {-778.9846,-1469.6333},
            {-200.0970,-2106.8787},
        },
        {
            name = "������",
            {1436.9014,-336.6613},
            {661.5156,352.0792},
        },
        {
            name = "��������",
            {1741.9849,1466.9530},
            {2491.7610,992.9572},
        },
    }   
    for k, v in pairs(cities) do
        local name = v.name
        local a = v[1]
        local b = v[2]
        if x >= math.min(a[1], b[1]) and x <= math.max(a[1], b[1]) then
            if y >= math.min(a[2], b[2]) and y <= math.max(a[2], b[2]) then
                return name
            end
        end
    end
    return '- �� ��� ������ -'
end

function calcDistrict(x, y)
    local district = {
        {
            name = "Test",
            {836.0923,137.1198},
            {-926.5483,1069.9520},
        },
    }   
    for k, v in pairs(district) do
        local name = v.name
        local a = v[1]
        local b = v[2]
        if x >= math.min(a[1], b[1]) and x <= math.max(a[1], b[1]) then
            if y >= math.min(a[2], b[2]) and y <= math.max(a[2], b[2]) then
                return name
            end
        end
    end
    return '- ������ �� ������� -'
end

function isValidServer()
    local servers = {
        '185.169.134.60:8904', -- �����
        '185.169.134.108:7777', -- ���������
        '185.169.134.163:7777', -- �����������
        '185.169.134.62:8904' -- ��������
    }
    local ip, port = sampGetCurrentServerAddress()
    local server = ip..':'..port
    for _, h in ipairs(servers) do
        if server == h then
            return true
        end
    end
    return false
end

math.round = function(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function sampev.onServerMessage(color, text)

    if text:find("__________���������� ���__________") then
        SuccessPayDays = SuccessPayDays + 1
        mainIni.PayDays.SuccessPayDays = SuccessPayDays
        inicfg.save(mainIni, directIni)
    end

    if text:find("��� ��������� PayDay �� ������ �������� ������� 20 �����!") then
        FailedPayDays = FailedPayDays + 1
        mainIni.PayDays.FailedPayDays = FailedPayDays
        inicfg.save(mainIni, directIni)
    end

    if text:find("����������:") then
        if ToggleButton_AD.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("��������������") then
        if ToggleButton_AD.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    -------------------------------------------

    if text:find("�������������") then
        if ToggleButton_ChatAdministration.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    --------------------------------------------

    if text:find("��������������� �������") then
        if ToggleButton_ChatGOV.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("    ") then
        if ToggleButton_ChatGOV.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("��������� ������ ������") then
        if ToggleButton_ChatGOV.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("� ������ ������ ��������") then
        if ToggleButton_ChatGOV.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("��� ���������� ����������") then
        if ToggleButton_ChatGOV.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    ----------------------------------------------

    if text:find("NEWS �������") then
        if ToggleButton_NEWS.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    -----------------------------------------------

    if text:find("�������") then
        if ToggleButton_Events.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("�����") then
        if ToggleButton_Events.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("���") then
        if ToggleButton_Events.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    -----------------------------------------------

    if text:find("> �����") then
        if ToggleButton_Exit.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    ------------------------------------------------

    if text:find("~~~~~") then
        if ToggleButton_ServerInfo.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("�������� ������� �������") then
        if ToggleButton_ServerInfo.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("�������� �����") then
        if ToggleButton_ServerInfo.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    if text:find("����� � ���������") then
        if ToggleButton_ServerInfo.v then
            if ToggleButton_ClearChat.v then
                return false
            end
        end
    end

    --------------------------------------------
    if text:find("���� �������") then
        if ToggleButton_OpenBoxPandora.v then
            lua_thread.create(function()
                wait(100)
                sampAddChatMessage("{FF0000}[���� �������]{FFFFFF}: ��������� �������� ��������� ����� - {FF0000}" .. WaitPandora .. "{FFFFFF} �����(-�).", -1)
            end)
        end
    end

    if text:find("������ �����������") then
        if ToggleButton_TPMP.v then
            lua_thread.create(function()
                sampSendChat("/gotp")
                wait(1000)
                setVirtualKeyDown(VK_RETURN, true)
                wait(1000)
                setVirtualKeyDown(VK_RETURN, false)
            end)
        end
    end

    if text:find("������") and StartMineScript then
        if CheckBoxLine.v then
            StoneSession = StoneSession + 1
            StoneDay = StoneDay + 1
            mainIni.minesettings.StoneDay = StoneDay
            inicfg.save(mainIni, directIni)
        end
        if CheckBoxShow3DTextTime.v then
            local NameSource = "������"
            Update3DTextSource(NameSource)
        end
    end
    if text:find("������") and StartMineScript then
        if CheckBoxLine.v then
            MetalSession = MetalSession + 1
            MetalDay = MetalDay + 1
            mainIni.minesettings.MetalDay = MetalDay
            inicfg.save(mainIni, directIni)
        end
        if CheckBoxShow3DTextTime.v then
            local NameSource = "������"
            Update3DTextSource(NameSource)
        end
    end
    if text:find("�������") and StartMineScript then
        if CheckBoxLine.v then
            SilverSession = SilverSession + 1
            SilverDay = SilverDay + 1
            mainIni.minesettings.SilverDay = SilverDay
            inicfg.save(mainIni, directIni)
        end
        if CheckBoxShow3DTextTime.v then
            local NameSource = "�������"
            Update3DTextSource(NameSource)
        end
    end
    if text:find("������") and StartMineScript then
        if CheckBoxShow3DTextTime.v then
            local NameSource = "������"
            Update3DTextSource(NameSource)
        end
    end
    if text:find("������") and StartMineScript then
        if CheckBoxLine.v then
            GoldSession = GoldSession + 1
            GoldDay = GoldDay + 1
            mainIni.minesettings.GoldDay = GoldDay
            inicfg.save(mainIni, directIni)
        end
        if CheckBoxShow3DTextTime.v then
            local NameSource = "������"
            Update3DTextSource(NameSource)
        end
    end
end

function ClearChatButtons()
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 590))
    if imgui.ToggleButton("##ButtonAD", ToggleButton_AD) then
        mainIni.clearchat.ButtonAD = ToggleButton_AD.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}��������� ���������� {696969}(?)")
    imgui.Hint(u8"��������� ����������",u8"��������� ��� ���������� ��� � ����.", 0)

    if imgui.ToggleButton("##ButtonChatAdministration", ToggleButton_ChatAdministration) then
        mainIni.clearchat.ButtonChatAdministration = ToggleButton_ChatAdministration.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}��������� �������� ������������� {696969}(?)")
    imgui.Hint(u8"��������� �������� �������������",u8"��������� ��� ���������, ������� ����� ������������� � ����.", 0)

    if imgui.ToggleButton("##ButtonChatGOV", ToggleButton_ChatGOV) then
        mainIni.clearchat.ButtonChatGOV = ToggleButton_ChatGOV.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}��������� ���. ������� {696969}(?)")
    imgui.Hint(u8"��������� ���. �������",u8"��������� ��������������� ������� � ����.", 0)

    if imgui.ToggleButton("##ButtonNEWS", ToggleButton_NEWS) then
        mainIni.clearchat.ButtonNEWS = ToggleButton_NEWS.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}��������� ������� ��� {696969}(?)")
    imgui.Hint(u8"��������� ������� ���",u8"��������� �������, ������������ ������������ ��� � ����.", 0)

    if imgui.ToggleButton("##ButtonEvents", ToggleButton_Events) then
        mainIni.clearchat.ButtonEvents = ToggleButton_Events.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}��������� ���������� � ������������ {696969}(?)")
    imgui.Hint(u8"��������� ���������� � ������������",u8"��������� ����������� � ������ ���������� ����������� � ����.", 0)

    if imgui.ToggleButton("##ButtonExit", ToggleButton_Exit) then
        mainIni.clearchat.ButtonExit = ToggleButton_Exit.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}��������� ���������� � ����������� {696969}(?)")
    imgui.Hint(u8"��������� ���������� � �����������",u8"��������� ����������� � ������ �� ���� ���������� � ����.", 0)

    if imgui.ToggleButton("##ButtonServerInfo", ToggleButton_ServerInfo) then
        mainIni.clearchat.ButtonServerInfo = ToggleButton_ServerInfo.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}��������� ���������� � ������� {696969}(?)")
    imgui.Hint(u8"��������� ���������� � �������",u8"��������� ���������� � ������� � ����.", 0)
end

function WeatherSettings()
    if weather.v == -1 then
        weather.v = readMemory(0xC81320, 1, true) 
    end
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 365))
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 575))
    imgui.TextColoredRGB("{FFFFFF}�������� ID ������:")
    imgui.PushItemWidth(350)
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 480))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 555))
        imgui.SliderInt(u8" ", weather, 0, 50)
    imgui.PopItemWidth()

    if gametime.v == -1 then 
        gametime.v = readMemory(0xB70153, 1, true) 
    end

    imgui.SetCursorPosX((imgui.GetWindowWidth() - 355))
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 515))
    imgui.TextColoredRGB("{FFFFFF}�������� �����:")

    imgui.PushItemWidth(350)
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 480))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 495))
        imgui.SliderInt(u8" ##1", gametime, 0, 23)
    imgui.PopItemWidth()
end

function InfoWindowSettingsButton()
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 590))
    if imgui.ToggleButton("##ButtonHP", ToggleButton_HP) then
        mainIni.infowindow.ButtonHP = ToggleButton_HP.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����������� HP {696969}(?)")
    imgui.Hint(u8"����������� HP",u8"��������/��������� ����� ������ HP � �������������� ����.", 0)

    if imgui.ToggleButton("##ButtonArmor", ToggleButton_Armor) then
        mainIni.infowindow.ButtonArmor = ToggleButton_Armor.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����������� ����� {696969}(?)")
    imgui.Hint(u8"����������� �����",u8"��������/��������� ����� ��������� ����� ����� � �������������� ����.", 0)

    if imgui.ToggleButton("##ButtonFPS", ToggleButton_FPS) then
        mainIni.infowindow.ButtonFPS = ToggleButton_FPS.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����������� FPS {696969}(?)")
    imgui.Hint(u8"����������� FPS",u8"��������/��������� ����� ������ FPS � �������������� ����.", 0)

    if imgui.ToggleButton("##ButtonPing", ToggleButton_Ping) then
        mainIni.infowindow.ButtonPing = ToggleButton_Ping.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����������� Ping`a {696969}(?)")
    imgui.Hint(u8"����������� Ping`a",u8"��������/��������� ����� ������ Ping`a � �������������� ����.", 0)

    if imgui.ToggleButton("##ButtonTime", ToggleButton_Time) then
        mainIni.infowindow.ButtonTime = ToggleButton_Time.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����������� ������� {696969}(?)")
    imgui.Hint(u8"����������� �������",u8"��������/��������� ����� ������� ������� � �������������� ����.", 0)

    if imgui.ToggleButton("##ButtonCity", ToggleButton_City) then
        mainIni.infowindow.ButtonCity = ToggleButton_City.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����������� ������ {696969}(?)")
    imgui.Hint(u8"����������� ������",u8"��������/��������� ����� ������ � ������� �� ���������� � �������������� ����.", 0)

    if imgui.ToggleButton("##ButtonDistrict", ToggleButton_District) then
        mainIni.infowindow.ButtonDistrict = ToggleButton_District.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����������� ������ {696969}(?)")
    imgui.Hint(u8"����������� ������",u8"��������/��������� ����� ������ � ������� �� ���������� � �������������� ����.", 0)

    imgui.SetCursorPosX((imgui.GetWindowWidth() - 255))
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 590))
    if imgui.ToggleButton("##ButtonHPAuto", ToggleButton_HPAuto) then
        mainIni.infowindow.ButtonHPAuto = ToggleButton_HPAuto.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����������� ��������� ���� {696969}(?)")
    imgui.Hint(u8"����������� ��������� ����",u8"��������/��������� ����� ��������� ���������� � ������� �� ���������� � �������������� ����. ��������! 50.8% �������� ����������� ��������� ��� Rodina RP.", 0)

    imgui.SetCursorPosX((imgui.GetWindowWidth() - 255))
    if imgui.ToggleButton("##ButtonSessionOnline", ToggleButton_SessionOnline) then
        mainIni.infowindow.ButtonSessionOnline = ToggleButton_SessionOnline.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����������� ������� �� ������ {696969}(?)")
    imgui.Hint(u8"����������� ������� �� ������",u8"��������/��������� ����� ������� ������ ���������� � ���� � ������� ������� � �������������� ����.", 0)

    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 230))
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 530))
        if imgui.Button(u8"�������� ������������ ����", imgui.ImVec2(200,20)) then
            sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ������� � ������� {FF0000}Enter{FFFFFF} ����� ��������� �.", -1)
            changePositionInfoWindow = true
            settings_window_state_one.v = false
            settings_window_state_two.v = false
        end
    imgui.PopStyleVar()

    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 215))
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 505))
        if imgui.Button(u8"�������� ������ ����", imgui.ImVec2(170,20)) then
            Shadow_Window_State.v = true
            ShadowWindow_InfoWindow = true
            ShadowWindow_NotesWindow = false
            ShadowWindow_Distance3DTextMine = false
            ShadowWindow_OpenBoxPandora = false
            ShadowWindow_Succesful = false
        end
    imgui.PopStyleVar()

    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 205))
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 480))
        if imgui.Button(u8"�������� ���������", imgui.ImVec2(150,20)) then
            mainIni.infowindow.PositionX = 1809
            mainIni.infowindow.PositionY = 357
            mainIni.infowindow.SizeY = 200
            inicfg.save(mainIni, directIni)
            sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ��������� ��������������� ���� ������� ��������!", -1)
            if not SaveButtonOn then
                Error("��������� �������..")
            else
                Shadow_Window_State.v = true
                ShadowWindow_InfoWindow = false
                ShadowWindow_Distance3DTextMine = false
                ShadowWindow_NotesWindow = false
                ShadowWindow_OpenBoxPandora = false
                ShadowWindow_Succesful = true
            end
        end
    imgui.PopStyleVar()
end

function ShadowWindowInfo()
    if ShadowWindow_InfoWindow then

        local sx, sy = getScreenResolution()

        imgui.SetNextWindowPos(imgui.ImVec2(sx / 2 + 150, sy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 500), imgui.Cond.FirstUseEver)
        
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.8))
            imgui.Begin("##7", settings_window_state_two, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove)
            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 530))
                imgui.SetCursorPosY((imgui.GetWindowWidth() - 530))
                imgui.BeginChild(u8"�� ������", imgui.ImVec2(350,150), true)
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 330))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 330))
                    imgui.TextColoredRGB("{FFFFFF}������� ����������� ������ ���� ({696969}�� 50 �� 200{FFFFFF})")
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 287))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 290))
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        imgui.InputInt(u8" ", SizeInfoInputBuffer, 1)
                    imgui.PopStyleVar()
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 275))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 230))
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        if imgui.Button(u8"���������", imgui.ImVec2(100,20)) then
                            if SizeInfoInputBuffer.v < 50 or SizeInfoInputBuffer.v > 200 then
                                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������! �� ����� �������� ��������!", -1)
                            else
                                SizeYInfo = SizeInfoInputBuffer.v
                                Shadow_Window_State.v = false
                                mainIni.infowindow.SizeY = SizeYInfo
                                inicfg.save(mainIni, directIni)
                                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ��������� ������ ���� ������� ���������!", -1)
                            end
                        end
                    imgui.PopStyleVar()
                    imgui.SameLine()
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        if imgui.Button(u8"�������", imgui.ImVec2(100,20)) then
                            Shadow_Window_State.v = false
                            SizeInfoInputBuffer.v = SizeYInfo
                        end
                    imgui.PopStyleVar()
                imgui.EndChild()
            imgui.PopStyleColor()
            imgui.End()
        imgui.PopStyleColor()
    end

    if ShadowWindow_OpenBoxPandora then

        local zx, zy = getScreenResolution()

        imgui.SetNextWindowPos(imgui.ImVec2(zx / 2 + 150, zy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 500), imgui.Cond.FirstUseEver)
        
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.8))
            imgui.Begin("##9", settings_window_state_two, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove)
            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 530))
                imgui.SetCursorPosY((imgui.GetWindowWidth() - 530))
                imgui.BeginChild(u8":)", imgui.ImVec2(350,150), true)
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 330))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 330))
                    imgui.TextColoredRGB("{FFFFFF}������� ����������� �������� ({696969}�� 1 �� 60 �����{FFFFFF})")
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 287))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 290))
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        imgui.InputInt(u8" ", SizeOpenBoxPandoraInputBuffer, 1)
                    imgui.PopStyleVar()
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 275))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 230))
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        if imgui.Button(u8"���������", imgui.ImVec2(100,20)) then
                            if SizeOpenBoxPandoraInputBuffer.v < 1 or SizeOpenBoxPandoraInputBuffer.v > 60 then
                                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������! �� ����� �������� ��������!", -1)
                            else
                                Pause = SizeOpenBoxPandoraInputBuffer.v
                                Shadow_Window_State.v = false
                                mainIni.pandora.PauseOpenPandora = Pause
                                inicfg.save(mainIni, directIni)
                                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ��������� ���������!", -1)
                            end
                        end
                    imgui.PopStyleVar()
                    imgui.SameLine()
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        if imgui.Button(u8"�������", imgui.ImVec2(100,20)) then
                            Shadow_Window_State.v = false
                            SizeOpenBoxPandoraInputBuffer.v = WaitPandora
                        end
                    imgui.PopStyleVar()
                imgui.EndChild()
            imgui.PopStyleColor()
            imgui.End()
        imgui.PopStyleColor()
    end

    if ShadowWindow_Succesful then
        local zx, zy = getScreenResolution()

        imgui.SetNextWindowPos(imgui.ImVec2(zx / 2 + 150, zy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 500), imgui.Cond.FirstUseEver)
        
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.8))
            imgui.Begin("##11", settings_window_state_two, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove)
                
                imgui.SetCursorPosX(305)
                imgui.SetCursorPosY(170)
                imgui.PushFont(fa_font_Success)
                    imgui.TextColored(imgui.ImVec4(0.0, 1.0, 0.0, 1.0), fa.ICON_FA_CHECK_CIRCLE, imgui.sh)
                imgui.PopFont()

                imgui.PushFont(fontsizetextSuccess)
                    --imgui.SetCursorPosX(270)
                    imgui.CenterTextColoredRGB("{FFFFFF}�������")
                imgui.PopFont()
                DeleteWaitSuccessful()

            imgui.End()
        imgui.PopStyleColor()
    end

    if ShadowWindow_NotesWindow then
        local sx, sy = getScreenResolution()

        imgui.SetNextWindowPos(imgui.ImVec2(sx / 2 + 150, sy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 500), imgui.Cond.FirstUseEver)
        
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.8))
            imgui.Begin("##9", settings_window_state_two, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove)
            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 530))
                imgui.SetCursorPosY((imgui.GetWindowWidth() - 530))
                imgui.BeginChild(u8"������ �������", imgui.ImVec2(350,150), true)
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 330))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 330))
                    imgui.TextColoredRGB("{FFFFFF}������� ����������� ������ ���� ({696969}�� 300 �� 800{FFFFFF})")
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 287))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 290))
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        imgui.InputInt(u8" ", SizeNotesInputBuffer, 1)
                    imgui.PopStyleVar()
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 275))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 230))
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        if imgui.Button(u8"���������", imgui.ImVec2(100,20)) then
                            if SizeNotesInputBuffer.v < 300 or SizeNotesInputBuffer.v > 800 then
                                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������! �� ����� �������� ��������!", -1)
                            else
                                SizeXNotes = SizeNotesInputBuffer.v
                                Shadow_Window_State.v = false
                                mainIni.notes.SizeX = SizeXNotes
                                inicfg.save(mainIni, directIni)
                                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ��������� ������ ���� ������� ���������!", -1)
                            end
                        end
                    imgui.PopStyleVar()
                    imgui.SameLine()
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        if imgui.Button(u8"�������", imgui.ImVec2(100,20)) then
                            Shadow_Window_State.v = false
                            SizeInfoInputBuffer.v = SizeYInfo
                        end
                    imgui.PopStyleVar()
                imgui.EndChild()
            imgui.PopStyleColor()
            imgui.End()
        imgui.PopStyleColor()
    end

    if ShadowWindow_Distance3DTextMine then
        local sx, sy = getScreenResolution()

        imgui.SetNextWindowPos(imgui.ImVec2(sx / 2 + 150, sy / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 500), imgui.Cond.FirstUseEver)
        
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.8))
            imgui.Begin("##50", settings_window_state_two, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove)
            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 530))
                imgui.SetCursorPosY((imgui.GetWindowWidth() - 530))
                imgui.BeginChild(u8"��������� ����������", imgui.ImVec2(350,150), true)
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 330))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 330))
                    imgui.CenterTextColoredRGB("{FFFFFF}������� ��������� ���������� ({696969}�� 5 �� 50 ������{FFFFFF})")
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 287))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 290))
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        imgui.InputInt(u8" ", SizeCompetitorsInputBuffer, 1)
                    imgui.PopStyleVar()
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 275))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 230))
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        if imgui.Button(u8"���������", imgui.ImVec2(100,20)) then
                            if SizeCompetitorsInputBuffer.v < 5 or SizeCompetitorsInputBuffer.v > 50 then
                                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������! �� ����� �������� ��������!", -1)
                            else
                                DistaceShow = SizeCompetitorsInputBuffer.v
                                Shadow_Window_State.v = false
                                mainIni.minesettings.DistaceShow = DistaceShow
                                inicfg.save(mainIni, directIni)
                                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ��������� ��������� ����������� 3D ������ ������� ���������!", -1)
                            end
                        end
                    imgui.PopStyleVar()
                    imgui.SameLine()
                    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
                        if imgui.Button(u8"�������", imgui.ImVec2(100,20)) then
                            Shadow_Window_State.v = false
                            SizeInfoInputBuffer.v = SizeYInfo
                        end
                    imgui.PopStyleVar()
                imgui.EndChild()
            imgui.PopStyleColor()
            imgui.End()
        imgui.PopStyleColor()
    end
end

function AccentSettingsFunction()
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 395))
    imgui.PushItemWidth(180)
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            if imgui.Combo("##1", comboAccent, u8"���������� ������\0������� ������\0��������� ������\0������������ ������\0����������� ������\0- ������� ���� ������\0\0") then
                if comboAccent.v == 0 then
                    PreviewAccent = "[���������� ������]: ������!"
                end

                if comboAccent.v == 1 then
                    PreviewAccent = "[������� ������]: ������!"
                end

                if comboAccent.v == 2 then
                    PreviewAccent = "[��������� ������]: ������!"
                end

                if comboAccent.v == 3 then
                    PreviewAccent = "[������������ ������]: ������!"
                end

                if comboAccent.v == 4 then
                    PreviewAccent = "[����������� ������]: ������!"
                end
            end
        imgui.PopStyleVar()
    imgui.PopItemWidth()

    if comboAccent.v ~= 5 then
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 350))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 540))
        imgui.TextColoredRGB("{FFFFFF}������������")

        if PreviewAccent == nil then
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 410))
            imgui.TextColoredRGB("{4a4a4a}- �������� ������ ��� ��������� -")
        else
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 395))
            string = string.format(u8"{b7b7b7}%s", PreviewAccent)
            imgui.TextColoredRGB(string)
        end
    else
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 395))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 530))
        imgui.PushItemWidth(180)
            imgui.InputText(u8"������� ������", AccentInputBuffer)
        imgui.PopItemWidth()
    end

    imgui.SetCursorPosX((imgui.GetWindowWidth() - 405))
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 455))
    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
        if imgui.Button(fa.ICON_FA_SAVE .. u8" ���������", imgui.ImVec2(100,20)) then
            if not SaveButtonOn then
                Error("��������� �������..")
            else
                Shadow_Window_State.v = true
                ShadowWindow_InfoWindow = false
                ShadowWindow_Distance3DTextMine = false
                ShadowWindow_OpenBoxPandora = false
                ShadowWindow_Succesful = true
                ShadowWindow_NotesWindow = false
            end
            if comboAccent.v == 0 then
                mainIni.accent.Accent = "���������� ������"
                inicfg.save(mainIni, directIni)
            end

            if comboAccent.v == 1 then
                mainIni.accent.Accent = "������� ������"
                inicfg.save(mainIni, directIni)
            end 

            if comboAccent.v == 2 then
                mainIni.accent.Accent = "��������� ������"
                inicfg.save(mainIni, directIni)
            end 

            if comboAccent.v == 3 then
                mainIni.accent.Accent = "������������ ������"
                inicfg.save(mainIni, directIni)
            end 

            if comboAccent.v == 4 then
                mainIni.accent.Accent = "����������� ������"
                inicfg.save(mainIni, directIni)
            end
            
            if comboAccent.v == 5 then
                mainIni.accent.Accent = u8:decode(AccentInputBuffer.v)
                inicfg.save(mainIni, directIni)
            end
        end
    imgui.PopStyleVar()
    imgui.SameLine()
    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
        if imgui.Button(fa.ICON_FA_SYNC .. u8" ��������", imgui.ImVec2(100,20)) then
            mainIni.accent.Accent = "���������� ������"
            inicfg.save(mainIni, directIni)
            if not SaveButtonOn then
                Error("��������� �������..")
            else
                Shadow_Window_State.v = true
                ShadowWindow_InfoWindow = false
                ShadowWindow_Distance3DTextMine = false
                ShadowWindow_NotesWindow = false
                ShadowWindow_OpenBoxPandora = false
                ShadowWindow_Succesful = true
            end
            comboAccent.v = 0
            PreviewAccent = nil
        end
    imgui.PopStyleVar()
end

function HotKeySettingFunction()
    imgui.Columns(2, "������� �������", false)
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 310))
    imgui.VerticalSeparator()

    imgui.SetCursorPosX((imgui.GetWindowWidth() - 480))
    imgui.TextColoredRGB("{FFFFFF}�������")

    imgui.NextColumn()

    imgui.SetCursorPosX((imgui.GetWindowWidth() - 180))
    imgui.TextColoredRGB("{FFFFFF}��������")
    imgui.Separator()

    imgui.SetCursorPosY((imgui.GetWindowWidth() - 570))

    imgui.NextColumn() -- 1 ������

    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 506))
        if imgui.HotKey("##1", HotKey_1Menu, tLastKeys, 100) then
            rkeys.changeHotKey(HotKey_1Register, HotKey_1Menu.v)
            --sampAddChatMessage("�� �������: " .. encodeJson(HotKey_1Menu.v), -1)

            mainIni.HotKey.HotKey_1 = encodeJson(HotKey_1Menu.v)
            inicfg.save(mainIni, directIni)
        end
    imgui.PopStyleVar()

    imgui.NextColumn()

    if ChangeHotKey_1 then
        imgui.PushItemWidth(100)
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 203))
            imgui.InputText(u8"##100", HotKey1InputBuffer)
            if isKeyJustPressed(VK_RETURN) then
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ������� ��������.", -1)
                ChangeHotKey_1 = false
                mainIni.HotKey.HotKey_1_saveText = u8:decode(HotKey1InputBuffer.v)
                inicfg.save(mainIni, directIni)
            end
        imgui.PopItemWidth()

        imgui.Separator()
    end

    if not ChangeHotKey_1 then
        HotKey_1_Text = mainIni.HotKey.HotKey_1_saveText
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
                local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()
                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a/2) )
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a/2))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a/2))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 260))
                    imgui.Button(u8(HotKey_1_Text), imgui.ImVec2(100,20))
                imgui.PopStyleColor()
                imgui.PopStyleColor()
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleVar()
    end

    imgui.SameLine()

    if not ChangeHotKey_1 then
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 140))
            if imgui.Button(u8"��������", imgui.ImVec2(100,20)) then
                ChangeHotKey_1 = true
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������� ����� �������� � ������� '{FF0000}Enter{FFFFFF}' ��� ����.", -1)
            end
        imgui.PopStyleVar()
    end

    imgui.Separator()

    imgui.NextColumn() -- 2 ������

    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 506))
    if imgui.HotKey("##2", HotKey_2Menu, tLastKeys, 100) then
       rkeys.changeHotKey(HotKey_2Register, HotKey_2Menu.v)
        --sampAddChatMessage("�� �������: " .. encodeJson(HotKey_2Menu.v), -1)

        mainIni.HotKey.HotKey_2 = encodeJson(HotKey_2Menu.v)
        inicfg.save(mainIni, directIni)
    end
    imgui.PopStyleVar()

    imgui.NextColumn()

    if ChangeHotKey_2 then
        imgui.PushItemWidth(100)
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 203))
            imgui.InputText(u8"##110", HotKey2InputBuffer)
            if isKeyJustPressed(VK_RETURN) then
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ������� ��������.", -1)
                ChangeHotKey_2 = false
                mainIni.HotKey.HotKey_2_saveText = u8:decode(HotKey2InputBuffer.v)
                inicfg.save(mainIni, directIni)
            end
        imgui.PopItemWidth()

        imgui.Separator()
    end

    if not ChangeHotKey_2 then
        HotKey_2_Text = mainIni.HotKey.HotKey_2_saveText
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
                local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()
                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a/2) )
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a/2))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a/2))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 260))
                    imgui.Button(u8(HotKey_2_Text), imgui.ImVec2(100,20))
                imgui.PopStyleColor()
                imgui.PopStyleColor()
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleVar()
    end

    imgui.SameLine()

    if not ChangeHotKey_2 then
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 140))
            if imgui.Button(u8"��������##1", imgui.ImVec2(100,20)) then
                ChangeHotKey_2 = true
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������� ����� �������� � ������� '{FF0000}Enter{FFFFFF}' ��� ����.", -1)
            end
        imgui.PopStyleVar()
    end

    imgui.Separator()

    imgui.NextColumn() -- 3 ������

    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 506))
    if imgui.HotKey("##3", HotKey_3Menu, tLastKeys, 100) then
        rkeys.changeHotKey(HotKey_3Register, HotKey_3Menu.v)
        --sampAddChatMessage("�� �������: " .. encodeJson(HotKey_2Menu.v), -1)

        mainIni.HotKey.HotKey_3 = encodeJson(HotKey_3Menu.v)
        inicfg.save(mainIni, directIni)
    end
    imgui.PopStyleVar()

    imgui.NextColumn()

    if ChangeHotKey_3 then
        imgui.PushItemWidth(100)
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 203))
            imgui.InputText(u8"##111", HotKey3InputBuffer)
            if isKeyJustPressed(VK_RETURN) then
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ������� ��������.", -1)
                ChangeHotKey_3 = false
                mainIni.HotKey.HotKey_3_saveText = u8:decode(HotKey3InputBuffer.v)
                inicfg.save(mainIni, directIni)
            end
        imgui.PopItemWidth()

        imgui.Separator()
    end

    if not ChangeHotKey_3 then
        HotKey_3_Text = mainIni.HotKey.HotKey_3_saveText
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
                local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()
                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a/2) )
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a/2))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a/2))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 260))
                    imgui.Button(u8(HotKey_3_Text), imgui.ImVec2(100,20))
                imgui.PopStyleColor()
                imgui.PopStyleColor()
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleVar()
    end

    imgui.SameLine()

    if not ChangeHotKey_3 then
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 140))
            if imgui.Button(u8"��������##2", imgui.ImVec2(100,20)) then
                ChangeHotKey_3 = true
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������� ����� �������� � ������� '{FF0000}Enter{FFFFFF}' ��� ����.", -1)
            end
        imgui.PopStyleVar()
    end

    imgui.Separator()

    imgui.NextColumn() -- 4 ������

    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 506))
    if imgui.HotKey("##4", HotKey_4Menu, tLastKeys, 100) then
        rkeys.changeHotKey(HotKey_4Register, HotKey_4Menu.v)
        --sampAddChatMessage("�� �������: " .. encodeJson(HotKey_2Menu.v), -1)

        mainIni.HotKey.HotKey_4 = encodeJson(HotKey_4Menu.v)
        inicfg.save(mainIni, directIni)
    end
    imgui.PopStyleVar()

    imgui.NextColumn()

    if ChangeHotKey_4 then
        imgui.PushItemWidth(100)
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 203))
            imgui.InputText(u8"##111", HotKey4InputBuffer)
            if isKeyJustPressed(VK_RETURN) then
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ������� ��������.", -1)
                ChangeHotKey_4 = false
                mainIni.HotKey.HotKey_4_saveText = u8:decode(HotKey4InputBuffer.v)
                inicfg.save(mainIni, directIni)
            end
        imgui.PopItemWidth()

        imgui.Separator()
    end

    if not ChangeHotKey_4 then
        HotKey_4_Text = mainIni.HotKey.HotKey_4_saveText
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
                local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()
                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a/2) )
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a/2))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a/2))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 260))
                    imgui.Button(u8(HotKey_4_Text), imgui.ImVec2(100,20))
                imgui.PopStyleColor()
                imgui.PopStyleColor()
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleVar()
    end

    imgui.SameLine()

    if not ChangeHotKey_4 then
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 140))
            if imgui.Button(u8"��������##3", imgui.ImVec2(100,20)) then
                ChangeHotKey_4 = true
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������� ����� �������� � ������� '{FF0000}Enter{FFFFFF}' ��� ����.", -1)
            end
        imgui.PopStyleVar()
    end

    imgui.Separator()

    imgui.NextColumn() -- 5 ������

    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 506))
    if imgui.HotKey("##5", HotKey_5Menu, tLastKeys, 100) then
        rkeys.changeHotKey(HotKey_5Register, HotKey_5Menu.v)
        --sampAddChatMessage("�� �������: " .. encodeJson(HotKey_2Menu.v), -1)

        mainIni.HotKey.HotKey_5 = encodeJson(HotKey_5Menu.v)
        inicfg.save(mainIni, directIni)
    end
    imgui.PopStyleVar()

    imgui.NextColumn()

    if ChangeHotKey_5 then
        imgui.PushItemWidth(100)
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 203))
            imgui.InputText(u8"##111", HotKey5InputBuffer)
            if isKeyJustPressed(VK_RETURN) then
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ������� ��������.", -1)
                ChangeHotKey_5 = false
                mainIni.HotKey.HotKey_5_saveText = u8:decode(HotKey5InputBuffer.v)
                inicfg.save(mainIni, directIni)
            end
        imgui.PopItemWidth()
    end

    if not ChangeHotKey_5 then
        HotKey_5_Text = mainIni.HotKey.HotKey_5_saveText
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
                local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()
                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a/2) )
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a/2))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a/2))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 260))
                    imgui.Button(u8(HotKey_5_Text), imgui.ImVec2(100,20))
                imgui.PopStyleColor()
                imgui.PopStyleColor()
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleVar()
    end

    imgui.SameLine()

    if not ChangeHotKey_5 then
        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 140))
            if imgui.Button(u8"��������##4", imgui.ImVec2(100,20)) then
                ChangeHotKey_5 = true
                sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������� ����� �������� � ������� '{FF0000}Enter{FFFFFF}' ��� ����.", -1)
            end
        imgui.PopStyleVar()
    end
end

function HotKey_1Func()
    if ToggleButton_HotKey.v then
        if not sampIsChatInputActive() and not DialogOpen then
            sampSendChat(HotKey_1_Text)
        end
    end
end

function HotKey_2Func()
    if ToggleButton_HotKey.v then
        if not sampIsChatInputActive() and not DialogOpen then
            sampSendChat(HotKey_2_Text)
        end
    end
end

function HotKey_3Func()
    if ToggleButton_HotKey.v then
        if not sampIsChatInputActive() and not DialogOpen then
            sampSendChat(HotKey_3_Text)
        end
    end
end

function HotKey_4Func()
    if ToggleButton_HotKey.v then
        if not sampIsChatInputActive() and not DialogOpen then
            sampSendChat(HotKey_4_Text)
        end
    end
end

function HotKey_5Func()
    if ToggleButton_HotKey.v then
        if not sampIsChatInputActive() and not DialogOpen then
            sampSendChat(HotKey_5_Text)
        end
    end
end

function SkinChange()
    if imgui.ToggleButton("##ButtonSaveSkin", ToggleButton_SaveSkin) then
        mainIni.skin.ButtonSaveSkin = ToggleButton_SaveSkin.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}���������� ����� {696969}(?)")
    imgui.Hint(u8"���������� �����", u8"��������� ��������� ���� ��� ��� �������� ��� ������ �����������.", 0)

    if imgui.ToggleButton("##ButtonSkinChangeAll", ToggleButton_SkinChangeAll) then
        mainIni.skin.ButtonSkinChangeAll = ToggleButton_SkinChangeAll.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}���� � ������� {696969}(?)")
    imgui.Hint(u8"���� � �������", u8"�������� ���������� ���� ������� � ��������� �������.\n������� - /setskinall [ID ����� (0-320)] [������ (0-50)]", 0)
end

function TwoPageFunc()
    if imgui.ToggleButton("##ButtonHotKey", ToggleButton_HotKey) then
        mainIni.settings.ButtonHotKey = ToggleButton_HotKey.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}������� ������� {696969}(?)")
    imgui.Hint(u8"������� �������", u8"�������� ������ �� ����������� �������.\n������: ������� 'L' - ��������/�������� ������.", 0)
    imgui.SameLine()
    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
        if imgui.Button(u8"���������##10", imgui.ImVec2(100,19)) then
            ChoiceSettings = true
            AccentSettings = false
            InfoWindowSettings = false
            ClearChatSettings = false
            WeatherTimeSettings = false
            HotKeySettings = true
            SkinSettings = false
        end
    imgui.PopStyleVar()

    if imgui.ToggleButton("##ButtonOpenBoxPandora", ToggleButton_OpenBoxPandora) then
        mainIni.settings.ButtonOpenBoxPandora = ToggleButton_OpenBoxPandora.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}�������� ����� ������� {696969}(?)")
    imgui.Hint(u8"�������� ����� �������", u8"�������������� �������� ����� ������� � ��������� ���������.", 0)
    imgui.SameLine()
    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
        if imgui.Button(u8"���������##26", imgui.ImVec2(100,19)) then
            Shadow_Window_State.v = true
            ShadowWindow_InfoWindow = false
            ShadowWindow_Distance3DTextMine = false
            ShadowWindow_NotesWindow = false
            ShadowWindow_OpenBoxPandora = true
            ShadowWindow_Succesful = false
        end
    imgui.PopStyleVar()

    if imgui.ToggleButton("##ButtonTPMP", ToggleButton_TPMP) then
        mainIni.settings.ButtonTPMP = ToggleButton_TPMP.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}����-�������� �� ����������� {696969}(?)")
    imgui.Hint(u8"����-�������� �� �����������", u8"������������� ����������������� �� ����������� �� �������������.", 0)
    imgui.SameLine()
    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
        imgui.ButtonClickable(false, u8"���������##30", imgui.ImVec2(100,19))
    imgui.PopStyleVar()

    if imgui.ToggleButton("##ButtonSkinChange", ToggleButton_SkinChange) then
        mainIni.settings.ButtonSkinChange = ToggleButton_SkinChange.v
        inicfg.save(mainIni, directIni)
    end
    imgui.SameLine()
    imgui.TextColoredRGB("{FFFFFF}�������� ���� {696969}(?)")
    imgui.Hint(u8"�������� ����", u8"����� ����� �� ������� - /setmyskin [ID ����� (0-320)].\n���������! ��� ������ ����� ��� ID '0' ��� ����� �������� �� ���� (������� ���).", 0)
    imgui.SameLine()
    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
        if imgui.Button(u8"���������##35", imgui.ImVec2(100,19)) then
            ChoiceSettings = true
            AccentSettings = false
            InfoWindowSettings = false
            ClearChatSettings = false
            WeatherTimeSettings = false
            HotKeySettings = false
            SkinSettings = true
        end
    imgui.PopStyleVar()

    imgui.TextColoredRGB("{FFFFFF}ENB Series (�����������) {696969}(?)")
    imgui.Hint(u8"ENB Series", u8"���������� � ���������� �������.\n��������! ���������� ������ �������� ����������!\n\n��� �������� ENB Series:\n1. �������� ����;\n2. ��������� �� ����: " .. enb_path .. u8";\n3. ������� �����: enbeffect.fx, enblocal.ini, enbseries.asi � enbseries.ini.", 0)
    imgui.SameLine()
    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))

        if io.open(enb_search_1, "r") == nil or io.open(enb_search_2, "r") == nil or io.open(enb_search_3, "r") == nil or io.open(enb_search_4, "r") == nil then
            if imgui.Button(u8"����������##1", imgui.ImVec2(100,19)) then
                downloadUrlToFile(enb_url_1, enb_path_1, function(id, status, p1, p2)
                    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ���������� �������� ������.. (25%)!", -1)
                    end
                end)
                downloadUrlToFile(enb_url_2, enb_path_2, function(id, status)
                    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ���������� �������� ������.. (50%)!", -1)
                    end
                end)
                downloadUrlToFile(enb_url_3, enb_path_3, function(id, status)
                    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ���������� �������� ������.. (75%)!", -1)
                    end
                end)
                downloadUrlToFile(enb_url_4, enb_path_4, function(id, status)
                    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ����������� '{FF0000}ENB Series{FFFFFF}' ������� �����������!", -1)
                        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ��� ���������� ��������� ������������� ����!", -1)
                    end
                end)
            end
        else
            imgui.ButtonClickable(false, u8"�����������", imgui.ImVec2(100,19))
        end
    imgui.PopStyleVar()

    imgui.TextColoredRGB("{FFFFFF}�������� ��� {696969}(?)")
    imgui.Hint(u8"�������� ���", u8"��������� ������� ��� ��������� �� ����.", 0)
    imgui.SameLine()
    imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 210))
        if imgui.Button(u8"��������", imgui.ImVec2(100,19)) then
            ClearChat()
        end
    imgui.PopStyleVar()
end

function sampev.onShowTextDraw(id, data, textdrawId)
    if ToggleButton_OpenBoxPandora.v and active then
        lua_thread.create(function()
            if data.modelId == 19918 then
                wait(111)
                sampSendClickTextdraw(id)
                use = true
            end
            if data.text == 'USE' or data.text == '�C�O���O�A��' and use then
                sampSendClickTextdraw(2302)
                use = false
                close = true
            end
            if close then
                wait(111)
                sampSendClickTextdraw(2108)
                wait(111)
                sampCloseCurrentDialogWithButton(1)
                wait(111)
                sampSendClickTextdraw(2108)
                close = false
                active = false
            end
        end)
    end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
end

function roulette()
    while true do 
        if ToggleButton_OpenBoxPandora.v then
            active = true
            sampSendChat("/invent")
            wait(WaitPandora*60000)
        end
    wait(0)
    end
end

function ClearChat()
    memory.fill(sampGetChatInfoPtr() + 306, 0x0, 25200)
    memory.write(sampGetChatInfoPtr() + 306, 25562, 4, 0x0)
    memory.write(sampGetChatInfoPtr() + 0x63DA, 1, 1)
end

function changeSkin(id, skinId)
    bs = raknetNewBitStream()
    if id == -1 then _, id = sampGetPlayerIdByCharHandle(PLAYER_PED) end
    raknetBitStreamWriteInt32(bs, id)
    raknetBitStreamWriteInt32(bs, skinId)
    raknetEmulRpcReceiveBitStream(153, bs)
    raknetDeleteBitStream(bs)
end

---------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

--[[function BinderFunction()
    imgui.SetCursorPosX((imgui.GetWindowWidth() / 2.2))
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
    imgui.PushFont(fontsizesettings)
        imgui.TextColoredRGB("{FF0000}������")
    imgui.PopFont()
    imgui.SetCursorPosY((imgui.GetWindowWidth() - 640))
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 685))

--------------------------------------------------------------------------------------------
    imgui.BeginChild("Binder1", imgui.ImVec2(692,450), true)

        imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00,1.00,1.00,1.00))
            imgui.SetCursorPosX(16)
            imgui.SetCursorPosY(6)
            imgui.PushFont(fa_font_binder)
                imgui.Text(fa.ICON_FA_POWER_OFF)
            imgui.PopFont()
        imgui.PopStyleColor()

        imgui.SameLine()

        imgui.PushFont(fontsizebinder)
            imgui.SetCursorPosX(60)
            imgui.TextColoredRGB("{FFFFFF}#")
        imgui.PopFont()

        imgui.SameLine()

        imgui.PushFont(fontsizetextbinder)
            imgui.SetCursorPosX(100)
            imgui.TextColoredRGB("{FFFFFF}���������")
        imgui.PopFont()

        imgui.SameLine()

        imgui.PushFont(fontsizetextbinder)
            imgui.SetCursorPosX(400)
            imgui.TextColoredRGB("{FFFFFF}��������")
        imgui.PopFont()

        -- �������
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 657))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##1", arrSelectable[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable[1] = not arrSelectable[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 631))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##2", arrSelectable1[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable1[1] = not arrSelectable1[1]
                        arrSelectable[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                    imgui.PopStyleColor()
                imgui.PopStyleColor()
            imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 605))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##3", arrSelectable2[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable2[1] = not arrSelectable2[1]
                        arrSelectable1[1] = false
                        arrSelectable[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 579))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##4", arrSelectable3[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable3[1] = not arrSelectable3[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 553))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##5", arrSelectable4[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable4[1] = not arrSelectable4[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 527))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##6", arrSelectable5[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable5[1] = not arrSelectable5[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 501))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##7", arrSelectable6[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable6[1] = not arrSelectable6[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 475))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##8", arrSelectable7[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable7[1] = not arrSelectable7[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 449))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##9", arrSelectable8[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable8[1] = not arrSelectable8[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 423))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##10", arrSelectable9[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable9[1] = not arrSelectable9[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 397))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##11", arrSelectable10[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable10[1] = not arrSelectable10[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 371))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##12", arrSelectable11[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable11[1] = not arrSelectable11[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 345))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##13", arrSelectable12[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable12[1] = not arrSelectable12[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 319))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##14", arrSelectable13[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable13[1] = not arrSelectable13[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable[1] = false
                        arrSelectable14[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 293))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##15", arrSelectable14[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable14[1] = not arrSelectable14[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable[1] = false
                        arrSelectable15[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 640))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 267))
        imgui.PushStyleColor(imgui.Col.HeaderHovered, imgui.ImVec4(0.66,0.66,0.66,0.20))
            imgui.PushStyleColor(imgui.Col.HeaderActive, imgui.ImVec4(0.66,0.66,0.66,0.30))
                imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(0.66,0.66,0.66,0.25))
                    if imgui.Selectable("##16", arrSelectable15[1], 0, imgui.ImVec2(638,21)) then
                        arrSelectable15[1] = not arrSelectable15[1]
                        arrSelectable1[1] = false
                        arrSelectable2[1] = false
                        arrSelectable3[1] = false
                        arrSelectable4[1] = false
                        arrSelectable5[1] = false
                        arrSelectable6[1] = false
                        arrSelectable7[1] = false
                        arrSelectable8[1] = false
                        arrSelectable9[1] = false
                        arrSelectable10[1] = false
                        arrSelectable11[1] = false
                        arrSelectable12[1] = false
                        arrSelectable13[1] = false
                        arrSelectable14[1] = false
                        arrSelectable[1] = false
                    end
                imgui.PopStyleColor()
            imgui.PopStyleColor()
        imgui.PopStyleColor()
        ----

        -- ������
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 660))
        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind1", ToggleButton_Bind1)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind2", ToggleButton_Bind2)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind3", ToggleButton_Bind3)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind4", ToggleButton_Bind4)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind5", ToggleButton_Bind5)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind6", ToggleButton_Bind6)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind7", ToggleButton_Bind7)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind8", ToggleButton_Bind8)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind9", ToggleButton_Bind9)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind10", ToggleButton_Bind10)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind11", ToggleButton_Bind11)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind12", ToggleButton_Bind12)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind13", ToggleButton_Bind13)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind14", ToggleButton_Bind14)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind15", ToggleButton_Bind15)

        imgui.Separator()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 683))
        imgui.ToggleButton("##ButtonBind16", ToggleButton_Bind16)
        ----

        -- ������
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 654))
        imgui.SetCursorPosX(60)
        imgui.TextColoredRGB("{FFFFFF}1")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 628))
        imgui.SetCursorPosX(60)
        imgui.TextColoredRGB("{FFFFFF}2")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 602))
        imgui.SetCursorPosX(60)
        imgui.TextColoredRGB("{FFFFFF}3")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 576))
        imgui.SetCursorPosX(60)
        imgui.TextColoredRGB("{FFFFFF}4")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 550))
        imgui.SetCursorPosX(60)
        imgui.TextColoredRGB("{FFFFFF}5")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 524))
        imgui.SetCursorPosX(60)
        imgui.TextColoredRGB("{FFFFFF}6")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 498))
        imgui.SetCursorPosX(60)
        imgui.TextColoredRGB("{FFFFFF}7")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 472))
        imgui.SetCursorPosX(60)
        imgui.TextColoredRGB("{FFFFFF}8")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 446))
        imgui.SetCursorPosX(60)
        imgui.TextColoredRGB("{FFFFFF}9")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 420))
        imgui.SetCursorPosX(57)
        imgui.TextColoredRGB("{FFFFFF}10")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 394))
        imgui.SetCursorPosX(57)
        imgui.TextColoredRGB("{FFFFFF}11")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 368))
        imgui.SetCursorPosX(57)
        imgui.TextColoredRGB("{FFFFFF}12")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 342))
        imgui.SetCursorPosX(57)
        imgui.TextColoredRGB("{FFFFFF}13")

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 316))
        imgui.SetCursorPosX(57)
        imgui.TextColoredRGB("{FFFFFF}14")

        imgui.SetCursorPosX(57)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 290))
        imgui.TextColoredRGB("{FFFFFF}15")

        imgui.SetCursorPosX(57)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 264))
        imgui.TextColoredRGB("{FFFFFF}16")
        ----

        -- ���������
        if CommandBind1.v == "" then
            imgui.SetCursorPosX(120)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 654))
            imgui.TextColoredRGB("{696969}�����")
        else
            imgui.SetCursorPosX(85)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 654))
            imgui.TextColoredRGB("{696969}/" .. u8:decode(CommandBind1.v))
        end

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 628))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 602))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 576))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 550))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 524))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 498))
        imgui.TextColoredRGB("{696969}�����")
        
        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 472))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 446))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 420))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 394))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 368))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 342))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 316))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 290))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(120)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 264))
        imgui.TextColoredRGB("{696969}�����")
        ----

        -- ��������
        if DescriptionBind1.v == "" then
            imgui.SetCursorPosX(420)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 654))
            imgui.TextColoredRGB("{696969}�����")
        else
            imgui.SetCursorPosX(205)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 654))
            imgui.TextColoredRGB("{696969}" .. u8:decode(DescriptionBind1.v))
        end

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 628))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 602))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 576))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 550))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 524))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 498))
        imgui.TextColoredRGB("{696969}�����")
        
        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 472))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 446))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 420))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 394))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 368))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 342))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 316))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 290))
        imgui.TextColoredRGB("{696969}�����")

        imgui.SetCursorPosX(420)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 264))
        imgui.TextColoredRGB("{696969}�����")
        ----

        imgui.SetCursorPosY(2)
        imgui.SetCursorPosX(50)
        imgui.VerticalSeparator()

        imgui.SetCursorPosY(2)
        imgui.SetCursorPosX(80)
        imgui.VerticalSeparator()

        imgui.SetCursorPosY(2)
        imgui.SetCursorPosX(200)
        imgui.VerticalSeparator()

    imgui.EndChild()

    imgui.SetCursorPosY((imgui.GetWindowWidth() - 240))
    imgui.BeginChild("Binder2", imgui.ImVec2(692,35), true)
        if arrSelectable[1] or arrSelectable1[1] or arrSelectable2[1] or arrSelectable3[1] or arrSelectable4[1] or arrSelectable5[1] or arrSelectable6[1] or arrSelectable7[1] or arrSelectable8[1] or arrSelectable9[1] or arrSelectable10[1] or arrSelectable11[1] or arrSelectable12[1] or arrSelectable13[1] or arrSelectable14[1] or arrSelectable15[1] then
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                if imgui.ButtonClickable(true, fa.ICON_FA_EDIT .. u8" �������������", imgui.ImVec2(224, 27)) then
                    EditBind = true
                end
            imgui.PopStyleVar()

            imgui.SameLine()

            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.ButtonClickable(true, fa.ICON_FA_EYE .. u8" ������������", imgui.ImVec2(225, 27)) -- ����� ����� ������ ���������� � ini
            imgui.PopStyleVar()

            imgui.SameLine()

            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.ButtonClickable(true, fa.ICON_FA_TRASH_ALT .. u8" ��������", imgui.ImVec2(225, 27)) -- ����� ����� ������ ���������� � ini
            imgui.PopStyleVar()
        else
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.ButtonClickable(false, fa.ICON_FA_EDIT .. u8" �������������", imgui.ImVec2(224, 27))
            imgui.PopStyleVar()

            imgui.SameLine()

            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.ButtonClickable(false, fa.ICON_FA_EYE .. u8" ������������", imgui.ImVec2(225, 27))
            imgui.PopStyleVar()

            imgui.SameLine()

            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.ButtonClickable(false, fa.ICON_FA_TRASH_ALT .. u8" ��������", imgui.ImVec2(225, 27))
            imgui.PopStyleVar()
        end
    imgui.EndChild()
end

function EditBindDraw()
    if arrSelectable[1] then -- ������ 1 ����
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 390))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
        imgui.PushFont(fontsizesettings)
            imgui.TextColoredRGB("{FF0000}���� #1")
        imgui.PopFont()

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 640))
        imgui.BeginChild("BindEdit1", imgui.ImVec2(692,435), true)

            if SelectedCommand1 or SelectedKey1 then
                if SelectedCommand1 then
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 470))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 682))
                    imgui.TextColoredRGB("{FFFFFF}������� �������: /")
    
                    imgui.SameLine()
    
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 685))
                    imgui.PushItemWidth(120)
                        imgui.InputText("##InputText111111", CommandBind1)
                    imgui.PopItemWidth()

                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 570))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 658))
                    imgui.TextColoredRGB("{FFFFFF}������� ��������:")

                    imgui.SameLine()

                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 660))
                    imgui.PushItemWidth(310)
                        imgui.InputText("##InputText112111", DescriptionBind1)
                    imgui.PopItemWidth()
                end
    
                if SelectedKey1 then
    
                end
            else
                imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 600))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 630))
                    if not SelectedKey1 and ClosedButtons then
                        if imgui.Button(fa.ICON_FA_TERMINAL .. u8"  ��������� �� �������", imgui.ImVec2(180,30)) then
                            SelectedCommand1 = true
                            ClosedButtons = false

                            mainIni.bindersettings.SelectedCommand1 = SelectedCommand1
                            inicfg.save(mainIni, directIni)
                        end
                    end
                imgui.PopStyleVar()

                imgui.SameLine()

                imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 280))
                    --imgui.SetCursorPosY((imgui.GetWindowWidth() - 500))
                    if not SelectedCommand11 and ClosedButtons then
                        if imgui.Button(fa.ICON_FA_KEYBOARD .. u8"  ��������� �� �������", imgui.ImVec2(180,30)) then
                            SelectedKey1 = true
                            ClosedButtons = false

                            mainIni.bindersettings.SelectedKey1 = SelectedKey1
                            inicfg.save(mainIni, directIni)
                        end
                    end
                imgui.PopStyleVar()
            end

            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 500))
                imgui.SetCursorPosY((imgui.GetWindowWidth() - 556))
                if imgui.Button(fa.ICON_FA_LONG_ARROW_ALT_LEFT .. u8" �����", imgui.ImVec2(150,20)) then
                    EditBind = false
                    BinderSettings = true
                    OffArrSelectable()
                end
            imgui.PopStyleVar()

            imgui.SameLine()

            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 346))
                if imgui.Button(fa.ICON_FA_SAVE .. u8" ���������", imgui.ImVec2(150,20)) then
                    if not SaveButtonOn then
                        sampAddChatMessage("{FF0000}[Error]{FFFFFF}: ��������� �������..", -1)
                    else
                        Shadow_Window_State.v = true
                        ShadowWindow_InfoWindow = false
                        ShadowWindow_OpenBoxPandora = false
                        ShadowWindow_Succesful = true
    
                        InputTextBind1.v = string.gsub(InputTextBind1.v, "\n", "||")
                        mainIni.bindersettings.TextBind1 = u8:decode(InputTextBind1.v)
                        inicfg.save(mainIni, directIni)

                        mainIni.bindersettings.CommandBind1 = u8:decode(CommandBind1.v)
                        inicfg.save(mainIni, directIni)

                        mainIni.bindersettings.DescriptionBind1 = u8:decode(DescriptionBind1.v)
                        inicfg.save(mainIni, directIni)
                    end
                end
            imgui.PopStyleVar()

            imgui.SetCursorPosY((imgui.GetWindowWidth() - 530))
            imgui.Separator()

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 440))
            imgui.TextColoredRGB("{FFFFFF}�������������� �����������")

            imgui.SetCursorPosY((imgui.GetWindowWidth() - 507))
            InputTextBind1.v = string.gsub(InputTextBind1.v, '||', '\n')
            imgui.InputTextMultiline("##EditBind11111", InputTextBind1, imgui.ImVec2(683,245))

        imgui.EndChild()
    end

    if arrSelectable1[1] then -- ������ 2 ����
        imgui.SetCursorPosX((imgui.GetWindowWidth() / 2.3))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
        imgui.PushFont(fontsizesettings)
            imgui.TextColoredRGB("{FF0000}���� #2")
        imgui.PopFont()
    end

    if arrSelectable2[1] then -- ������ 3 ����
        imgui.SetCursorPosX((imgui.GetWindowWidth() / 2.3))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
        imgui.PushFont(fontsizesettings)
            imgui.TextColoredRGB("{FF0000}���� #3")
        imgui.PopFont()
    end

    if arrSelectable3[1] then -- ������ 4 ����
        imgui.SetCursorPosX((imgui.GetWindowWidth() / 2.3))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
        imgui.PushFont(fontsizesettings)
            imgui.TextColoredRGB("{FF0000}���� #4")
        imgui.PopFont()
    end

    if arrSelectable4[1] then -- ������ 5 ����
        imgui.SetCursorPosX((imgui.GetWindowWidth() / 2.3))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
        imgui.PushFont(fontsizesettings)
            imgui.TextColoredRGB("{FF0000}���� #5")
        imgui.PopFont()
    end

    if arrSelectable5[1] then -- ������ 6 ����
        imgui.SetCursorPosX((imgui.GetWindowWidth() / 2.3))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
        imgui.PushFont(fontsizesettings)
            imgui.TextColoredRGB("{FF0000}���� #6")
        imgui.PopFont()
    end

    if arrSelectable6[1] then -- ������ 7 ����
        imgui.SetCursorPosX((imgui.GetWindowWidth() / 2.3))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
        imgui.PushFont(fontsizesettings)
            imgui.TextColoredRGB("{FF0000}���� #7")
        imgui.PopFont()
    end

    if arrSelectable7[1] then -- ������ 8 ����
        
    end

    if arrSelectable8[1] then -- ������ 9 ����
        
    end

    if arrSelectable9[1] then -- ������ 10 ����
        
    end

    if arrSelectable10[1] then -- ������ 11 ����

    end

    if arrSelectable11[1] then -- ������ 12 ����
        
    end

    if arrSelectable12[1] then -- ������ 13 ����
        
    end

    if arrSelectable13[1] then -- ������ 14 ����
        
    end

    if arrSelectable14[1] then -- ������ 15 ����
        
    end

    if arrSelectable15[1] then -- ������ 16 ����
        
    end
end

function OffArrSelectable()
    arrSelectable1[1] = false
    arrSelectable2[1] = false
    arrSelectable3[1] = false
    arrSelectable4[1] = false
    arrSelectable5[1] = false
    arrSelectable6[1] = false
    arrSelectable7[1] = false
    arrSelectable8[1] = false
    arrSelectable9[1] = false
    arrSelectable10[1] = false
    arrSelectable11[1] = false
    arrSelectable12[1] = false
    arrSelectable[1] = false
    arrSelectable14[1] = false
    arrSelectable15[1] = false
end
]]
function imgui.CInputText(text, buffer, sizeX)
    local sizeX = sizeX or 100
    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1, 1, 1, 0))
    imgui.PushItemWidth(sizeX)
    local c = imgui.GetCursorPos()
    local ret = imgui.InputText(text, buffer)
    imgui.PopItemWidth()
    imgui.PopStyleColor()
    imgui.SameLine(c.x + sizeX / 2 - imgui.CalcTextSize(buffer.v).x / 2)
    imgui.Text(buffer.v)
    return ret
end

--[[function WaitSuccesful()
    lua_thread.create(function()
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 405))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 500))
        imgui.Spinner("�������2", 40, 10, 0x962121FF)

        wait(2000)

        SuccessImage = true
    end)
end]]

function DeleteWaitSuccessful()
    lua_thread.create(function()
        wait(1500)
        SaveButtonOn = false

        Shadow_Window_State.v = false
        ShadowWindow_InfoWindow = false
        ShadowWindow_Distance3DTextMine = false
        ShadowWindow_NotesWindow = false
        ShadowWindow_OpenBoxPandora = false
        ShadowWindow_Succesful = false

        BlockButtonAll = false

        wait(1500)
        SaveButtonOn = true
    end)
end

function LoadIni()
    ToggleButton_CalcChat.v = mainIni.settings.ButtonCalc
    ToggleButton_HelpChat.v = mainIni.settings.ButtonHelpChat
    ToggleButton_Accent.v = mainIni.settings.ButtonAccent
    selectedAccent = mainIni.accent.Accent
    ToggleButton_InfoWindow.v = mainIni.settings.ButtonInfoWindow
    ToggleButton_HP.v = mainIni.infowindow.ButtonHP
    ToggleButton_Armor.v = mainIni.infowindow.ButtonArmor
    ToggleButton_FPS.v = mainIni.infowindow.ButtonFPS
    ToggleButton_Ping.v = mainIni.infowindow.ButtonPing
    ToggleButton_City.v = mainIni.infowindow.ButtonCity
    ToggleButton_District.v = mainIni.infowindow.ButtonDistrict
    ToggleButton_HPAuto.v = mainIni.infowindow.ButtonHPAuto
    ToggleButton_SessionOnline.v = mainIni.infowindow.ButtonSessionOnline
    ToggleButton_Time.v = mainIni.infowindow.ButtonTime
    ToggleButton_Weather.v = mainIni.settings.ButtonWeather
    ToggleButton_ClearChat.v = mainIni.settings.ButtonClearChat
    ToggleButton_AD.v = mainIni.clearchat.ButtonAD
    ToggleButton_ChatAdministration.v = mainIni.clearchat.ButtonChatAdministration
    ToggleButton_ChatGOV.v = mainIni.clearchat.ButtonChatGOV
    ToggleButton_NEWS.v = mainIni.clearchat.ButtonNEWS
    ToggleButton_Events.v = mainIni.clearchat.ButtonEvents
    ToggleButton_Exit.v = mainIni.clearchat.ButtonExit
    ToggleButton_ServerInfo.v = mainIni.clearchat.ButtonServerInfo
    ToggleButton_HotKey.v = mainIni.settings.ButtonHotKey
    ToggleButton_OpenBoxPandora.v = mainIni.settings.ButtonOpenBoxPandora
    WaitPandora = mainIni.pandora.PauseOpenPandora
    ToggleButton_TPMP.v = mainIni.settings.ButtonTPMP
    HotKey_1_Text = mainIni.HotKey.HotKey_1_saveText
    HotKey_2_Text = mainIni.HotKey.HotKey_2_saveText
    HotKey_3_Text = mainIni.HotKey.HotKey_3_saveText
    HotKey_4_Text = mainIni.HotKey.HotKey_4_saveText
    HotKey_5_Text = mainIni.HotKey.HotKey_5_saveText
    ToggleButton_SkinChange.v = mainIni.settings.ButtonSkinChange
    ToggleButton_SaveSkin.v = mainIni.skin.ButtonSaveSkin
    SkinIDLoad = mainIni.skin.SaveSkin
    ToggleButton_SkinChangeAll.v = mainIni.skin.ButtonSkinChangeAll
    SuccessPayDays = mainIni.PayDays.SuccessPayDays
    FailedPayDays = mainIni.PayDays.FailedPayDays
    CheckBoxSend.v = mainIni.checkboxnotes.CheckBoxSend
    CheckBoxCopy.v = mainIni.checkboxnotes.CheckBoxCopy
    CheckBoxShow.v = mainIni.checkboxnotes.CheckBoxShow
    CheckBoxShow3DText.v = mainIni.minesettings.CheckBoxShow3DText
    CheckBoxNotice.v = mainIni.minesettings.CheckBoxNotice
    CheckBoxMarker.v = mainIni.minesettings.CheckBoxMarker
    CheckBoxLine.v = mainIni.minesettings.CheckBoxLine
    CheckBoxAdvance.v = mainIni.minesettings.CheckBoxAdvance
    CheckBoxShow3DTextTime.v = mainIni.minesettings.CheckBoxShow3DTextTime

    StoneDay = mainIni.minesettings.StoneDay
    MetalDay = mainIni.minesettings.MetalDay
    SilverDay = mainIni.minesettings.SilverDay
    GoldDay = mainIni.minesettings.GoldDay
end

function ScriptsFunction()
    imgui.BeginChild("Scripts", imgui.ImVec2(692,492), true)
        imgui.PushFont(fontsizesettings)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
            imgui.CenterTextColoredRGB("{FF0000}������� {696969}(?)")
        imgui.PopFont()
            imgui.Hint(u8"�������",u8"����� ������� ��������� ������ �� ��������, ������� �� ���� ����� ������� ���� (LMB).\n��� �������, ������� ��������� ��� \"LOCK\" - ��������� � ����������, ���� �������� ����������.", 0)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 645))
            imgui.Separator()
            Script1Start = Script1
            Script2Start = Script2
            Script3Start = Script3
            Script4Start = Script4
            Script5Start = Script5

            --imgui.Image(Script1Start, imgui.ImVec2(132.73,436))
            if imgui.ImageButton(Script1Start, imgui.ImVec2(128.7, 432), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), 2) then
                BasicSettings = false
                ScriptsSettings = false
                MyAnalitics = false
                Notes = false
                ScriptMineSettings = true
            end
            imgui.SameLine()
            if imgui.ImageButton(Script2Start, imgui.ImVec2(128.7, 432), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), 2) then
                Error("��������� ���� ������ ����������.")
            end
            imgui.SameLine()
            if imgui.ImageButton(Script3Start, imgui.ImVec2(128.7, 432), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), 2) then
                Error("��������� ���� ������ ����������.")
            end
            imgui.SameLine()
            if imgui.ImageButton(Script4Start, imgui.ImVec2(128.7, 432), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), 2) then
                Error("��������� ���� ������ ����������.")
            end
            imgui.SameLine()
            if imgui.ImageButton(Script5Start, imgui.ImVec2(128.7, 432), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), 2) then
                Error("��������� ���� ������ ����������.")
            end
            imgui.SameLine()
    imgui.EndChild()
end

function NotesFunction()
    imgui.BeginChild("Notes", imgui.ImVec2(692,492), true)
        imgui.PushFont(fontsizesettings)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
            imgui.CenterTextColoredRGB("{FF0000}�������")
        imgui.PopFont()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 510))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 640))
        imgui.BeginChild("Notes2", imgui.ImVec2(320,150), true)

            imgui.Checkbox("##CheckBox1", CheckBoxShow)
            mainIni.checkboxnotes.CheckBoxShow = CheckBoxShow.v
            inicfg.save(mainIni, directIni)
            imgui.SameLine()
            imgui.TextColoredRGB("{FFFFFF} �������� �� ����� {696969}(?)")
            imgui.Hint(u8"�������� �� �����",u8"������� ��� ���� ������� � ��������� ������� ������ � ���� ������� (�������).", 0)
            imgui.SameLine()

            if not CheckBoxShow.v then
                imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 138))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 315))
                    imgui.ButtonClickable(false, u8"������������", imgui.ImVec2(120,20))
                imgui.PopStyleVar()
            else
                imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - 138))
                    imgui.SetCursorPosY((imgui.GetWindowWidth() - 315))
                    if imgui.ButtonClickable(true, u8"������������", imgui.ImVec2(120,20)) then
                        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ������� � ������� {FF0000}Enter{FFFFFF} ����� ��������� �.", -1)
                        changePositionNotesWindow = true
                        settings_window_state_one.v = false
                        settings_window_state_two.v = false
                    end
                imgui.PopStyleVar()
            end

            imgui.Checkbox("##CheckBox2", CheckBoxCopy)
            mainIni.checkboxnotes.CheckBoxCopy = CheckBoxCopy.v
            inicfg.save(mainIni, directIni)
            imgui.SameLine()
            imgui.TextColoredRGB("{FFFFFF} �������� ������ '����������' � ������� {696969}(?)")
            imgui.Hint(u8"������ '����������'",u8"��������� � ������ (�������) ������ ����������� ��� ������ �������.", 0)

            imgui.Checkbox("##CheckBox3", CheckBoxSend)
            mainIni.checkboxnotes.CheckBoxSend = CheckBoxSend.v
            imgui.SameLine()
            imgui.TextColoredRGB("{FFFFFF} �������� ������ '���������' � ������� {696969}(?)")
            imgui.Hint(u8"������ '���������'",u8"��������� � ������ (�������) ������ �������� � ��� ��� ������ �������.", 0)

            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 255))
                imgui.SetCursorPosY((imgui.GetWindowWidth() - 233))
                if imgui.ButtonClickable(true, u8"�������� ������ �������", imgui.ImVec2(200,23)) then
                    Shadow_Window_State.v = true
                    ShadowWindow_InfoWindow = false
                    ShadowWindow_Distance3DTextMine = false
                    ShadowWindow_OpenBoxPandora = false
                    ShadowWindow_Succesful = false
                    ShadowWindow_NotesWindow = true
                end
            imgui.PopStyleVar()

            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 312))
                imgui.SetCursorPosY((imgui.GetWindowWidth() - 195))
                if imgui.Button(fa.ICON_FA_TRASH_ALT .. u8" ��������", imgui.ImVec2(150,20)) then
                    if not SaveButtonOn then
                        Error("��������� �������..")
                    else
                        InputTextNotes.v = ""
                        mainIni.notes.notestext = InputTextNotes.v
                        inicfg.save(mainIni, directIni)

                        Shadow_Window_State.v = true
                        ShadowWindow_InfoWindow = false
                        ShadowWindow_Distance3DTextMine = false
                        ShadowWindow_NotesWindow = false
                        ShadowWindow_OpenBoxPandora = false
                        ShadowWindow_Succesful = true
                    end
                end
            imgui.PopStyleVar()

            imgui.SameLine()

            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 158))
                if imgui.Button(fa.ICON_FA_SAVE .. u8" ���������", imgui.ImVec2(150,20)) then
                    if not SaveButtonOn then
                        Error("��������� �������..")
                    else
                        InputTextNotes.v = string.gsub(InputTextNotes.v, "\n", "||")
                        mainIni.notes.notestext = u8:decode(InputTextNotes.v)
                        inicfg.save(mainIni, directIni)

                        Shadow_Window_State.v = true
                        ShadowWindow_InfoWindow = false
                        ShadowWindow_Distance3DTextMine = false
                        ShadowWindow_NotesWindow = false
                        ShadowWindow_OpenBoxPandora = false
                        ShadowWindow_Succesful = true
                    end
                end
            imgui.PopStyleVar()
        imgui.EndChild()

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 484))
        imgui.BeginChild("Notes1", imgui.ImVec2(684,280), true)
            imgui.CenterTextColoredRGB("{FFFFFF}�������������� ������� {696969}(?)")
            imgui.Hint(u8"���� ��������������",u8"����� �������� ������� ���� �� ����� - ������� 'ENTER'", 0)

            InputTextNotes.v = string.gsub(InputTextNotes.v, '||', '\n')
            imgui.InputTextMultiline("##EditNotes", InputTextNotes, imgui.ImVec2(675,253))

        imgui.EndChild()
    imgui.EndChild()
end

function MyAnaliticsFunction()
    imgui.BeginChild("Analitics", imgui.ImVec2(692,492), true)
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 420))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
        imgui.PushFont(fontsizesettings)
            imgui.CenterTextColoredRGB("{FF0000}��� ����������")
        imgui.PopFont()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 675))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 640))
        imgui.BeginChild("AnaliticsIngo", imgui.ImVec2(660, 132), true)
            local _, pID = sampGetPlayerIdByCharHandle(PLAYER_PED)
            editname = sampGetPlayerNickname(pID)
            Score = sampGetPlayerScore(pID)

            namesuccess, surnamesuccess = editname:match("(.*) (.*)")

            name = string.format("{FFFFFF}���: %s.", namesuccess)
            imgui.CenterTextColoredRGB(name)

            surname = string.format("{FFFFFF}�������: %s.", surnamesuccess)
            imgui.CenterTextColoredRGB(surname)

            if id == 111 or id == 222 or id == 333 or id == 444 or id == 555 or id == 666 or id == 777 or id == 888 or id == 999 or id == 0 then
                id = string.format("{FFFFFF}ID: %d ({C0C0C0}�������{ffffff}).", pID)
            else
                id = string.format("{FFFFFF}ID: %d.", pID)
            end
            imgui.CenterTextColoredRGB(id)

            oldstate = string.format("{FFFFFF}�������: %d.", Score)
            imgui.CenterTextColoredRGB(oldstate)

            LastConnectTime = mainIni.connecttime.LastConnectTime
            lasttimeenter = string.format("{FFFFFF}��������� ����� � ����: %s � %s.", LastConnectData, LastConnectTime)
            imgui.CenterTextColoredRGB(lasttimeenter)

            if ipadress == nil then
                imgui.CenterTextColoredRGB("{FFFFFF}��� ������� {FF0000}IP{FFFFFF}-�����: {ff0000}������{FFFFFF}.")
            else
                ipadress1 = string.format("{FFFFFF}��� ������� {FF0000}IP{FFFFFF}-�����: %s ({C0C0C0}%s{FFFFFF}).", ipadress, state)
                imgui.CenterTextColoredRGB(ipadress1)
            end
            if SuccessPayDays == 0 then numberName = "����" end
            if SuccessPayDays == 1 then numberName = "�����" end
            if SuccessPayDays == 2 then numberName = "�����" end
            if SuccessPayDays == 3 then numberName = "�����" end
            if SuccessPayDays == 4 then numberName = "�����" end
            if SuccessPayDays == 5 then numberName = "����" end
            if SuccessPayDays > 5 then numberName = "����" end

            PayDays = string.format("{FFFFFF}�� ������� ������� {FF0000}PayDay{FFFFFF}`��: {FF0000}%d{FFFFFF} %s, �� ��� {FF0000}%d{FFFFFF} �� ��������(-�).", SuccessPayDays, numberName, FailedPayDays)
            imgui.CenterTextColoredRGB(PayDays)
        imgui.EndChild()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 630))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 473))
        imgui.BeginChild("AnaliticsTime", imgui.ImVec2(250, 240), true)
            imgui.PushFont(fontsizeauthor)
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 180))
                imgui.CenterTextColoredRGB("{FFFFFF}" .. nowTime)
            imgui.PopFont()

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 190))
            imgui.CenterTextColoredRGB("{FFFFFF}" .. getStrDate(os.time()))

            imgui.SetCursorPosY((imgui.GetWindowWidth() - 190))
            imgui.Separator()

            imgui.SetCursorPosY((imgui.GetWindowWidth() - 180))
            imgui.CenterTextColoredRGB("{FFFFFF}������ �� ������ ({C0C0C0}�����{FFFFFF}): " .. get_clock(sessionFull.v))
            imgui.CenterTextColoredRGB("{FFFFFF}������ �� ������ ({C0C0C0}������{FFFFFF}): " .. get_clock(sessionOnline.v))
            imgui.CenterTextColoredRGB("{FFFFFF}AFK �� ������: " .. get_clock(sessionAfk.v))
            imgui.CenterTextColoredRGB("{FFFFFF}������ �� ���� ({C0C0C0}�����{FFFFFF}): " .. get_clock(mainIni.onDay.full))
            imgui.CenterTextColoredRGB("{FFFFFF}������ �� ���� ({C0C0C0}������{FFFFFF}): " .. get_clock(mainIni.onDay.online))
            imgui.CenterTextColoredRGB("{FFFFFF}AFK �� ����: " .. get_clock(mainIni.onDay.afk))
            imgui.CenterTextColoredRGB("{FFFFFF}������ �� ������ ({C0C0C0}�����{FFFFFF}): " .. get_clock(mainIni.onWeek.full))
            imgui.CenterTextColoredRGB("{FFFFFF}������ �� ������ ({C0C0C0}������{FFFFFF}): " .. get_clock(mainIni.onWeek.online))
            imgui.CenterTextColoredRGB("{FFFFFF}AFK �� ������: " .. get_clock(mainIni.onWeek.afk))

        imgui.EndChild()

        imgui.SameLine()

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 310))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 473))
        imgui.BeginChild("AnaliticsTimeWeek", imgui.ImVec2(250, 240), true)
            imgui.PushFont(fontsizeauthor)
                imgui.SetCursorPosX((imgui.GetWindowWidth() - 180))
                imgui.CenterTextColoredRGB("{FFFFFF}������ �� ������")
            imgui.PopFont()

            imgui.SetCursorPosX((imgui.GetWindowWidth() - 190))
            imgui.CenterTextColoredRGB("{FFFFFF}����� �� ������: " .. get_clock(mainIni.onWeek.full))

            imgui.SetCursorPosY((imgui.GetWindowWidth() - 190))
            imgui.Separator()

            imgui.SetCursorPosY((imgui.GetWindowWidth() - 165))
            for day = 1, 6 do -- �� -> ��
                imgui.TextColoredRGB("{FFFFFF}" .. (tWeekdays[day])); imgui.SameLine(192)
                imgui.TextColoredRGB("{FFFFFF}" .. get_clock(mainIni.myWeekOnline[day]))
            end 
            --> ��
            imgui.TextColoredRGB("{FFFFFF}" .. (tWeekdays[0])); imgui.SameLine(192)
            imgui.TextColoredRGB("{FFFFFF}" .. get_clock(mainIni.myWeekOnline[0]))

        imgui.EndChild()
    imgui.EndChild()
end

function getip(number)
    if number == 1 then
        local json = os.getenv('TEMP') .. '\\myIP.json'
            downloadUrlToFile('http://ip-api.com/json/?fields=61439', json, function(id, status, p1, p2)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    local f = io.open(json, 'r') -- ��������� ����
                        if f then
                            ip = decodeJson(f:read('*a')) -- ������
                                ipadress = ip.query
                                state = ip.country
                                f:close()
                                os.remove(json)
                        end
                end
            end)
    end
end

function imgui.CenterButton(buttonsize, ...)
    local width = imgui.GetWindowWidth()
    local button_width = imgui.CalcTextSize(u8(buttonsize))
    imgui.SetCursorPosX( width / 2 - button_width .x / 2 )
    imgui.Button(...)
end

function imgui.CenterTextColoredRGB(text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local textsize = w:gsub('{.-}', '')
            local text_width = imgui.CalcTextSize(u8(textsize))
            imgui.SetCursorPosX( width / 2 - text_width .x / 2 )
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else
                imgui.Text(u8(w))
            end
        end
    end
    render_text(text)
end

function getStrDate(unixTime)
    local tMonths = {'������', '�������', '�����', '������', '���', '����', '����', '�������', '��������', '�������', '������', '�������'}
    local day = tonumber(os.date('%d', unixTime))
    local month = tMonths[tonumber(os.date('%m', unixTime))]
    local weekday = tWeekdays[tonumber(os.date('%w', unixTime))]
    return string.format('%s, %s %s', weekday, day, month)
end

function get_clock(time)
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    if tonumber(time) >= 86400 then onDay = true else onDay = false end
    return os.date((onDay and math.floor(time / 86400)..'�� ' or '')..'%H:%M:%S', time + timezone_offset)
end

function time()
	startTime = os.time()                                               -- "����� �������"
    while true do
        wait(1000)
        nowTime = os.date("%H:%M:%S", os.time())
        if sampGetGamestate() == 3 then 								-- ������� ������ ����� "��������� � �������" (��� �� ������ ������� ������, �����, �� ���������� � �������)
	        sessionOnline.v = sessionOnline.v + 1 						-- ������ �� ������ ��� ����� ���
	        sessionFull.v = os.time() - startTime 						-- ����� ������ �� ������
	        sessionAfk.v = sessionFull.v - sessionOnline.v				-- ��� �� ������

	        mainIni.onDay.online = mainIni.onDay.online + 1 				    -- ������ �� ���� ��� ����� ���
	        mainIni.onDay.full = dayFull.v + sessionFull.v 					-- ����� ������ �� ����
	        mainIni.onDay.afk = mainIni.onDay.full - mainIni.onDay.online			-- ��� �� ����

	        mainIni.onWeek.online = mainIni.onWeek.online + 1 					-- ������ �� ������ ��� ����� ���
	        mainIni.onWeek.full = weekFull.v + sessionFull.v 				-- ����� ������ �� ������
	        mainIni.onWeek.afk = mainIni.onWeek.full - mainIni.onWeek.online		-- ��� �� ������

            local today = tonumber(os.date('%w', os.time()))
            mainIni.myWeekOnline[today] = mainIni.onDay.full
	    end
    end
end

function number_week() -- ��������� ������ ������ � ����
    local current_time = os.date'*t'
    local start_year = os.time{ year = current_time.year, day = 1, month = 1 }
    local week_day = ( os.date('%w', start_year) - 1 ) % 7
    return math.ceil((current_time.yday + week_day) / 7)
end

function autoSave()
	while true do 
		wait(60000) -- ���������� ������ 60 ������
		inicfg.save(mainIni, directIni)
	end
end

function onScriptTerminate(script, quitGame)
	if script == thisScript() and not restart then 
		inicfg.save(mainIni, directIni)
	end
end

function NotesWindowFunction()
    notesWindowX = mainIni.notes.notesPosX
    notesWindowY = mainIni.notes.notesPosY
    SizeXNotes = mainIni.notes.SizeX
    local sx, sy = getScreenResolution()

    imgui.SetNextWindowPos(imgui.ImVec2(notesWindowX, notesWindowY), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(SizeXNotes, 200), imgui.Cond.Always)

    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.6))
        imgui.Begin('NotesWindow', InfoWindow, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize)
            imgui.CenterTextColoredRGB("{FFFFFF}�������")
            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                imgui.BeginChild("NotesLine", imgui.ImVec2(SizeXNotes - 8, 174), true)

                    InputTextNotes.v = string.gsub(InputTextNotes.v, '||', '\n')
                    i = 0
                    for v in string.gmatch(u8:decode(InputTextNotes.v), '[^\r\n]+') do
                        i = i + 1
                        string = string.format("{FFFFFF}%d) %s", i, v)
                        imgui.TextColoredRGB(string)
                        
                        if CheckBoxSend.v and not CheckBoxCopy.v then
                            imgui.SameLine()
                            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                                imgui.SetCursorPosX((imgui.GetWindowWidth() - 85))
                                if imgui.Button(u8"���������##"..i, imgui.ImVec2(80,20)) then
                                    sampSendChat(v)
                                end
                            imgui.PopStyleVar()
                        end

                        if not CheckBoxSend.v and CheckBoxCopy.v then
                            imgui.SameLine()
                            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                                imgui.SetCursorPosX((imgui.GetWindowWidth() - 85))
                                if imgui.Button(u8"����������##"..i, imgui.ImVec2(80,20)) then
                                    setClipboardText(v)
                                    sampAddChatMessage("{FF0000}[�������]{FFFFFF}: ����� '"..v.."' ��� ������� ���������� � ����� ������!", -1)
                                end
                            imgui.PopStyleVar()
                        end

                        if CheckBoxSend.v and CheckBoxCopy.v then
                            imgui.SameLine()
                            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
                                imgui.SetCursorPosX((imgui.GetWindowWidth() - 170))
                                if imgui.Button(u8"����������##"..i, imgui.ImVec2(80,20)) then
                                    setClipboardText(v)
                                    sampAddChatMessage("{FF0000}[�������]{FFFFFF}: ����� '"..v.."' ��� ������� ���������� � ����� ������!", -1)
                                end
                                imgui.SameLine()
                                if imgui.Button(u8"���������##"..i, imgui.ImVec2(80,20)) then
                                    sampSendChat(v)
                                end
                            imgui.PopStyleVar()
                        end
                    end

                imgui.EndChild()
            imgui.PopStyleColor()
        imgui.End()
    imgui.PopStyleColor()
end

function ScriptMineSettingsFunction()
    imgui.BeginChild("Mine", imgui.ImVec2(692,492), true)
        imgui.PushFont(fontsizesettings)
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 680))
            imgui.CenterTextColoredRGB("{FF0000}�������� ��� ����� {696969}(?)")
        imgui.PopFont()
            imgui.Hint(u8"������ '�����'", u8"������, ������� �������� ���� ������ �� �����.\n� ��� ������� �� ������ ����� ��� � ����� �������� ����.", 0)
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 645))
        imgui.Separator()

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 620))
        --imgui.BeginChild("MineStats", imgui.ImVec2(450,150), true)
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 568))
            imgui.BeginChild("MineStats1", imgui.ImVec2(442,114), true)
                --imgui.Separator()
                imgui.Columns(3, "������� ����������", true)
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    imgui.CenterColumnText(u8"������������ ����")
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    imgui.CenterColumnText(u8"������� �� ������")
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    imgui.CenterColumnText(u8"������� �� ����")
                imgui.PopStyleColor()
                imgui.Separator()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    imgui.CenterColumnText(u8"������")
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    stringStoneSession = string.format(u8"%d ����", StoneSession)
                    imgui.CenterColumnText(stringStoneSession)
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    stringStoneDay = string.format(u8"%d ����", StoneDay)
                    imgui.CenterColumnText(stringStoneDay)
                imgui.PopStyleColor()
                imgui.Separator()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    imgui.CenterColumnText(u8"������")
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    stringMetalSession = string.format(u8"%d ����", MetalSession)
                    imgui.CenterColumnText(stringMetalSession)
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    stringMetalDay = string.format(u8"%d ����", MetalDay)
                    imgui.CenterColumnText(stringMetalDay)
                imgui.PopStyleColor()
                imgui.Separator()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    imgui.CenterColumnText(u8"�������")
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    stringSilverSession = string.format(u8"%d ����", SilverSession)
                    imgui.CenterColumnText(stringSilverSession)
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    stringSilverDay = string.format(u8"%d ����", SilverDay)
                    imgui.CenterColumnText(stringSilverDay)
                imgui.PopStyleColor()
                imgui.Separator()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    imgui.CenterColumnText(u8"������")
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    stringGoldSession = string.format(u8"%d ����", GoldSession)
                    imgui.CenterColumnText(stringGoldSession)
                imgui.PopStyleColor()
                imgui.NextColumn()
                imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(1.00, 1.00, 1.00, 1.00))
                    stringGoldDay = string.format(u8"%d ����", GoldDay)
                    imgui.CenterColumnText(stringGoldDay)
                imgui.PopStyleColor()
                imgui.Columns(1)

            imgui.EndChild()
        --imgui.EndChild()

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 480))
        imgui.Separator()

        local idText

        imgui.SetCursorPosX((imgui.GetWindowWidth() - 581))
        imgui.SetCursorPosY((imgui.GetWindowWidth() - 449))
        imgui.BeginChild("##1212121", imgui.ImVec2(470,190), true)
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5,0.5))
                if imgui.Button(fa.ICON_FA_PLAY_CIRCLE .. u8" ��������� / ����������", imgui.ImVec2(462,20)) then
                    local _, pID = sampGetPlayerIdByCharHandle(PLAYER_PED)
                    local result, ped = sampGetCharHandleBySampPlayerId(pID)
                    if not StartMineScript then
                        if isCharInArea2d(PLAYER_PED, -679.3196, -612.3732, -911.9957, -397.4157, false) then
                            StartMineScript = true
                            sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������ '�����' ������� �������.", -1)
                            if CheckBoxShow3DText.v then
                                local id = 0
                                DistaceShow = mainIni.minesettings.DistaceShow
                                if CheckBoxShow3DTextTime.v then
                                    sampCreate3dText("������������� ���� {FFA500}�1\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -789.71997070313, -474.15475463867, -75.960960388184 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�2\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -782.87414550781, -467.52841186523, -75.738952636719 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�3\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -773.15869140625, -453.16439819336, -74.725547790527 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�4\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -773.55389404297, -474.81018066406, -76.094009399414 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�5\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -760.13922119141, -482.11743164063, -75.827163696289 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�6\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -746.60015869141, -475.27471923828, -75.383903503418 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�7\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -770.92211914063, -494.55117797852, -77.249656677246 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�8\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -770.86840820313, -503.8102722168, -76.973587036133 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�9\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -765.11456298828, -509.98376464844, -76.259269714355 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�10\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -778.27117919922, -517.89770507813, -76.839736938477 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�11\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -785.21295166016, -525.48364257813, -76.74055480957 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�12\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -805.10235595703, -522.18481445313, -76.509552001953 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�13\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -817.66571044922, -513.65270996094, -76.913093566895 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�14\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -818.67932128906, -503.12701416016, -76.798812866211 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�15\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -810.42504882813, -496.8430480957, -77.023551940918 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�16\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -799.75384521484, -492.43728637695, -77.088050842285 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�17\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -784.56195068359, -494.86532592773, -77.099189758301 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�18\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -791.36975097656, -504.45809936523, -77.104125976563 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�19\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -794.85504150391, -517.11480712891, -76.919937133789 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�20\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -825.69116210938, -537.87036132813, -70.639915466309 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�21\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -815.05676269531, -530.40093994141, -67.079536437988 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�22\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -800.54931640625, -542.06457519531, -72.860763549805 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�23\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -774.16882324219, -543.85192871094, -70.843231201172 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�24\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -751.25091552734, -511.12908935547, -70.244316101074 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�25\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -817.5712890625, -444.79592895508, -69.854766845703 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�26\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -846.90063476563, -462.55258178711, -73.36597442627 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�27\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -858.91076660156, -527.14190673828, -54.823673248291 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�28\n\n{ffffff}��������� ������� ������:\n{FFA500} ���", 0xFFFFFFFF, -801.57800292969, -504.98147583008, -77.086730957031 + 1, DistaceShow, true, -1, -1)
                                else
                                    sampCreate3dText("������������� ���� {FFA500}�1", 0xFFFFFFFF, -789.71997070313, -474.15475463867, -75.960960388184 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�2", 0xFFFFFFFF, -782.87414550781, -467.52841186523, -75.738952636719 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�3", 0xFFFFFFFF, -773.15869140625, -453.16439819336, -74.725547790527 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�4", 0xFFFFFFFF, -773.55389404297, -474.81018066406, -76.094009399414 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�5", 0xFFFFFFFF, -760.13922119141, -482.11743164063, -75.827163696289 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�6", 0xFFFFFFFF, -746.60015869141, -475.27471923828, -75.383903503418 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�7", 0xFFFFFFFF, -770.92211914063, -494.55117797852, -77.249656677246 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�8", 0xFFFFFFFF, -770.86840820313, -503.8102722168, -76.973587036133 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�9", 0xFFFFFFFF, -765.11456298828, -509.98376464844, -76.259269714355 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�10", 0xFFFFFFFF, -778.27117919922, -517.89770507813, -76.839736938477 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�11", 0xFFFFFFFF, -785.21295166016, -525.48364257813, -76.74055480957 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�12", 0xFFFFFFFF, -805.10235595703, -522.18481445313, -76.509552001953 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�13", 0xFFFFFFFF, -817.66571044922, -513.65270996094, -76.913093566895 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�14", 0xFFFFFFFF, -818.67932128906, -503.12701416016, -76.798812866211 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�15", 0xFFFFFFFF, -810.42504882813, -496.8430480957, -77.023551940918 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�16", 0xFFFFFFFF, -799.75384521484, -492.43728637695, -77.088050842285 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�17", 0xFFFFFFFF, -784.56195068359, -494.86532592773, -77.099189758301 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�18", 0xFFFFFFFF, -791.36975097656, -504.45809936523, -77.104125976563 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�19", 0xFFFFFFFF, -794.85504150391, -517.11480712891, -76.919937133789 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�20", 0xFFFFFFFF, -825.69116210938, -537.87036132813, -70.639915466309 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�21", 0xFFFFFFFF, -815.05676269531, -530.40093994141, -67.079536437988 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�22", 0xFFFFFFFF, -800.54931640625, -542.06457519531, -72.860763549805 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�23", 0xFFFFFFFF, -774.16882324219, -543.85192871094, -70.843231201172 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�24", 0xFFFFFFFF, -751.25091552734, -511.12908935547, -70.244316101074 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�25", 0xFFFFFFFF, -817.5712890625, -444.79592895508, -69.854766845703 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�26", 0xFFFFFFFF, -846.90063476563, -462.55258178711, -73.36597442627 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�27", 0xFFFFFFFF, -858.91076660156, -527.14190673828, -54.823673248291 + 1, DistaceShow, true, -1, -1)
                                    sampCreate3dText("������������� ���� {FFA500}�28", 0xFFFFFFFF, -801.57800292969, -504.98147583008, -77.086730957031 + 1, DistaceShow, true, -1, -1)
                                end

                                --[[for k, v in pairs(Field) do
                                    local X = v.coord[1]
                                    local Y = v.coord[2]
                                    local Z = v.coord[3]
                                end]]
                            end
                        else
                            Error("��� ������� ���������� ���������� �� �����.")
                        end
                    else
                        StartMineScript = false
                        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: ������ '�����' ��������.", -1)
                        Competitors_Main_Window_State.v = false
                        for i = 0, 500 do
                            sampDestroy3dText(i)
                        end
                    end
                end
            imgui.PopStyleVar()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 160))
            imgui.VerticalSeparator()
            imgui.Separator()
            imgui.Checkbox("##12313124", CheckBoxShow3DText)
            mainIni.minesettings.CheckBoxShow3DText = CheckBoxShow3DText.v
            inicfg.save(mainIni, directIni)
            imgui.SameLine()
            imgui.TextColoredRGB("{FFFFFF}�������� ����� 3D ������ {696969}(?)")
            imgui.Hint(u8"����� 3D ������", u8"��������/��������� ����� ��������������� 3D ������ ��� ��������������� ����.", 0)
            
            imgui.SameLine()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 155))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 436))
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5,0.5))
                if imgui.ButtonClickable(true, u8"���������##3440981209", imgui.ImVec2(150,20)) then
                    Shadow_Window_State.v = true
                    ShadowWindow_InfoWindow = false
                    ShadowWindow_Distance3DTextMine = true
                    ShadowWindow_NotesWindow = false
                    ShadowWindow_OpenBoxPandora = false
                    ShadowWindow_Succesful = false
                end
            imgui.PopStyleVar()

            imgui.Checkbox("##15124", CheckBoxShow3DTextTime)
            mainIni.minesettings.CheckBoxShow3DTextTime = CheckBoxShow3DTextTime.v
            inicfg.save(mainIni, directIni)
            imgui.SameLine()
            imgui.TextColoredRGB("{FFFFFF}�������� ����� ���������� ������� {696969}(?)")
            imgui.Hint(u8"��������� ������", u8"��������/��������� ����� ���������� �������� ���� �� ���� ������������� �������.", 0)

            imgui.SameLine()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 155))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 410))
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5,0.5))
                imgui.ButtonClickable(false, u8"���������", imgui.ImVec2(150,20))
            imgui.PopStyleVar()

            imgui.Checkbox("##12334344", CheckBoxNotice)
            mainIni.minesettings.CheckBoxNotice = CheckBoxNotice.v
            inicfg.save(mainIni, directIni)
            imgui.SameLine()
            imgui.TextColoredRGB("{FFFFFF}���������� � ��������� ������� {696969}(?)")
            imgui.Hint(u8"�����������", u8"��� ��������� �� ����� �� ������������� ����, �� ������ ���������� � ����.\n\n������: �� ������������� �1 ��������� ����.", 0)

            imgui.SameLine()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 155))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 384))
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5,0.5))
                imgui.ButtonClickable(false, u8"���������", imgui.ImVec2(150,20))
            imgui.PopStyleVar()

            imgui.Checkbox("##343644", CheckBoxAdvance)
            mainIni.minesettings.CheckBoxAdvance = CheckBoxAdvance.v
            inicfg.save(mainIni, directIni)
            imgui.SameLine()
            imgui.TextColoredRGB("{FFFFFF}�������� ���������� ������������ {696969}(?)")
            imgui.Hint(u8"���������� ������������", u8"������� ��������� �������� (��������) ������� ���������� ������� �� �����.", 0)

            imgui.SameLine()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 155))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 358))
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5,0.5))
                if imgui.ButtonClickable(true, u8"���������##123415125", imgui.ImVec2(150,20)) then
                    if not Competitors_Main_Window_State.v then
                        Error("���������� ���������� ������� ���� ��� ��� ������������.")
                    else
                        sampAddChatMessage("{FF0000}[Rodina Helper]{FFFFFF}: �������� ������� � ������� {FF0000}Enter{FFFFFF} ����� ��������� �.", -1)
                        changePositionCompetitorsWindow = true
                        settings_window_state_one.v = false
                        settings_window_state_two.v = false
                    end
                end
            imgui.PopStyleVar()

            imgui.Checkbox("##1233244", CheckBoxMarker)
            mainIni.minesettings.CheckBoxMarker = CheckBoxMarker.v
            inicfg.save(mainIni, directIni)
            imgui.SameLine()
            imgui.TextColoredRGB("{FFFFFF}������������� ������ {696969}(?)")
            imgui.Hint(u8"������ �� �����", u8"��� ��������� �� ����� �� ������������� ����, ����� ���������� ������ �� ��.", 0)

            imgui.SameLine()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 155))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 332))
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5,0.5))
                imgui.ButtonClickable(false, u8"���������", imgui.ImVec2(150,20))
            imgui.PopStyleVar()

            imgui.Checkbox("##3463244", CheckBoxLine)
            mainIni.minesettings.CheckBoxLine = CheckBoxLine.v
            inicfg.save(mainIni, directIni)
            imgui.SameLine()
            imgui.TextColoredRGB("{FFFFFF}������� ���������� ������� {696969}(?)")
            imgui.Hint(u8"���� ��������", u8"���������� � ������� ������� ��������.", 0)

            imgui.SameLine()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - 155))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 306))
            imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5,0.5))
                imgui.ButtonClickable(false, u8"���������", imgui.ImVec2(150,20))
            imgui.PopStyleVar()
        imgui.EndChild()

        imgui.SetCursorPosY((imgui.GetWindowWidth() - 230))
        imgui.Separator()

        imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.5, 0.5))
            imgui.SetCursorPosY((imgui.GetWindowWidth() - 225))
            if imgui.Button(fa.ICON_FA_LONG_ARROW_ALT_LEFT .. u8"\t��������� �� �������", imgui.ImVec2(684,20)) then
                BasicSettings = false
                ScriptsSettings = true
                MyAnalitics = false
                Notes = false
                ScriptMineSettings = false
            end
        imgui.PopStyleVar()
    imgui.EndChild()
end

function Error(text)
    result = sampAddChatMessage("[ERROR]{ffffff}: " .. text, 0xFFFF0000)
    return result
end

function imgui.CenterColumnText(text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end

function SearchObjectInRadius()
    local minDist = 9999
    local mX, mY, mZ = getCharCoordinates(playerPed)
    local retId = -1
    for key, objectHandle in pairs(getAllObjects()) do
        idobj = getObjectModel(objectHandle)
        local _, posX, posY, posZ = getObjectCoordinates(objectHandle)
        local dist = getDistanceBetweenCoords3d(mX, mY, mZ, posX, posY, posZ)
        if dist < minDist then
            minDist = dist
            retId = getObjectModel(objectHandle)
        end
    end
    return retId
end

function sampev.onCreateObject(id, data)
    X, Y, Z = getCharCoordinates(PLAYER_PED)
    distance = getDistanceBetweenCoords3d(X, Y ,Z , data.position.x, data.position.y, data.position.z)
    if CheckBoxNotice.v and StartMineScript then
        if data.modelId == 854 then
            rudaDistance = math.round(distance, 1)
            FieldID = GetID3DText(data.position.x, data.position.y)
            if FieldID == nil or FieldID == -1 then FieldID = 0 end
            sampAddChatMessage("{ff0000}[�����]{ffffff}: �� ������������� {FFA500}�".. FieldID .." {FFFFFF}��������� ����! ���������� �� ����: {FFA500}"..tonumber(rudaDistance).."�", 0xFFFF0000)
        end
    end

    if StartMineScript and CheckBoxMarker.v then
        if data.modelId == 854 then
            setMarker(1, data.position.x, data.position.y, data.position.z, 3.0, 0xFFFFA500)
            sampAddChatMessage("{ff0000}[�����]{ffffff}: ����� �����������.", 0xFFFF0000)
        end
    end
end

function setMarker(type, x, y, z, radius, color)
    deleteCheckpoint(marker)
    removeBlip(checkpoint)
    checkpoint = addBlipForCoord(x, y, z)
    marker = createCheckpoint(type, x, y, z, 1, 1, 1, radius)
    changeBlipColour(checkpoint, color)
    lua_thread.create(function()
    repeat
        wait(0)
        local x1, y1, z1 = getCharCoordinates(PLAYER_PED)
        until getDistanceBetweenCoords3d(x, y, z, x1, y1, z1) < radius or not doesBlipExist(checkpoint)
        deleteCheckpoint(marker)
        removeBlip(checkpoint)
        addOneOffSound(0, 0, 0, 1149)
    end)
end

function GetID3DText(x, y)
    local idField = -1
    for id = 0, 2048 do
        if sampIs3dTextDefined(id) then
            local tx, cl, pX, pY, pZ, dis, wl, pid, vid = sampGet3dTextInfoById(id)
            if x == pX and y == pY then
                local txt, clr, ppX, ppY, ppZ, dist, wll, pidd, vidd = sampGet3dTextInfoById(id)
                idField = txt:match("(%d+\n+)")
                return idField
            end
        end
    end
    return idField
end

function Update3DTextSource(source)
    local minDist = 10
    local mX, mY, mZ = getCharCoordinates(playerPed)
    for key, objectHandle in pairs(getAllObjects()) do
        local _, posX, posY, posZ = getObjectCoordinates(objectHandle)
        local dist = getDistanceBetweenCoords3d(mX, mY, mZ, posX, posY, posZ)
        local idobj = getObjectModel(objectHandle)
        if dist < minDist then
            if idobj == 854 then
                local _, posX, posY, posZ = getObjectCoordinates(objectHandle)
                minDist = dist
                for id = 0, 2048 do
                    if sampIs3dTextDefined(id) then
                        local tx, cl, pX, pY, pZ, dis, wl, pid, vid = sampGet3dTextInfoById(id)
                        if posX == pX and posY == pY then
                            local txt, clr, ppX, ppY, ppZ, dist, wll, pidd, vidd = sampGet3dTextInfoById(id)
                            idField = txt:match("(%d+\n+)")
                            if idField == nil or idField == -1 then idField = 0 end
                            sampSet3dTextString(id, "������������� ���� {FFA500}�"..idField.."\n\n{ffffff}��������� ������� ������:\n{FFA500} "..source)
                        end
                    end
                end
            end
        end
    end
end
------------------------------------------------------------------------------------------------------------------------------