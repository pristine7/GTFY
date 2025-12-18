local notif = false
local sdb = false
local pull = false
local kick = false
local ban = false
local trade = false
local reme = false
local qeme = false
local logcollect = ""
local logdrop = ""
local gaspull = false
local autopull = false
local cbgl = false
local tablelogspin = {}
local cvwl = false
local tpdisplay = false
local fasttrash = false
local fastdrop = false
local autoacc = false
local vspin = false
local vnumber = 0
local blskin = false
local skin_color = {
    1348237567, 1685231359, 2022356223, 2190853119, 2527912447, 2864971775, 3033464831, 3370516479
}

local edith = true
allowed_ids = {
    2886134, 2615754, 2592746
}
local usid = GetLocal().userID

function isAllowedUser(id)
for _, v in ipairs(allowed_ids) do
if v == id then
return true
end
end
return false
end

if isAllowedUser(usid) then
edith = true
else
    LogToConsole("`w[`bpr1s`w] `3UserId Doesn't Match, Script Not Working")
end

function GetItemCount(id)
if not edith then return end
for _, inv in pairs(GetInventory()) do
if inv.id == id then
return inv.amount
end
end
return 0
end

function OnBoxUpdated(boolean)
if not edith then return end
local hasil = ""
if boolean then
hasil = "1"
else
    hasil = "0"
end
return hasil
end

function OnWear(id)
if not edith then return end
SendPacketRaw(false, {
    type = 10, value = id
})
end

function OnTextOverlay(str)
if not edith then return end
SendVariant({
    v1 = "OnTextOverlay", v2 = str
})
end

function OnTalkBubble(str)
if not edith then return end
SendVariant({
    v1 = "OnTalkBubble", v2 = GetLocal().netID, v3 = str
})
end

function OnConsoleMessage(str)
if not edith then return end
LogToConsole("`w[`bpr1s`w] `0"..str)
end

function OnProxyWarning(str)
if not edith then return end
LogToConsole("`w[`bpr1s`w] `6Proxy Warning: `0"..str)
end

function OnDroppedItem(id,amount)
if not edith then return end
SendPacket(2, "action|dialog_return\ndialog_name|drop_item\nitemID|"..id.."|\ncount|"..amount)
end

function OnWarning(str)
if not edith then return end
SendVariant({
    v1 = "OnAddNotification", v2 = "interface/atomic_button.rttex", v3 = str, v4 = "audio/hub_open.wav"
})
end

function bskin()
if not edith then return end
for _ , skin in ipairs(skin_color) do
SendPacket(2,"action|setSkin\ncolor|"..skin)
Sleep(50)
end
end

function ProxyOpen()
if not edith then return end
opening = [[
add_label_with_icon|big|`9EDITH Proxy Gazzete``  |left|14226|
add_smalltext|`eVersion: `91.1|
add_spacer|small|
add_url_button||`9EDITH Community|noflags|https://discord.com/invite/GAAqQFmvNH|`wDo you want to join `9EDITH Comunity `wDiscord Server?|0|0|
add_spacer|small|
add_textbox|`2Hello ]]..GetLocal().name..[[ `w(`^]]..GetLocal().userID..[[`w)|
add_textbox|`2Proxy Made By: `w[`bpr1s`w]|
add_spacer|small|
add_label_with_icon|small|`5Command``|left|6128|
add_textbox|`c/proxy `w(`pShows All Proxy Commands`w)|
add_spacer|small|
add_label_with_icon|small|`5Change Log``|left|3524|
add_textbox|`w[`2+`w] `pAdded Auto Accept Access `w(`c/toggle`w)|
add_textbox|`w[`2+`w] `p Added Custom Drop DL & BGL `w(`c/cd`w)|
add_spacer|small|
add_quick_exit||
end_dialog|cmdend|Okey|
]]
SendVariant({
    v1 = "OnDialogRequest", v2 = opening
})
end

if edith == true then
ProxyOpen()
end

