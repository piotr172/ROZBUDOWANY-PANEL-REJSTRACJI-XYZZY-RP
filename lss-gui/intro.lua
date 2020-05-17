--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local licence=[[

==============================================================================
Panel rejstracji (c) piotr00002 <E-mail:piotrek11238@gmail.com >
Wszelkie prawa zastrzezone. Nie masz praw uzywac oraz udostępniać tego kodu bez mojej zgody.

2016-

]]

local sw,sh=guiGetScreenSize()
local logo_w=sw/2.5
local logo_h=logo_w*124/800
local intro_audio
local intro_step = math.random(0,360000)
local g_l_info, g_e_login, g_e_password, g_l_login, g_l_password, g_b_login, g_nick,g__nick,g_password,g__password,g_imie,g__imie,g_nazwisko,g__nazwisko,g_b_pos,g_l_welcometext,rej,logi,pos,g_b_wroc,g_b_wroc2,g_r_welcometext,g_p_welcometext,g_r_info, g_e_rlogin, g_e_rpassword, g_r_login, g_r_password, g_b_register,g_b_wroc3


function renderLoginBox()
    -- ,352.4 tvn24
--    local x,y,z,dist=1544.17,-1352.96,259.47,100	-- wiezowiec
--	local x,y,z,dist=2418.45,-1220.81,2000.92,10
--    local x,y,z,dist=1128.17,-1495.86,106.66,1		-- market
--    local x,y,z,dist=1176.12,-1172.85,122.96,10		-- tvn24
--    local x,y,z,dist=1479.87,-1663.02,59.79,10		-- urzad miejski

--	local x,y,z,dist=1217.05,-5.75,1001.33,10
	local x,y,z=getElementPosition(localPlayer)
	z=z+5
	local dist=10
    

    intro_step=intro_step+13
--    setCameraMatrix(x,y,z, x-(dist * math.sin(intro_step/4000)),y+(dist * math.cos(intro_step/4000)),z-5,0,50+(3*math.sin(intro_step/1000)))
    setCameraMatrix(x+(3*math.sin(intro_step/4000)),y+3*math.cos(intro_step/4000),z, x-(dist * math.sin(intro_step/4000)),y+(dist * math.cos(intro_step/4000)),z,0,50+(3*math.sin(intro_step/1000)))
    
   dxDrawRectangle(0, sh*1/2-sh/8, sw, sh*1/5, tocolor(0,0,0,200))
    --dxDrawRectangle(0, sh*18/20, sw, sh, tocolor(0,0,0,200))
    dxDrawImage(sh*15/800, sh*9.8/30, logo_w,logo_h, 'img/lss.png') --800x124
end




function displayLoginBox()


	g_l_welcometext=guiCreateLabel(1/30, 12/30, 13/30, 3/30, "Swiezo zainstalowany gamemod Xyzzy-RP.\nPanel rejstracji zrobiony przez: piotr00024",true)

    g_l_info = guiCreateLabel(18.5/30, 8/20, 8/30, 0.03, "Zaloguj się:",true)
    g_l_login = guiCreateLabel(14/30, 9/20, 4/30, 0.03, "Nick:",true)
    guiLabelSetHorizontalAlign(g_l_login, "right")
    guiLabelSetVerticalAlign(g_l_login, "center")
    g_e_login=guiCreateEdit(18.5/30, 9/20, 0.2, 0.03, "", true)
    g_l_password=guiCreateLabel(14/30, 10/20, 4/30, 0.03, "Hasło:", true)
    guiLabelSetHorizontalAlign(g_l_password, "right")
    guiLabelSetVerticalAlign(g_l_password, "center")
    g_e_password=guiCreateEdit(18.5/30, 10/20, 0.2, 0.03, "", true)
    guiEditSetMasked(g_e_password, true)
    g_b_login=guiCreateButton(25/30, 9/20, 4/30, 2.5/30, "Logowanie >", true)
	g_b_wroc3=guiCreateButton(0.5/30, 10/20, 4/30, 2/30, "<Wróc", true)
    addEventHandler("onClientGUIClick", g_b_login, loginHandler, false)

	end
	