function ProxyCommand()
if not edith then return end
cmd = [[
add_label_with_icon|big|`9EDITH Proxy Command & Features|left|14226|
add_spacer|small|
add_url_button||`9EDITH Community|noflags|https://discord.com/invite/GAAqQFmvNH|`wDo you want to join `9EDITH Comunity `wDiscord Server?|0|0|
add_spacer|small|
add_label_with_icon|small|`5Main Commands``|left|6126|
add_textbox|`c/proxy `w(`pShows All Proxy Commands`w)|
add_textbox|`c/dc `w(`9EDITH Comunity `pDiscord Server`w)|
add_spacer|small|
add_label_with_icon|small|`5Toggelable Features `w(`c/toggle`w)``|left|6292|
add_textbox|`w[`2+`w] `pFast Change BGL|
add_textbox|`w[`2+`w] `pBlock Adventure Notifications|
add_textbox|`w[`2+`w] `pBlock SDB|
add_textbox|`w[`2+`w] `pAuto Pull When People Enter|
add_textbox|`w[`2+`w] `pAuto Pull When Say Gas|
add_textbox|`w[`2+`w] `pAuto Shattered WLs Into DLs|
add_textbox|`w[`2+`w] `pAuto Accept Access|
add_textbox|`w[`2+`w] `pFast Trash|
add_textbox|`w[`2+`w] `pFast Drop|
add_spacer|small|
add_label_with_icon|small|`5Misc Commands``|left|7014|
add_textbox|`c/toggle `w(`pToggles Selectable Features`w)|
add_textbox|`c/logs `w(`pLogs Options`w)|
add_textbox|`c/wrench `w[`2mode`w] (`pFast Wrench Mode `w[`30. Default, 1. Pull, 2. Kick, 3. Ban, 4. Trade`w])|
add_textbox|`c/tp `w(`pEnabled/Disabled Findpath To Display Using Punch`w)|
add_textbox|`c/lock `w(`pCheck Account Balance`w)|
add_textbox|`c/daw `w(`pDrop All Lock`w)|
add_textbox|`c/exit `w(`pExiting World`w)|
add_textbox|`c/res `w(`pRespawing`w)|
add_spacer|small|
add_label_with_icon|small|`5Host Commands``|left|758|
add_textbox|`c/reme `w(`pEnabled/Disabled REME Spin Checker`w)|
add_textbox|`c/qeme `w(`pEnabled/Disabled QEME Spin Checker`w)|
add_textbox|`c/cd `w[`2amount`w] (`pCustom Drop `cDL `p& `eBGL`w)|
add_textbox|`c/dw `w[`2amount`w] (`pCustom Drop `9World Lock`w)|
add_textbox|`c/dd `w[`2amount`w] (`pCustom Drop `cDiamond Lock`w)|
add_textbox|`c/db `w[`2amount`w] (`pCustom Drop `eBlue Gem Lock`w)|
add_textbox|`c/da `w[`2amount`w] (`pCustom Drop `bAbsolute Lock`w)|
add_textbox|`c/dw3 `w[`2amount`w] (`pCustom Drop X3 `9World Lock`w)|
add_textbox|`c/dd3 `w[`2amount`w] (`pCustom Drop X3 `cDiamond Lock`w)|
add_textbox|`c/db3 `w[`2amount`w] (`pCustom Drop X3 `eBlue Gem Lock`w)|
add_textbox|`c/da3 `w[`2amount`w] (`pCustom Drop X3 `bAbsolute Lock`w)|
add_spacer|small|
add_label_with_icon|small|`5BGL Bank Commands``|left|7188|
add_textbox|`c/withdraw `w[`2amount`w] `p<> `c/wd `w[`2amount`w] `w(`pWithdraw `eBlue Gem Lock `pFrom Your Bank`w)|
add_textbox|`c/deposit `w[`2amount`w] `p<> `c/dp `w[`2amount`w] `w(`pDeposit `eBlue Gem Lock `pTo Your Bank`w)|
--add_textbox|`c/withdrawall `w[`2amount`w] `p<> `c/wdall `w(`pWithdraw All `eBlue Gem Lock `pFrom Your Bank`w)|
add_textbox|`c/depositall `p<> `c/dpall `w(`pDeposit All `eBlue Gem Lock `pTo Your Bank`w)|
add_spacer|small|
add_label_with_icon|small|`5Fun Commands``|left|8224|
add_textbox|`c/blink `w(`pEnabled/Disabled Blink Skin Collr`w)|
add_textbox|`c/howpro `w(`pShow How Pro Are You`w)|
add_textbox|`c/fakeban <reason> `w(`pFake Ban Notification`w)|
add_textbox|`c/setnumber <number> `w(`pSet Visual Roulette Number`w)|
add_spacer|small|
add_quick_exit||
end_dialog|cmdend|Cancel|
]]
SendVariant({
    v1 = "OnDialogRequest", v2 = cmd
})
end

function MenuLog()
if not edith then return end
logm = [[
add_label_with_icon|big|`bLogs Options``    |left|1436|
add_spacer|small|
add_button|spin|`wRoulette Logs|noflags|0|
add_button|drop|`wDropped Logs|noflags|0|
add_button|coll|`wCollected Logs|noflags|0|
add_spacer|small|
add_button|resetall|`4Reset All Logs|noflags|0|
add_spacer|small|
add_quick_exit||
end_dialog|ah|Close||
]]
SendVariant({
    v1 = "OnDialogRequest", v2 = logm
})
end

function DropLog()
if not edith then return end
DialogDrop = [[
add_label_with_icon|big|`bDropped Logs|left|13810|
add_spacer|small|
add_button|backl|`wBack|noflags|0|
add_button|resetd|`4Reset|noflags|0|
]]..logdrop..[[
add_spacer|small|
add_quick_exit||
end_dialog|logah|Close||
]]
SendVariant({
    v1 = "OnDialogRequest", v2 = DialogDrop
})
end

function CollectLog()
if not edith then return end
DialogCollect = [[
add_label_with_icon|big|`bCollected Logs|left|13808|
add_spacer|small|
add_button|backl|`wBack|noflags|0|
add_button|resetc|`4Reset|noflags|0|
]]..logcollect..[[
add_spacer|small|
add_quick_exit||
end_dialog|logah|Close||
]]
SendVariant({
    v1 = "OnDialogRequest", v2 = DialogCollect
})
end

function Discord()
if not edith then return end
DialogDiscord = [[
add_label_with_icon|big|`9EDITH Comunity Server|left|10568|
add_spacer|small|
add_textbox|`wDo you want to join `9EDITH Comunity `wDiscord Server?|
add_spacer|small|
add_url_button||`9Join Comunity|noflags|https://discord.com/invite/GAAqQFmvNH|`wDo you want to join `9EDITH Comunity `wDiscord Server?|0|0|
add_quick_exit||
]]
SendVariant({
    v1 = "OnDialogRequest", v2 = DialogDiscord
})
end

function Friend()
if not edith then return end
DialogFriend = [[
add_label_with_icon|big|`wSocial Portal|left|1366|
add_spacer|small|
add_button|eproxy|`9EDITH Proxy|noflags|0|0|
add_button|showfriend|`wShow Friends|noflags|0|0|
add_button|showguild|`wShow Guild Members|noflags|0|0|
add_button|trade_history|`wTrade History|noflags|0|0|
add_button|online_point|`wOnline Points|noflags|0|0|
add_button|event_server|`wDaily Event|noflags|0|0|
add_quick_exit||
end_dialog|socialportal|Close|
]]
SendVariant({
    v1 = "OnDialogRequest", v2 = DialogFriend
})
end

function ProxyMenu()
if not edith then return end
DialogProxy = [[
add_label_with_icon|big|`9EDITH Proxy Menu   |left|14226|
add_spacer|small|
add_button|proxy_toggle|`wToggle Options|noflags|0|0|
add_button|proxy_logs|`wProxy Loggings|noflags|0|0|
add_button|proxy_cmd|`wProxy Command|noflags|0|0|
add_url_button||`9EDITH Community|noflags|https://discord.com/invite/GAAqQFmvNH|`wDo you want to join `9EDITH Comunity `wDiscord Server?|0|0|
add_quick_exit||
end_dialog|proxymenu|Close|
]]
SendVariant({
    v1 = "OnDialogRequest", v2 = DialogProxy
})
end