function displayRegisterBox()
    --addEventHandler("onClientRender", root, renderLoginBox)
	g_r_welcometext=guiCreateLabel(1/30, 12/30, 13/30, 3/30, "Tutaj zakładasz nowe konto. Wpisz dane do nowego konta w\nodpowiednie miejsca. Gdy wpiszesz naciśnij przycisk Rejstracja.\nPóźniej naciśnij przycisk 'Wróc' i załóż postać.",true)
	g_r_info = guiCreateLabel(18.5/30, 8/20, 8/30, 0.03, "Zarejstruj się:",true)
    g_r_login = guiCreateLabel(14/30, 9/20, 4/30, 0.03, "Nick:",true)
    guiLabelSetHorizontalAlign(g_r_login, "right")
    guiLabelSetVerticalAlign(g_r_login, "center")
    g_e_rlogin=guiCreateEdit(18.5/30, 9/20, 0.2, 0.03, "", true)
    g_r_password=guiCreateLabel(14/30, 10/20, 4/30, 0.03, "Hasło:", true)
    guiLabelSetHorizontalAlign(g_r_password, "right")
    guiLabelSetVerticalAlign(g_r_password, "center")
    g_e_rpassword=guiCreateEdit(18.5/30, 10/20, 0.2, 0.03, "", true)
    guiEditSetMasked(g_e_rpassword, true)
	g_b_register=guiCreateButton(25/30, 9/20, 4/30, 2.5/30, "Rejestracja >", true)
	g_b_wroc=guiCreateButton(0.5/30, 10/20, 4/30, 2/30, "<Wróc", true)
	addEventHandler("onClientGUIClick", g_b_register, registerHandler, false)
end

function displayInfoBox()
	g_i_welcometext=guiCreateLabel(1/30, 12/30, 13/30, 3/30, "Swiezo zainstalowany gamemod Xyzzy-RP.\nPanel rejstracji zrobiony przez: piotr00024",true)

    g_i_info = guiCreateLabel(18.5/30, 8/20, 8/30, 0.03, "Zaloguj się:",true)
    g_i_login = guiCreateLabel(14/30, 9/20, 4/30, 0.03, "Nick:",true)
    guiLabelSetHorizontalAlign(g_i_login, "right")
    guiLabelSetVerticalAlign(g_i_login, "center")
    g_e_ilogin=guiCreateEdit(18.5/30, 9/20, 0.2, 0.03, "", true)
    g_i_password=guiCreateLabel(14/30, 10/20, 4/30, 0.03, "Hasło:", true)
    guiLabelSetHorizontalAlign(g_i_password, "right")
    guiLabelSetVerticalAlign(g_i_password, "center")
    g_e_ipassword=guiCreateEdit(18.5/30, 10/20, 0.2, 0.03, "", true)
    guiEditSetMasked(g_e_ipassword, true)
    g_b_ilogin=guiCreateButton(25/30, 9/20, 4/30, 2.5/30, "Logowanie >", true)
	g_b_wroc2=guiCreateButton(0.5/30, 10/20, 4/30, 2/30, "<Wróc", true)
    addEventHandler("onClientGUIClick", g_b_ilogin, infoHandler, false)
end

function displayPostacBox()
	g_p_welcometext=guiCreateLabel(1/30, 12/30, 13/30, 3/30, "Swiezo zainstalowany gamemod Xyzzy-RP.\nPanel rejstracji zrobiony przez: piotr00024",true)

    g_p_info = guiCreateLabel(18.5/30, 8/20, 8/30, 0.03, "Załóz postać:",true)
    g_p_imie = guiCreateLabel(14/30, 9/20, 4/30, 0.03, "Imię:",true)
    guiLabelSetHorizontalAlign(g_p_imie, "right")
    guiLabelSetVerticalAlign(g_p_imie, "center")
    g_e_pimie=guiCreateEdit(18.5/30, 9/20, 0.2, 0.03, "", true)
    g_p_nazwisko=guiCreateLabel(14/30, 10/20, 4/30, 0.03, "Nazwisko:", true)
    guiLabelSetHorizontalAlign(g_p_nazwisko, "right")
    guiLabelSetVerticalAlign(g_p_nazwisko, "center")
    g_e_pnazwisko=guiCreateEdit(18.5/30, 10/20, 0.2, 0.03, "", true)
    g_b_pzaloz=guiCreateButton(25/30, 9/20, 4/30, 2.5/30, "Załóz postać", true)
	g_b_wroc5=guiCreateButton(0.5/30, 10/20, 4/30, 2/30, "<Wróc", true)
    addEventHandler("onClientGUIClick", g_b_pzaloz, posHandler, false)
end

function displayDaneKBox()
local x,y,z=getElementPosition(localPlayer)
	z=z+5
	local dist=10
    intro_step=intro_step+13
    setCameraMatrix(x+(3*math.sin(intro_step/4000)),y+3*math.cos(intro_step/4000),z, x-(dist * math.sin(intro_step/4000)),y+(dist * math.cos(intro_step/4000)),z,0,50+(3*math.sin(intro_step/1000)))
    
   dxDrawRectangle(260, sh*1/2-sh/4, sw-540, sh*1/2, tocolor(0,0,0,200))
end


function displayDanePosBox()
   dxDrawRectangle(420, sh*1/2-sh/3, sw-540, sh*4/6, tocolor(0,0,0,200))
end