function ProxyToggle()
if not edith then return end
fastcbgl = OnBoxUpdated(cbgl)
notifblock = OnBoxUpdated(notif)
sdbblock = OnBoxUpdated(sdb)
apull = OnBoxUpdated(autopull)
gpull = OnBoxUpdated(gaspull)
cvwlon = OnBoxUpdated(cvwl)
trashon = OnBoxUpdated(fasttrash)
dropon = OnBoxUpdated(fastdrop)
vson = OnBoxUpdated(vspin)
aaon = OnBoxUpdated(autoacc)
SendVariant({
    v1 = "OnDialogRequest",
    v2 = [[
add_label_with_icon|big|`bToggle Page``  |left|6292|
add_spacer|small|
add_textbox|`2~> `5Main|
add_checkbox|fcbgl|`9Fast Change BGL|]]..fastcbgl..[[|
add_checkbox|notifad|`9Block Adventure Notifications|]]..notifblock..[[|
add_checkbox|sdbb|`9Block SDB|]]..sdbblock..[[|
add_checkbox|ap|`9Auto Pull|]]..apull..[[|
add_checkbox|gp|`9Auto Pull When Say Gas|]]..gpull..[[|
add_checkbox|taiwl|`9Auto Sharttered WLs Into DLs|]]..cvwlon..[[|
add_checkbox|fts|`9Fast Trash|]]..trashon..[[|
add_checkbox|fdp|`9Fast Drop|]]..dropon..[[|
add_checkbox|aacc|`9Auto Accept Access|]]..aaon..[[|
add_spacer|small|
add_textbox|`2~> `5Fun|
add_checkbox|vsp|`9Custom Roulette Number `w(Visual)|]]..vson..[[|
add_smalltext|`3Use command '`6/setnumber <number>`3' to set number|
add_spacer|small|
end_dialog|op|Close|Apply|
            ]]
})
end

function isQeme(number)
if not edith then return end
if number >= 10 then
res = string.sub(number, -1)
else
    res = number
end
return res
end

function isReme(number)
if not edith then return end
if number == 19 or number == 28 or number == 0 then
res = 0
else
    num1 = math.floor(number / 10)
num2 = number % 10
res = string.sub(tostring(num1 + num2), -1)
end
return res
end

function getGame(num)
if not edith then return end
if reme and not qeme then
return "`9[`5REME: `6"..isReme(tonumber(num)).."`9]"
elseif not reme and qeme then
return "`9[`5QEME: `6"..isQeme(tonumber(num)).."`9]"
else
    return ""
end
end

function CheckLock()
wl = GetItemCount(242)
dl = GetItemCount(1796)
bgl = GetItemCount(7188)
abso = GetItemCount(16098)
OnConsoleMessage("`6Account Balance : `w"..abso.. " `bAbsolute Lock`w, ".. bgl.. " `eBlue Gem Lock`w, "..dl.." `cDiamond Lock`w, "..wl.." `9World Lock")
end

function DropAllLock()
wl = GetItemCount(242)
dl = GetItemCount(1796)
bgl = GetItemCount(7188)
abso = GetItemCount(16098)
if wl > 0 then
OnDroppedItem(242, wl)
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `w(`5DAW`w) `9You've Dropped `2"..wl.." `9World Lock|left|242|\n"
end
if dl > 0 then
OnDroppedItem(1796, dl)
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `w(`5DAW`w) `9You've Dropped `2"..dl.." `cDiamond Lock|left|1796|\n"
end
if bgl > 0 then
OnDroppedItem(7188, bgl)
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `w(`5DAW`w) `9You've Dropped `2"..bgl.." `eBlue Gem Lock|left|7188|\n"
end
if abso > 0 then
OnDroppedItem(16098, abso)
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `w(`5DAW`w) `9You've Dropped `2"..abso.." `bAbsolute Lock|left|16306|\n"
end
OnConsoleMessage("`5Dropped All Lock")
end

function GetPlayerName(id)
if not edith then return end
for _, player in pairs(GetPlayerList()) do
if player.netID == id then
return player.name
end
end
end

function pelerspin(id)
if not edith then return end
filterLog = {}
for _, log in pairs(tablelogspin) do
if log.netid == id then
table.insert(filterLog,"\nadd_label_with_icon|small|"..log.spin.."|left|758|\n")
end
end
SendVariant({
    v1 = "OnDialogRequest",
    v2 = [[
add_label_with_icon|big|]]..GetPlayerName(id)..[[ `bLogs|left|758|
add_spacer|small|
    ]]..table.concat(filterLog)..[[
add_spacer|small|
add_quick_exit||
end_dialog|spinfilter|Close||
		]]
})
end

function SpinLog()
if not edith then return end
dialogSpin = {}
for _,spin in pairs(tablelogspin) do
table.insert(dialogSpin,spin.spin)
end
SendVariant({
    v1 = "OnDialogRequest",
    v2 = [[
add_label_with_icon|big|`bRoulette Logs|left|758|
add_spacer|small|
add_button|backl|`wBack|noflags|0|
add_button|resets|`4Reset|noflags|0|
add_smalltext|`9It Will Auto `4Reset `9When You Exit The `2World|
add_smalltext|`9Click The Wheel Button To View Specific Player Logs|
    ]]..table.concat(dialogSpin)..[[
add_spacer|small|
add_quick_exit||
end_dialog|logah|Close||
		]]
})
end

function cmd(type,str)
if not edith then return end
if str:find("/proxy") then
OnConsoleMessage("`6/proxy")
ProxyCommand()
return true
elseif str:find("/toggle") then
OnConsoleMessage("`6/toggle")
ProxyToggle()
return true
elseif str:find("/dc") then
OnConsoleMessage("`6/dc")
Discord()
return true
elseif str:find("/logs") then
OnConsoleMessage("`6/logs")
MenuLog()
return true
elseif str:find("/lock") then
OnConsoleMessage("`6/lock")
CheckLock()
return true
elseif str:find("/daw") then
OnConsoleMessage("`6/daw")
DropAllLock()
return true
elseif str:find("/howpro") then
OnConsoleMessage("`6/howpro")
name = GetLocal().name
hpro = math.random(1, 100)
OnTalkBubble(name.." `ware `5"..hpro.."% `wpro!")
OnConsoleMessage(name.." `ware `5"..hpro.."% `wpro!")
return true
elseif str:find("/fakeban <reason>") then
reason = str:match("/fakeban (.+)")
OnConsoleMessage("`6/fakeban "..reason)
OnConsoleMessage("`wWarning from `4System`w: You've been `4Banned `wfor 730day. `4Reason: "..reason)
SendVariant ({
    v1 = "OnAddNotification", v2 = "interface/atomic_button.rttex", v3 = "`wWarning from `4System`w: You've been `4Banned `wfor 730day. `4Reason: "..reason, v4 = "audio/already_used.wav"
})
return true
elseif str:find("buttonClicked|eproxy") then
ProxyMenu()
return true
elseif str:find("buttonClicked|proxy_toggle") then
ProxyToggle()
return true
elseif str:find("buttonClicked|proxy_logs") then
MenuLog()
return true
elseif str:find("buttonClicked|proxy_cmd") then
ProxyCommand()
return true
elseif str:find("buttonClicked|proxy_auto") then
MenuAuto()
return true
elseif str:find("buttonClicked|spin") then
SpinLog()
return true
elseif str:find("buttonClicked|drop") then
DropLog()
return true
elseif str:find("buttonClicked|coll") then
CollectLog()
return true
elseif str:find("buttonClicked|resetall") then
tablelogspin = {}
logdrop = ""
logcollect = ""
OnTextOverlay("`4Reset `wAll Logs")
return true
elseif str:find("buttonClicked|resets") then
tablelogspin = {}
OnTextOverlay("`wRoulette Logs Has Been `4Reset")
return true
elseif str:find("buttonClicked|resetd") then
logdrop = ""
OnTextOverlay("`wDropped Logs Has Been `4Reset")
return true
elseif str:find("buttonClicked|resetc") then
logcollect = ""
OnTextOverlay("`wCollected Logs Has Been `4Reset")
return true
elseif str:find("buttonClicked|backl") then
MenuLog()
return true
end

if str:find("action|friends\ndelay|0") then
Friend()
return true
end

if str:find("action|dialog_return\ndialog_name|.-\nbuttonClicked|back\n\n") then
Friend()
return true
end

if str:find("action|wrench\n|netid|(%d+)") then
netid = str:match("action|wrench\n|netid|(%d+)")
if netid then
pid = tonumber(netid)
local playerName

for _, player in pairs(GetPlayerList()) do
if player.netID == pid and pid ~= GetLocal().netID then
playerName = player.name
break
end
end

if playerName then
if pull then
SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..pid.."|\nbuttonClicked|pull")
OnTextOverlay("`wSuccessfully `5Pulling " .. playerName)
return true
elseif kick then
SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..pid.."|\nbuttonClicked|kick")
OnTextOverlay("`wSuccessfully `4Kicking " .. playerName)
return true
elseif ban then
SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..pid.."|\nbuttonClicked|wban")
OnTextOverlay("`wSuccessfully `5Banning " .. playerName)
return true
elseif trade then
SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..pid.."|\nbuttonClicked|trade")
SendPacket(2, " action|trade_cancel\n")
OnTextOverlay("`wSuccessfully `9Trading " .. playerName)
return true
end
end
end
end

if str:find("action|drop\n|itemID|(%d+)") then
itemid = tonumber(str:match("action|drop\n|itemID|(%d+)"))
itemcount = GetItemCount(itemid)
if fastdrop == true then
OnDroppedItem(itemid,itemcount)
OnConsoleMessage("`9Dropped `w"..itemcount.." `3"..growtopia.getItemName(itemid))
end
end

if str:find("/cd (%d+)") then
count = str:match("/cd (%d+)")
OnConsoleMessage("`6/cd "..count)
s = tonumber(count)

if s < 100 then
if GetItemCount(1796) >= s then
OnDroppedItem(1796, s)
OnConsoleMessage("`9Dropped `2"..s.." `cDiamond Lock")
OnTextOverlay("`2Successfully `9Dropped `2"..s.." `cDiamond Lock")
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Dropped `2"..s.." `cDiamond Lock|left|1796|\n"
else
    OnConsoleMessage("`6You're trying to drop `2"..s.." `cDiamond Lock `6but you don't have enough")
OnTextOverlay("`4You don't have that many")
return true
end
else
    local num_7188 = math.floor(s / 100)
local num_1796 = s % 100

if GetItemCount(1796) >= num_1796 and GetItemCount(7188) >= num_7188 then
OnDroppedItem(7188, num_7188)
OnDroppedItem(1796, num_1796)
OnConsoleMessage("`9Dropped `2"..num_7188.." `cBlue Gem Lock and `2"..num_1796.." `cDiamond Lock")
OnTextOverlay("`2Successfully `9Dropped `2"..num_7188.." `cBlue Gem Lock and `2"..num_1796.." `cDiamond Lock")
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Dropped `2"..num_7188.." `cBlue Gem Lock and `2"..num_1796.." `cDiamond Lock|left|7188|1796|\n"
else
    OnConsoleMessage("`6You're trying to drop `2"..s.." `cDiamond Lock `6but you don't have enough")
OnTextOverlay("`4You don't have that many")
return true
end
end
return true
elseif str:find("/dw (%d+)") then
count = str:match("/dw (%d+)")
OnConsoleMessage("`6/dw " .. count)
s = tonumber(count)
if GetItemCount(242) < s then
OnWear(1796)
end

if GetItemCount(242) >= s then
OnDroppedItem(242, count)
OnConsoleMessage("`9Dropped `2" .. count .. " `9World Lock")
OnTextOverlay("`2Successfully `9Dropped `2" .. count .. " `9World Lock")
logdrop = logdrop .. "\nadd_label_with_icon|small|`w[`7" .. os.date("%H:%M") .. "`w] `9You've Dropped `2" .. count .. " `9World Lock|left|242|\n"
elseif GetItemCount(242) < s then
OnConsoleMessage("`6You're trying to drop `2" .. count .. " `9World Lock `6but you don't have it")
OnTextOverlay("`4You don't have that much")
return true
end
return true
elseif str:find("/dd (%d+)") then
count = str:match("/dd (%d+)")
OnConsoleMessage("`6/dd "..count)
s = tonumber(count)
if GetItemCount(1796) < s then
OnWear(242)
OnWear(7188)
end

if GetItemCount(1796) >= s then
OnDroppedItem(1796, count)
OnConsoleMessage("`9Dropped `2"..count.." `cDiamond Lock")
OnTextOverlay("`2Successfully `9Dropped `2"..count.." `cDiamond Lock")
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Dropped `2"..count.." `cDiamond Lock|left|1796|\n"
elseif GetItemCount(1796) < s then
OnConsoleMessage("`6You're trying to drop `2"..count.." `cDiamond Lock `6but you don't have it")
OnTextOverlay("`4You don't have that much")
return true
end
return true
elseif str:find("/db (%d+)") then
count = str:match("/db (%d+)")
OnConsoleMessage("`6/db "..count)
if GetItemCount(7188) < tonumber(count) then
OnConsoleMessage("`6You're trying to drop `2"..count.." `eBlue Gem Lock `6but you don't have it")
OnTextOverlay("`4You don't have that much")
else
    OnDroppedItem(7188,count)
OnConsoleMessage("`9Dropped `2"..count.. " `eBlue Gem Lock")
OnTextOverlay("`9Successfully Dropped `2"..count.." `eBlue Gem Lcok")
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Dropped `2"..count.." `eBlue Gem Lock|left|7188|\n"
end
return true
elseif str:find("/da (%d+)") then
count = str:match("/da (%d+)")
OnConsoleMessage("`6/da "..count)
if GetItemCount(16306) < tonumber(count) then
OnConsoleMessage("`6You're trying to drop `2"..count.." `bAbsolute Lock `6but you don't have it")
OnTextOverlay("`4You don't have that much")
else
    OnDroppedItem(16306,count)
OnConsoleMessage("`9Dropped `2"..count.. " `bAbsolute Lock")
OnTextOverlay("`2Successfully `9Dropped `2"..count.." `bAbsolute Lock")
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Dropped `2"..count.." `bAbsolute Lock|left|16306|\n"
end
return true
elseif str:find("/dw3 (%d+)") then
count = str:match("/dw3 (%d+)")
OnConsoleMessage("`6/dw3 "..count)
count3 = count * 3
s = tonumber(count3)
if GetItemCount(242) < s then
OnWear(1796)
end

if GetItemCount(242) >= s then
OnDroppedItem(242,count3)
OnConsoleMessage("`w(`2"..count.." `9x `23`w) `9Dropped `2"..count3.." `9World Lock")
OnTextOverlay("`2Successfully `9Dropped `2"..count3.." `9World Lcok")
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Dropped `2"..count3.." `9World Lock|left|242|\n"
elseif GetItemCount(242) < s then
OnConsoleMessage("`6You're trying to drop `2" .. count3 .. " `9World Lock `6but you don't have it")
OnTextOverlay("`4You don't have that much")
return true
end
return true
elseif str:find("/dd3 (%d+)") then
count = str:match("/dd3 (%d+)")
OnConsoleMessage("`6/dd3 "..count)
count3 = count * 3
s = tonumber(count3)
if GetItemCount(1796) < s then
OnWear(7188)
OnWear(242)
end

if GetItemCount(1796) >= s then
OnDroppedItem(1796,count3)
OnConsoleMessage("`w(`2"..count.." `9x `23`w) `9Dropped `2"..count3.." `cDiamond Lock")
OnTextOverlay("`2Successfully `9Dropped `2"..count3.." `cDiamond Lcok")
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Dropped `2"..count3.." `cDiamond Lock|left|1796|\n"
elseif GetItemCount(1796) < s then
OnConsoleMessage("`6You're trying to drop `2"..count3.." `cDiamond Lock `6but you don't have it")
OnTextOverlay("`4You don't have that much")
return true
end
return true
elseif str:find("/db3 (%d+)") then
count = str:match("/db3 (%d+)")
OnConsoleMessage("`6/db3 "..count)
count3 = count * 3
if GetItemCount(7188) < tonumber(count3) then
OnConsoleMessage("`6You're trying to drop `2"..count3.." `eBlue Gem Lock `6but you don't have it")
OnTextOverlay("`4You don't have that much")
else
    OnDroppedItem(7188,count3)
OnConsoleMessage("`w(`2"..count.." `9x `23`w) `9Dropped `2"..count3.." `eBlue Gem Lock")
OnTextOverlay("`2Successfully `9Dropped `2"..count3.." `eBlue Gem Lcok")
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Dropped `2"..count3.." `eBlue Gem Lock|left|7188|\n"
end
return true
elseif str:find("/da3 (%d+)") then
count = str:match("/da3 (%d+)")
OnConsoleMessage("`6/sa3 "..count)
count3 = count * 3
if GetItemCount(16306) < tonumber(count3) then
OnConsoleMessage("`6You're trying to drop `2"..count.." `bAbsolute Lock `6but you don't have it")
OnTextOverlay("`4You don't have that much")
else
    OnDroppedItem(16306,count3)
OnConsoleMessage("`w(`2"..count.." `9x `23`w) `9Dropped `2"..count3.." `bAbsolute Lock")
OnTextOverlay("`2Successfully `9Dropped `2"..count3.." `bAbsolute Lock")
logdrop = logdrop.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Dropped `2"..count3.." `bAbsolute Lock|left|16306|\n"
end
return true
end

if str:find("/wrench (%d+)") then
value = str:match("/wrench (%d+)")
OnConsoleMessage("`6/wrench "..value)
if value == "0" then
pull = false
kick = false
ban = false
OnTextOverlay("`2Normal `wWrench `2Mode")
return true
elseif value == "1" then
if pull == false then
pull = true
kick = false
ban = false
trade = false
OnTextOverlay("`2Enabled `wWrench `5Pull")
return true
else
    pull = false
OnTextOverlay("`4Disabled `wWrench `5Pull")
return true
end
elseif value == "2" then
if kick == false then
kick = true
pull = false
ban = false
trade = false
OnTextOverlay("`2Enabled `wWrench `4Kick")
return true
else
    kick = false
OnTextOverlay("`4Disable `wWrench `5Kick")
return true
end
elseif value == "3" then
if ban == false then
ban = true
pull = false
kick = false
trade = false
OnTextOverlay("`2Enabled `wWrench `6Ban")
return true
else
    ban = false
OnTextOverlay("`4Disable `wWrench `6Ban")
return true
end
elseif value == "4" then
if trade == false then
trade = true
ban = false
pull = false
kick = false
OnTextOverlay("`2Enabled `wWrench `cTrade")
return true
else
    trade = false
OnTextOverlay("`4Disable `wWrench `cTrade")
return true
end
else
    OnConsoleMessage("`#Invalid value for '`6/wrench <mode>`#'. `3Use: 0. Default, 1. Pull, 2. Kick, 3. Ban, 4. Trade")
return true
end
end

if str:find("/exit") then
SendPacket(3, "action|quit_to_exit")
return true
elseif str:find("/res") then
SendPacket(2, "action|respawn")
return true
end

if str:find("fcbgl|1") then
cbgl = true
OnTextOverlay("`2Saved")
else if str:find("fcbgl|0") then
cbgl = false
OnTextOverlay("`2Saved")
end
end
if str:find("notifad|1") then
notif = true
OnTextOverlay("`2Saved")
else if str:find("notifad|0") then
notif = false
OnTextOverlay("`2Saved")
end
end
if str:find("sdbb|1") then
sdb = true
OnTextOverlay("`2Saved")
else if str:find("sdbb|0") then
sdb = false
OnTextOverlay("`2Saved")
end
end
if str:find("ap|1") then
autopull = true
OnTextOverlay("`2Saved")
else if str:find("ap|0") then
autopull = false
OnTextOverlay("`2Saved")
end
end
if str:find("gp|1") then
gaspull = true
OnTextOverlay("`2Saved")
else if str:find("gp|0") then
gaspull = false
OnTextOverlay("`2Saved")
end
end
if str:find("taiwl|1") then
cvwl = true
OnTextOverlay("`2Saved")
else if str:find("taiwl|0") then
cvwl = false
OnTextOverlay("`2Saved")
end
end
if str:find("fts|1") then
fasttrash = true
OnTextOverlay("`2Saved")
else if str:find("fts|0") then
fasttrash = false
OnTextOverlay("`2Saved")
end
end
if str:find("fdp|1") then
fastdrop = true
OnTextOverlay("`2Saved")
else if str:find("fdp|0") then
fastdrop = false
OnTextOverlay("`2Saved")
end
end
if str:find("aacc|1") then
autoacc = true
OnTextOverlay("`2Saved")
else if str:find("aacc|0") then
autoacc = false
OnTextOverlay("`2Saved")
end
end
if str:find("vsp|1") then
vspin = true
OnTextOverlay("`2Saved")
else if str:find("vsp|0") then
vspin = false
OnTextOverlay("`2Saved")
end
end

if str:find("/reme") then
OnConsoleMessage("`6/reme")
if reme == false then
reme = true
qeme = false
OnTextOverlay("`2Enabled `9REME Spin Checker")
return true
else
    reme = false
qeme = false
OnTextOverlay("`4Disabled `9REME Spin Checker")
return true
end
end
if str:find("/qeme") then
OnConsoleMessage("`6/qeme")
if qeme == false then
qeme = true
reme = false
OnTextOverlay("`2Enabled `9QEME Spin Checker")
return true
else
    qeme = false
reme = false
OnTextOverlay("`4Disabled `9QEME Spin Checker")
return true
end
end

if str:find("/tp") then
OnConsoleMessage("`6/tp")
if tpdisplay == false then
tpdisplay = true
OnTextOverlay("`2Enabled `9FindPath To Display")
return true
else
    tpdisplay = false
OnTextOverlay("`4Disabled `9FindPath To Display")
return true
end
end

if str:find("/blink") then
OnConsoleMessage("`6/blink")
if blskin == false then
blskin = true
OnTextOverlay("`2Enabled `bBlink Skin")
return true
else
    blskin = false
OnTextOverlay("`4Disabled `bBlink Skin")
return true
end
end

if str:find("/setnumber (%d+)") then
numb = str:match("/setnumber (%d+)")
OnConsoleMessage("`6/setnumber "..numb)
vnumber = numb
if vspin == true then
OnConsoleMessage("`3Visual number has been set to `w"..numb..".")
else
    OnConsoleMessage("`3Visual number has been set to `w"..numb.."`3, `^Enable 'Custom Spin Number (Visual)' on Toggle Options to activate this feature.")
end
return true
end


if str:find("join_request") then
tablelogspin = {}
end

if str:find("/dp (%d+)") or str:find("/deposit (%d+)") then
count = str:match("/dp (%d+)") or str:match("/deposit (%d+)")
OnConsoleMessage("`6/"..str:gsub("action|input\n|text|/", ""))
s = tonumber(count)
local required_16306 = math.floor(s / 100)
local required_7188 = s % 100

if GetItemCount(7188) >= required_7188 and GetItemCount(16306) >= required_16306 then
SendPacket(2,"action|dialog_return\ndialog_name|my_bank_account\nbuttonClicked|deposit")
SendPacket(2,"action|dialog_return\ndialog_name|my_bank_account\nbuttonClicked|depo_true\n\nbgl_|" ..count)
OnTextOverlay("`9Deposited `2"..count.." `eBlue Gem Lock")
OnConsoleMessage("`9Deposited `2"..count.." `eBlue Gem Lock")
else
    OnConsoleMessage("`6You're trying to deposit `2"..count.." `eBlue Gem Lock `6but you don't have enough")
OnTextOverlay("`4You don't have that much")
return true
end
return true
elseif str:find("/wd (%d+)") or str:find("/withdraw (%d+)") then
count = str:match("/wd (%d+)") or str:match("/withdraw (%d+)")
OnConsoleMessage("`6/"..str:gsub("action|input\n|text|/", ""))
SendPacket(2,"action|dialog_return\ndialog_name|my_bank_account\nbuttonClicked|withdraw")
SendPacket(2,"action|dialog_return\ndialog_name|my_bank_account\nbuttonClicked|wd_true\n\nwd_amount|" ..count)
OnTextOverlay("`9Withdraw `2"..count.." `eBlue Gem Lock")
return true
elseif str:find("/depositall") or str:find("/dpall") then
OnConsoleMessage("`6/"..str:gsub("action|input\n|text|/", ""))

local count_7188 = GetItemCount(7188)
local count_16306 = GetItemCount(16306)

local total_bgl = count_7188 + (count_16306 * 100)

if total_bgl > 0 then
SendPacket(2,"action|dialog_return\ndialog_name|my_bank_account\nbuttonClicked|deposit")
SendPacket(2,"action|dialog_return\ndialog_name|my_bank_account\nbuttonClicked|depo_true\n\nbgl_|" ..total_bgl)
OnTextOverlay("`9Deposited `2"..total_bgl.." `eBlue Gem Lock")
OnConsoleMessage("`9Deposited `2"..total_bgl.." `eBlue Gem Lock")
else
    OnConsoleMessage("`6You don't have any `eBlue Gem Locks `6or `bAbsolute Lock `6to deposit")
OnTextOverlay("`4You don't have enough items to deposit")
end
return true
elseif str:find("/withdrawall") or str:find("/wdall") then
OnConsoleMessage("`6/"..str:gsub("action|input\n|text|/", ""))
SendPacket(2,"action|dialog_return\ndialog_name|my_bank_account\nbuttonClicked|withdraw")
SendPacket(2,"action|dialog_return\ndialog_name|my_bank_account\nbuttonClicked|wd_true\n\nwd_amount|200")
OnTextOverlay("`9Withdraw `2200 `eBlue Gem Lock")
return true
end

if str:find("buttonClicked|(%d+)") then
netid = str:match("buttonClicked|(%d+)")
pelerspin(tonumber(netid))
return true
end

return false
end
if edith == true then
AddHook(cmd, "OnSendPacket")
end

function var(var)
if not edith then return end
if var.v1:find("OnConsoleMessage") and var.v2:find("`4Unknown command.") then
OnConsoleMessage("`2Please type `c/proxy `2to get the available commands")
return true
elseif var.v1:find("OnConsoleMessage") and var.v2:find("spun the wheel") and var.v2:find("<") and var.v2:find(">") then
OnConsoleMessage(var.v2.." `w[`4FAKE`w]")
SendVariant({
    v1 = "OnTextOverlay" , v2 = "`9Detected `4FAKE `9Spin"
})
return true
elseif var.v1:find("OnConsoleMessage") and var.v2:find("spun the wheel") then
OnConsoleMessage("`w[`2REAL`w] "..var.v2)
return true
elseif var.v1:find("OnConsoleMessage") and var.v2:find("Collected") and var.v2:find("(%d+) World Lock") then
count = var.v2:match("(%d+) World Lock")
if cvwl == true then
s = tonumber(count)
if GetItemCount(242) >= 100 or s >= 99 then
OnWear(242)
end
end
logcollect = logcollect.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Collected `2"..count.." `9World Lock|left|242|\n"
OnConsoleMessage("`9Collected `2"..count.." `9World Lock")
OnTextOverlay("`9Collected `2"..count.." `9World Lock")
return true
elseif var.v1:find("OnConsoleMessage") and var.v2:find("Collected") and var.v2:find("(%d+) Diamond Lock") then
count = var.v2:match("(%d+) Diamond Lock")
OnConsoleMessage("`9Collected `2"..count.." `cDiamond Lock")
OnTextOverlay("`9Collected `2"..count.." `cDiamond Lock")
logcollect = logcollect.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Collected `2"..count.." `cDiamond Lock|left|1796|\n"
return true
elseif var.v1:find("OnConsoleMessage") and var.v2:find("Collected") and var.v2:find("(%d+) Blue Gem Lock") then
count = var.v2:match("(%d+) Blue Gem Lock")
logcollect = logcollect.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Collected `2"..count.." `eBlue Gem Lock|left|7188|\n"
OnConsoleMessage("`9Collected `2"..count.." `eBlue Gem Lock")
OnTextOverlay("`9Collected `2"..count.." `eBlue Gem Lock")
return true
elseif var.v1:find("OnConsoleMessage") and var.v2:find("Collected") and var.v2:find("(%d+) `bAbsolute Lock") then
count = var.v2:match("(%d+) `bAbsoluteLock")
logcollect = logcollect.."\nadd_label_with_icon|small|`w[`7"..os.date("%H:%M").."`w] `9You've Collected `2"..count.." `bAbsolute Lock|left|16306|\n"
OnConsoleMessage("`9Collected `2"..count.." `bAbsolute Lock")
OnTextOverlay("`9Collected `2"..count.." `bAbsolute Lock")
return true
elseif var.v1:find("OnConsoleMessage") and var.v2:find("World Locked") then
wlcheck = GetItemCount(242)
dlcheck = GetItemCount(1796) * 100
bglcheck = GetItemCount(7188) * 10000
absocheck = GetItemCount(16098) * 1000000
resultscheck = wlcheck + dlcheck + bglcheck + absocheck
OnConsoleMessage(var.v2)
OnConsoleMessage("`pEntered The World, Checking Balance...")
OnConsoleMessage("`pBalance: `2"..resultscheck.." `9World Lock")
return true
elseif var.v1:find("OnConsoleMessage") and var.v2:find("`4WARNING:") then
return true
end

if var.v1:find("OnAddNotification") then
if notif == true then
OnConsoleMessage("`4Detected Notification Adventure. `2Auto Blocks Notifications")
OnConsoleMessage("`9With Notifications: "..var.v3)
return true
end
end

if var.v1:find("OnDialogRequest") and var.v2:find("`2Broadcast from") then
if sdb == true then
OnConsoleMessage("`4Detected SDB. `2Auto Blocks SDB")
return true
end
end

if var.v1:find("OnTalkBubble") and var.v3:find("spun the wheel") then
if reme or qeme then
local num = string.gsub(string.gsub(var.v3:match("and got (.+)"), "!%]", ""), "`", "")
local onlynumber = string.sub(num, 2)
local clearspace = string.gsub(onlynumber, " ", "")
local h = string.gsub(string.gsub(clearspace, "!7", ""), "]", "")
SendVariant({
    v1 = var.v1, v2 = var.v2, v3 = var.v3.." "..getGame(tonumber(h)), v4 = var.v4
})
table.insert(tablelogspin, {
    spin = "\nadd_label_with_icon_button|small|`w[`7"..os.date("%H:%M").."`w] "..var.v3.."|left|758|"..var.v2.."|\n",netid = var.v2
})
return true
end
end

if var.v1:find("OnTalkBubble") and var.v3:find("spun the wheel") then
local vnumber = vnumber

local function getOutput(vnumber)
local output

if vnumber == 0 then
output = "`20"
else
    local prefix = math.random(1, 2) == 1 and "`b" or "`4"
output = prefix .. tostring(vnumber)
end

return output
end

if vspin == true and GetLocal().netID == var.v2 then
SendVariant({
    v1 = var.v1, v2 = var.v2, v3 = "`w["..GetLocal().name.." `wspun the wheel and got "..getOutput(vnumber).."`w!]", v4 = var.v4
})
return true
else
    SendVariant({
    v1 = var.v1, v2 = var.v2, v3 = var.v3, v4 = var.v4
})
table.insert(tablelogspin, {
    spin = "\nadd_label_with_icon_button|small|`w[`7"..os.date("%H:%M").."`w] "..var.v3.."|left|758|"..var.v2.."|\n",netid = var.v2
})
return true
end
end

if var.v1:find("OnDialogRequest") and var.v2:find("`4Recycle") then
itemid = var.v2:match("itemID|(%d+)")
itemcount = var.v2:match("you have (%d+)")
if fasttrash == true then
SendPacket(2, "action|dialog_return\ndialog_name|drop_item\nitemID|" ..itemid.. "|\ncount|" ..itemcount)
return true
end
end

if var.v1:find("OnConsoleMessage") and var.v2:find("wants to add you to a") then
if autoacc == true then
SendPacket(2,"action|dialog_return\ndialog_name|acceptaccess")
return true
end
end

if var.v1:find("OnDialogRequest") and var.v2:find("Wow, that's fast delivery.") then
return true
end

if var.v1:find("OnDialogRequest") and var.v2:find("`bMy Bank") then
return true
end

if var.v1:find("OnDialogRequest") and var.v2:find("`bDeposit") then
return true
end

if var.v1:find("OnDialogRequest") and var.v2:find("`9Withdraw") then
return true
end

if var.v1:find("OnDialogRequest") and var.v2:find("`wBlue Gem Lock") then
return true
end

if var.v1:find("OnDialogRequest") and var.v2:find("`wTelephone") then
if cbgl == true then
x = var.v2:match("embed_data|tilex|(%d+)")
y = var.v2:match("embed_data|tiley|(%d+)")
SendPacket(2,"action|dialog_return\ndialog_name|phonecall\ntilex|"..x.."|\ntiley|"..y.."|\nnum|-34|\nbuttonClicked|turnin")
OnTextOverlay("`2Successfully Change `eBlue Gem Lock")
return true
end
end

if var.v1:find("OnTalkBubble") and var.v3:find("entered,") then
if autopull == true then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..var.v2.."|\nbuttonClicked|pull")
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..var.v2.."|\nbuttonClicked|pull")
end
end

if var.v1:find("OnTalkBubble") and var.v3:lower():find("gas") then
if gaspull == true then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..var.v2.."|\nbuttonClicked|pull")
end
end

if var.v1:find("OnRequestWorldSelectMenu") then
tablelogspin = {}
wlcheck = GetItemCount(242)
dlcheck = GetItemCount(1796) * 100
bglcheck = GetItemCount(7188) * 10000
absocheck = GetItemCount(16098) * 1000000
resultscheck = wlcheck + dlcheck + bglcheck + absocheck
end
return false
end
if edith == true then
AddHook(var, "OnVariant")
end

function raw(a)
if not edith then return end
if tpdisplay == true then
if a.type == 3 and a.value == 18 then
for _, tile in pairs(GetTiles()) do
if tile.fg == 1422 or tile.fg == 2488 then
if tile.x == a.px then
FindPath(math.floor(a.px),math.floor(a.py))
OnTextOverlay("`9Travelling `w(`2"..a.px.."`w,`2"..a.py.."`w)")
end
end
end
end
end
return false
end
if edith == true then
AddHook(raw, "OnSendPacketRaw")
end

if edith == true then
runCoroutine(function()
while true do
if blskin == true then
bskin()
end
end
end)
end