--[[function zapis()

    x, y, z=getElementPosition(localPlayer)
    d=getElementDimension(localPlayer)
	setElementData(localPlayer,"pozycjaguix", ""..x.."")
	setElementData(localPlayer,"pozycjaguiy", ""..y.."")
	setElementData(localPlayer,"pozycjaguiz", ""..z.."")
	setElementData(localPlayer,"dimensiongui", ""..d.."")
	end]]

function daneinfo()
g_d_info = guiCreateLabel(10/30, 5/20, 8/30, 0.09, "Dane konta:",true)
    guiLabelSetHorizontalAlign(g_d_info, "right")
    guiLabelSetVerticalAlign(g_d_info, "center")
  guiSetFont(g_d_info, "sa-gothic")
g_d_nick = guiCreateLabel(10/30, 6.5/20, 5/30, 0.03, "Nick:",true)
g_d_id = guiCreateLabel(10/30, 7.5/20, 5/30, 0.03, "ID konta:",true)
g_d_gp = guiCreateLabel(10/30, 8.5/20, 5/30, 0.03, "GP:",true)
g_d_premium = guiCreateLabel(10/30, 9.5/20, 5/30, 0.03, "Premium:",true)
g_d_data = guiCreateLabel(10/30, 10.5/20, 5/30, 0.03, "Data rejestracji:",true)
g_d_blok_aj = guiCreateLabel(10/30, 11.5/20, 5/30, 0.03, "Blokada AJ:",true)
g_d_blok_ooc = guiCreateLabel(10/30, 12.5/20, 5/30, 0.03, "Blokada OOC:",true)
g_d_blok_pm = guiCreateLabel(10/30, 13.5/20, 5/30, 0.03, "Blokada PM:",true)
g_d_blok_bicia = guiCreateLabel(10/30, 14.5/20, 5/30, 0.03, "Blokada bicia:",true)
g_d_nickl = guiCreateLabel(14/30, 6.5/20, 5/30, 0.03, "",true)
g_d_idl = guiCreateLabel(14/30, 7.5/20, 5/30, 0.03, "",true)
g_d_gpl = guiCreateLabel(14/30, 8.5/20, 5/30, 0.03, "",true)
g_d_premiuml = guiCreateLabel(14/30, 9.5/20, 5/30, 0.03, "",true)
g_d_datal = guiCreateLabel(14/30, 10.5/20, 5/30, 0.03, "",true)
g_d_blok_ajl = guiCreateLabel(14/30, 11.5/20, 5/30, 0.03, "",true)
g_d_blok_oocl = guiCreateLabel(14/30, 12.5/20, 5/30, 0.03, "",true)
g_d_blok_pml = guiCreateLabel(14/30, 13.5/20, 5/30, 0.03, "",true)
g_d_blok_bicial = guiCreateLabel(14/30, 14.5/20, 5/30, 0.03, "",true)
g_b_wroc6=guiCreateButton(0.5/30, 10/20, 4/30, 2/30, "<Wróc", true)
triggerServerEvent("onAuthDaneKon", localPlayer)
end

function daneinfopos1()
triggerServerEvent("onAuthDanePosIle", localPlayer)
g_d_kick = guiCreateLabel(10/30, 5/20, 13/30, 0.10, "",true)
end

local playerCharacters2={}
local current_character2=1
local charsel_fading2=false

function charsel_next2()
    if (charsel_fading2) then return end
    fadeCamera(false)
    charsel_fading2=true
    current_character2=current_character2+1
    if (current_character2>#playerCharacters2) then current_character2=1 end
    setTimer(displayCharacterInfo, 1000, 1)
end

function charsel_prev2()
    if (charsel_fading2) then return end
    fadeCamera(false)
    charsel_fading2=true    
    current_character2=current_character2-1
    if (current_character2<1) then current_character2=#playerCharacters2 end
    setTimer(displayCharacterInfo, 1000, 1)
end

function displayCharacterInfo()
    --triggerEvent("onGUIOptionChange", root, "bg_charsel", true)
    setElementDimension(localPlayer, 1000+tonumber(getElementData(localPlayer,"auth:uid")))
    setElementAlpha(localPlayer, 255)
    toggleAllControls(false)
    setElementPosition(localPlayer, 836.29,-2052.62,12.87)
    setElementRotation(localPlayer, 0,0,180)
    setCameraMatrix(837.29, -2055.62, 14, 837.29, -2052.62, 12.87)
    

    setElementModel(localPlayer, playerCharacters2[current_character2].skin)
    guiSetText(g_d_imi_nazl, playerCharacters2[current_character2].imie .. " " .. playerCharacters2[current_character2].nazwisko)
	guiSetText(g_d_idpl, playerCharacters2[current_character2].id)
	if (playerCharacters2[current_character2].dead and string.len(playerCharacters2[current_character2].dead)>0) then
	stan="Martwa.Powód:"..playerCharacters2[current_character2].dead..""
	else
	stan="Żyje"
	end
	guiSetText(g_d_stanl, stan)
	guiSetText(g_d_skinl, playerCharacters2[current_character2].skin)
	guiSetText(g_d_kontol, playerCharacters2[current_character2].bank_money)
	guiSetText(g_d_przysobiel, playerCharacters2[current_character2].money)
	if playerCharacters2[current_character2].lastseen == nil then
	data="Brak wejść na postać."
	else
	data=playerCharacters2[current_character2].lastseen
	end
	guiSetText(g_d_onlinel, data )
	guiSetText(g_d_stworzonol, playerCharacters2[current_character2].created) 
	if playerCharacters2[current_character2].pjB == "0" then
	praw1="Nie posiada."
	else
	praw1="Posiada."
	end
	guiSetText(g_d_prawl, praw1) 
	guiSetText(g_d_HPl, playerCharacters2[current_character2].hp.."%")
	guiSetText(g_d_hungerl, playerCharacters2[current_character2].satiation.."%")
	guiSetText(g_d_playtimel, playerCharacters2[current_character2].playtime.." minut/y")
    fadeCamera(true)
    charsel_fading2=false
end

addEvent("onAuthDaneInfoPosKick", true)
addEventHandler("onAuthDaneInfoPosKick", resourceRoot, function()
guiSetText(g_d_kick, "Twoje konto nie ma żadnych przypisanych postaci.")
guiLabelSetColor(g_d_kick, 255,0,0)
removeEventHandler("onClientRender", root,displayDanePosBox)
addEventHandler("onClientRender", root, renderLoginBox )
wybieralka2()
setTimer ( destroyElement, 0.2*60*1000, 1, g_d_kick  )
end)


addEvent("onAuthDaneInfoPos", true)
addEventHandler("onAuthDaneInfoPos", resourceRoot, function(characters2)

    playerCharacters2=characters2
g_d_info = guiCreateLabel(16/30, 3.5/20, 8/30, 0.09, "Dane postaci:",true)
    guiLabelSetHorizontalAlign(g_d_info, "right")
    guiLabelSetVerticalAlign(g_d_info, "center")
  guiSetFont(g_d_info, "sa-gothic")
g_d_imi_naz = guiCreateLabel(16/30, 5/20, 5/30, 0.03, "Imie i nazwisko:",true)
g_d_idp = guiCreateLabel(16/30, 6/20, 5/30, 0.03, "ID postaci:",true)
g_d_skin = guiCreateLabel(16/30, 7/20, 5/30, 0.03, "Skin:",true)
g_d_stan = guiCreateLabel(16/30, 8/20, 5/30, 0.03, "Stan:",true)
g_d_HP = guiCreateLabel(16/30, 9/20, 5/30, 0.03, "Stan zdrowia:",true)
g_d_hunger = guiCreateLabel(16/30, 10/20, 5/30, 0.03, "Głod:",true)
g_d_konto = guiCreateLabel(16/30, 11/20, 5/30, 0.03, "Stan konta:",true)
g_d_przysobie = guiCreateLabel(16/30, 12/20, 5/30, 0.03, "Przy sobie($):",true)
g_d_online = guiCreateLabel(16/30, 13/20, 5/30, 0.03, "Ostatnio ONLINE:",true)
g_d_playtime = guiCreateLabel(16/30, 14/20, 5/30, 0.03, "Czas gry:",true)
g_d_stworzono = guiCreateLabel(16/30, 15/20, 5/30, 0.03, "Data stworzenia:",true)
g_d_praw = guiCreateLabel(16/30, 16/20, 5/30, 0.03, "Prawo jazdy Kat.B:",true)
g_d_imi_nazl = guiCreateLabel(20/30, 5/20, 5/30, 0.03, "",true)
g_d_idpl = guiCreateLabel(20/30, 6/20, 5/30, 0.03, "",true)
g_d_skinl = guiCreateLabel(20/30, 7/20, 5/30, 0.03, "",true)
g_d_stanl = guiCreateLabel(20/30, 8/20, 5/30, 0.03, "",true)
g_d_HPl = guiCreateLabel(20/30, 9/20, 5/30, 0.03, "",true)
g_d_hungerl = guiCreateLabel(20/30, 10/20, 5/30, 0.03, "",true)
g_d_kontol = guiCreateLabel(20/30, 11/20, 5/30, 0.03, "",true)
g_d_przysobiel = guiCreateLabel(20/30, 12/20, 5/30, 0.03, "",true)
g_d_onlinel = guiCreateLabel(20/30, 13/20, 5/30, 0.03, "",true)
g_d_playtimel = guiCreateLabel(20/30, 14/20, 5/30, 0.03, "",true)
g_d_stworzonol = guiCreateLabel(20/30, 15/20, 5/30, 0.03, "",true)
g_d_prawl = guiCreateLabel(20/30, 16/20, 5/30, 0.03, "",true)



    

    g_i_charselkeys2=guiCreateStaticImage(sw-187,sh-53,182,48,"img/keys.png",false)
    
    displayCharacterInfo()

    bindKey ( "arrow_r", "up", charsel_next2 )    
    bindKey ( "arrow_l", "up", charsel_prev2 )    


g_b_wroc7=guiCreateButton(0.5/30, 10/20, 4/30, 2/30, "<Wróc", true)
--addEventHandler("onClientRender", root, displayDanePosBox )
end)

addEvent("onAuthDaneInfo", true)
addEventHandler("onAuthDaneInfo", resourceRoot, function(nick,id,gp,premium,data,blokaj,blokooc,blokpm,blokbicia)
guiSetText(g_d_nickl,""..nick.."")
guiSetText(g_d_idl,""..id.."")
guiSetText(g_d_gpl,""..gp.."")
guiSetText(g_d_premiuml,""..premium.."")
guiSetText(g_d_datal,""..data.."")
guiSetText(g_d_blok_ajl,""..blokaj.."")
guiSetText(g_d_blok_oocl,""..blokooc.."")
guiSetText(g_d_blok_pml,""..blokpm.."")
guiSetText(g_d_blok_bicial,""..blokbicia.."")
end)



function wybieralka()
if getElementData(localPlayer, "muzyka") == true then
else
intro_audio=playSound("audio/loni2.ogg",true)
setSoundVolume(intro_audio, 1)
end
    showChat(false)
    showCursor(true)
    setElementAlpha(localPlayer, 0)
	setElementData(localPlayer, "muzyka", true)
    showPlayerHudComponent("all", false)
    addEventHandler("onClientRender", root, renderLoginBox )
	rej=guiCreateButton(7/30, 8.5/20, 4/30, 2.5/30, "Rejstracja", true)
	inf=guiCreateButton(13/30, 8.5/20, 4/30, 2.5/30, "Informacje o koncie.\nZakładanie postaci.", true)
	logi=guiCreateButton(19/30, 8.5/20, 4/30, 2.5/30, "Logowanie", true)
end

function wybieralka2()
	danek=guiCreateButton(7/30, 8.5/20, 4/30, 2.5/30, "Dane konta.", true)
	danepos=guiCreateButton(13/30, 8.5/20, 4/30, 2.5/30, "Postacie.", true)
	pos=guiCreateButton(19/30, 8.5/20, 4/30, 2.5/30, "Zakładanie postaci.", true)
	g_b_wroc4=guiCreateButton(0.5/30, 10/20, 4/30, 2/30, "<Wróc", true)
end


function fadeOutIntroAudio()
    local vol=getSoundVolume(intro_audio)
    vol=vol-0.1
    if (vol<0) then
	stopSound(intro_audio)
	return
    end
    setSoundVolume(intro_audio,vol)
    setTimer(fadeOutIntroAudio, 300, 1)
end

addEventHandler("onClientGUIClick",getRootElement(),
function(button,state)
	if (source == rej) then
destroyElement(rej)
destroyElement(inf)
destroyElement(logi)
displayRegisterBox()
	elseif (source == inf) then
destroyElement(rej)
destroyElement(inf)
destroyElement(logi)
displayInfoBox()
	elseif (source == logi) then
destroyElement(rej)
destroyElement(inf)
destroyElement(logi)
displayLoginBox()
	elseif (source == pos) then
destroyElement(danek)
destroyElement(danepos)
destroyElement(pos)
destroyElement(g_b_wroc4)
displayPostacBox()
	elseif (source == danek) then
destroyElement(danek)
destroyElement(danepos)
destroyElement(pos)
destroyElement(g_b_wroc4)
removeEventHandler("onClientRender", root, renderLoginBox)
addEventHandler("onClientRender", root, displayDaneKBox)
daneinfo()
	elseif (source == danepos) then
destroyElement(danek)
destroyElement(danepos)
destroyElement(pos)
destroyElement(g_b_wroc4)
removeEventHandler("onClientRender", root, renderLoginBox)
addEventHandler("onClientRender", root, displayDanePosBox)
daneinfopos1()
--zapis()
	elseif (source == g_b_wroc) then
	destroyElement(g_r_info)
    destroyElement(g_e_rlogin)
    destroyElement(g_r_login)
    destroyElement(g_b_register)
    destroyElement(g_r_password)
    destroyElement(g_e_rpassword)
	destroyElement(g_r_welcometext)
	destroyElement(g_b_wroc)
	removeEventHandler("onClientRender", root, renderLoginBox)
	wybieralka()
	elseif (source == g_b_wroc2) then
        destroyElement(g_i_welcometext)
        destroyElement(g_i_info)
        destroyElement(g_e_ilogin)
        destroyElement(g_e_ipassword)
        destroyElement(g_i_login)
        destroyElement(g_i_password)
        destroyElement(g_b_ilogin)
	destroyElement(g_b_wroc2)
	removeEventHandler("onClientRender", root, renderLoginBox)
	wybieralka()
	elseif (source == g_b_wroc3) then
        destroyElement(g_l_welcometext)
        destroyElement(g_l_info)
        destroyElement(g_e_login)
        destroyElement(g_e_password)
        destroyElement(g_l_login)
        destroyElement(g_l_password)
        destroyElement(g_b_login)
	destroyElement(g_b_wroc3)
	removeEventHandler("onClientRender", root, renderLoginBox)
	wybieralka()
		elseif (source == g_b_wroc4) then
destroyElement(danek)
destroyElement(danepos)
destroyElement(pos)
destroyElement(g_b_wroc4)
removeEventHandler("onClientRender", root, renderLoginBox)
wybieralka()
triggerServerEvent("onAuthLogout", localPlayer)
		elseif (source == g_b_wroc5) then
destroyElement(g_p_welcometext)
destroyElement(g_p_info)
destroyElement(g_e_pimie)
destroyElement(g_e_pnazwisko)
destroyElement(g_p_imie)
destroyElement(g_p_nazwisko)
destroyElement(g_b_pzaloz)
destroyElement(g_b_wroc5)
wybieralka2()
		elseif (source == g_b_wroc6) then
destroyElement(g_d_info)
destroyElement(g_d_nick)
destroyElement(g_d_id)
destroyElement(g_d_gp)
destroyElement(g_d_premium)
destroyElement(g_d_data)
destroyElement(g_d_blok_aj)
destroyElement(g_d_blok_ooc)
destroyElement(g_d_blok_pm)
destroyElement(g_d_blok_bicia)
destroyElement(g_d_nickl)
destroyElement(g_d_idl)
destroyElement(g_d_gpl)
destroyElement(g_d_premiuml)
destroyElement(g_d_datal)
destroyElement(g_d_blok_ajl)
destroyElement(g_d_blok_oocl)
destroyElement(g_d_blok_pml)
destroyElement(g_d_blok_bicial)
destroyElement(g_b_wroc6)
wybieralka2()
removeEventHandler("onClientRender", root,displayDaneKBox)
addEventHandler("onClientRender", root,  renderLoginBox)
		elseif (source == g_b_wroc7) then
destroyElement(g_d_info)
destroyElement(g_d_imi_naz)
destroyElement(g_d_idp)
destroyElement(g_d_skin)
destroyElement(g_d_stan)
destroyElement(g_d_HP)
destroyElement(g_d_hunger)
destroyElement(g_d_konto)
destroyElement(g_d_przysobie)
destroyElement(g_d_online)
destroyElement(g_d_playtime)
destroyElement(g_d_stworzono)
destroyElement(g_d_praw)
destroyElement(g_d_imi_nazl)
destroyElement(g_d_idpl)
destroyElement(g_d_skinl)
destroyElement(g_d_stanl)
destroyElement(g_d_HPl)
destroyElement(g_d_hungerl)
destroyElement(g_d_kontol)
destroyElement(g_d_przysobiel)
destroyElement(g_d_onlinel)
destroyElement(g_d_playtimel)
destroyElement(g_d_stworzonol)
destroyElement(g_d_prawl)
destroyElement(g_b_wroc7)
destroyElement(g_i_charselkeys2)
    unbindKey ( "arrow_r", "up", charsel_next2 )
    unbindKey ( "arrow_l", "up", charsel_prev2 )
wybieralka2()
removeEventHandler("onClientRender", root,displayDanePosBox)
--[[x=getElementData(localPlayer,"pozycjaguix")
y=getElementData(localPlayer,"pozycjaguiy")
z=getElementData(localPlayer,"pozycjaguix")
d=getElementData(localPlayer,"dimensiongui")
setElementDimension(localPlayer,d)
setElementPosition(localPlayer,x,y,z)]]
addEventHandler("onClientRender", root,  renderLoginBox)
end
end)

function loginHandler()
edit1 = guiGetText(g_e_login)
edit2 = guiGetText(g_e_password)
if (edit1 == "" or edit2== "") then
    local retval={ success=false, komunikat="Wpisz login i hasło." }
	triggerEvent("onAuthResult", root, retval)
return
end
    local login=guiGetText(g_e_login)
    local pass=guiGetText(g_e_password)
    triggerServerEvent("onAuthRequest", localPlayer, login, pass)
end

function registerHandler()
edit3 = guiGetText(g_e_rlogin)
edit4 = guiGetText(g_e_rpassword)
if (edit4 == "" or edit3== "") then
    local retval={ success=false, komunikat="Wpisz login i hasło." }
	triggerEvent("onAuthResult2", root, retval)
return
end
    local login=guiGetText(g_e_rlogin)
    local pass=guiGetText(g_e_rpassword)
    triggerServerEvent("onAuthRegister", localPlayer, login, pass)
end

function infoHandler()
edit5 = guiGetText(g_e_ilogin)
edit6 = guiGetText(g_e_ipassword)
if (edit5 == "" or edit6== "") then
    local retval={ success=false, komunikat="Wpisz login i hasło." }
	triggerEvent("onAuthResult3", root, retval)
return
end
    local login=guiGetText(g_e_ilogin)
    local pass=guiGetText(g_e_ipassword)
    triggerServerEvent("onAuthInfo", localPlayer, login, pass)
end

function posHandler()
edit7 = guiGetText(g_e_pimie)
edit8 = guiGetText(g_e_pnazwisko)
if (edit7 == "" or edit8== "") then
    local retval={ success=false, komunikat="Wpisz login i hasło." }
	triggerEvent("onAuthResult4", root, retval)
return
end
    local imie=guiGetText(g_e_pimie)
    local nazwisko=guiGetText(g_e_pnazwisko)
    triggerServerEvent("onAuthPostac", localPlayer, imie, nazwisko)
end

addEvent("onAuthResult", true)
addEventHandler("onAuthResult", resourceRoot, function(retval)
    if (retval.success) then
	fadeOutIntroAudio()
        showCursor(false)
        fadeCamera(false)
        destroyElement(g_l_welcometext)
        destroyElement(g_l_info)
        destroyElement(g_e_login)
        destroyElement(g_e_password)
        destroyElement(g_l_login)
        destroyElement(g_l_password)
        destroyElement(g_b_login)
		destroyElement(g_b_wroc3)
        removeEventHandler("onClientRender", root, renderLoginBox)
        return
    else
	guiSetText(g_l_info, retval.komunikat or "Wystąpił błąd podczas autoryzacji")
	guiLabelSetColor(g_l_info, 255,0,0)
        return
    end
end)

addEvent("onAuthResult2", true)
addEventHandler("onAuthResult2", resourceRoot, function(retval)
    if (retval.success) then
	guiSetText(g_r_info, "Udało się! Zostałeś zarejstrowany!")
	guiLabelSetColor(g_r_info, 60,255,0)
        return
    else
	guiSetText(g_r_info, retval.komunikat or "Wystąpił błąd podczas autoryzacji")
	guiLabelSetColor(g_r_info, 255,0,0)
        return
    end
end)

addEvent("onAuthResult3", true)
addEventHandler("onAuthResult3", resourceRoot, function(retval)
    if (retval.success) then
        destroyElement(g_i_welcometext)
        destroyElement(g_i_info)
        destroyElement(g_e_ilogin)
        destroyElement(g_e_ipassword)
        destroyElement(g_i_login)
        destroyElement(g_i_password)
        destroyElement(g_b_ilogin)
		destroyElement(g_b_wroc2)
		wybieralka2()
        return
    else
	guiSetText(g_i_info, retval.komunikat or "Wystąpił błąd podczas autoryzacji")
	guiLabelSetColor(g_i_info, 255,0,0)
        return
    end
end)

addEvent("onAuthResult4", true)
addEventHandler("onAuthResult4", resourceRoot, function(retval)
    if (retval.success) then
	guiSetText(g_p_info, "Udało się! Założyłeś postać!")
	guiLabelSetColor(g_p_info, 60,255,0)
        return
    else
	guiSetText(g_p_info, retval.komunikat or "Wystąpił błąd podczas autoryzacji")
	guiLabelSetColor(g_p_info, 255,0,0)
        return
    end
end)

addEvent("displayLoginBox", true)
addEventHandler("displayLoginBox", root, wybieralka)
--addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),wybieralka)
--================================================================= wybor postaci ==========================================================--

local playerCharacters={}
local current_character=1

local g_l_title,g_l_charname,g_l_co,g_i_charselkeys
local g_i_energy, g_i_stamina, g_l_energy, g_l_stamina, g_lv_energy, g_lv_stamina

local charsel_fading=false

function charsel_next()
    if (charsel_fading) then return end
    fadeCamera(false)
    charsel_fading=true
    current_character=current_character+1
    if (current_character>#playerCharacters) then current_character=1 end
    setTimer(displayCharacter, 1000, 1)
end

function charsel_prev()
    if (charsel_fading) then return end
    fadeCamera(false)
    charsel_fading=true    
    current_character=current_character-1
    if (current_character<1) then current_character=#playerCharacters end
    setTimer(displayCharacter, 1000, 1)
end

function charsel_select()
    fadeCamera(true)
    if (charsel_fading) then return end    
    if (playerCharacters[current_character].dead and string.len(playerCharacters[current_character].dead)>0) then
	triggerEvent("onCaptionedEvent", resourceRoot, "Ta postać jest martwa, nie możesz nią grać.", 2)	    
	return
    end

    unbindKey ( "enter", "up", charsel_select )
    unbindKey ( "arrow_r", "up", charsel_next )
    unbindKey ( "arrow_l", "up", charsel_prev )    
	if (type(playerCharacters[current_character].opis)=="string") then
		setElementData(localPlayer, "opis", playerCharacters[current_character].opis)
	end
	playerCharacters[current_character].opis=nil
    setElementData(localPlayer,"character", playerCharacters[current_character])
    bindKey("o","down","chatbox","OOC")
    bindKey("x","down","chatbox","CB")
    bindKey("b","down","chatbox","B")
    bindKey("y","down","chatbox","Krotkofalowka")
    bindKey("u","down","chatbox","Radio")
	setAmbientSoundEnabled( "gunfire", false )
    setTimer(function()

        setElementDimension(localPlayer,0)
	destroyElement(g_l_title)
	destroyElement(g_l_charname)
	destroyElement(g_l_co)
	destroyElement(g_i_charselkeys)
	destroyElement(g_i_stamina)
	destroyElement(g_i_energy)
	destroyElement(g_l_stamina)
	destroyElement(g_l_energy)
	destroyElement(g_lv_stamina)
	destroyElement(g_lv_energy)
    
    triggerEvent("onGUIOptionChange", root, "cinematic", true)
    triggerEvent("onGUIOptionChange", root, "bg_charsel", false)
	triggerServerEvent("introCompleted", localPlayer)
	end, 500,1)
    
end

function displayCharacter()
    triggerEvent("onGUIOptionChange", root, "bg_charsel", true)
    setElementDimension(localPlayer, 1000+tonumber(getElementData(localPlayer,"auth:uid")))
    setElementAlpha(localPlayer, 255)
    toggleAllControls(false)
    setElementPosition(localPlayer, 836.29,-2052.62,12.87)
    setElementRotation(localPlayer, 0,0,180)
    setCameraMatrix(837.29, -2055.62, 14, 837.29, -2052.62, 12.87)
    

    setElementModel(localPlayer, playerCharacters[current_character].skin)
    guiSetText(g_l_charname, playerCharacters[current_character].imie .. " " .. playerCharacters[current_character].nazwisko)
    guiSetText(g_l_title, playerCharacters[current_character].tytul or "Obywatel")
    guiSetText(g_l_co, playerCharacters[current_character].co_name or "")
	
    if (playerCharacters[current_character].dead and string.len(playerCharacters[current_character].dead)>0) then
	triggerEvent("onGUIOptionChange", getRootElement(), "grayscale", true)
	guiSetText(g_l_co, playerCharacters[current_character].dead)
    else
    	triggerEvent("onGUIOptionChange", getRootElement(), "grayscale", false)
    end

    guiSetText(g_lv_stamina, tostring(playerCharacters[current_character].stamina))
    guiSetText(g_lv_energy, tostring(playerCharacters[current_character].energy))
    fadeCamera(true)
    charsel_fading=false
end

addEvent("onCharacterSetReceived", true)
addEventHandler("onCharacterSetReceived", resourceRoot, function(characters)
    -- dimension: 10000+uid
    playerCharacters=characters
    g_l_title=guiCreateLabel(15.5/30, 8.5/30, 14/30, 6/30, "",true)
    guiLabelSetColor(g_l_title,0,0,0)
    guiSetFont(g_l_title, "default-bold-small")
    g_l_charname=guiCreateLabel(15/30, 9/30, 14/30, 6/30, "",true)
    guiSetFont(g_l_charname, "sa-gothic")

    g_l_co=guiCreateLabel(15/30, 11/30, 14/30, 6/30, "",true)
    guiSetFont(g_l_co, "clear-normal")

    g_i_stamina=guiCreateStaticImage(sw*15/30, sh*13/30, 32, 32, "img/icon_stamina.png",false)
    g_i_energy=guiCreateStaticImage(sw*15/30, sh*15/30, 32, 32, "img/icon_energy.png",false)
    g_l_stamina=guiCreateLabel(17/30, 13/30, 10/30, 6/30, "Stamina",true)
    g_l_energy=guiCreateLabel(17/30, 15/30, 10/30, 6/30, "Energia/siła",true)
    guiSetFont(g_l_stamina, "default-small")
    guiSetFont(g_l_energy, "default-small")
    
    g_lv_stamina=guiCreateLabel(17/30, 13.5/30, 10/30, 6/30, "300",true)
    g_lv_energy=guiCreateLabel(17/30, 15.5/30, 10/30, 6/30, "300",true)
    guiSetFont(g_lv_stamina, "default-bold-small")
    guiSetFont(g_lv_energy, "default-bold-small")
    
    g_i_charselkeys=guiCreateStaticImage(sw-187,sh-53,182,48,"img/keys.png",false)
    
    displayCharacter()

    bindKey ( "enter", "up", charsel_select )
    bindKey ( "arrow_r", "up", charsel_next )    
    bindKey ( "arrow_l", "up", charsel_prev )    
end)