--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--

local licence=[[

==============================================================================
Panel rejstracji (c) piotr00002 <E-mail:piotrek11238@gmail.com >
Wszelkie prawa zastrzezone. Nie masz praw uzywac oraz udostępniać tego kodu bez mojej zgody.

2016-

]]



addEvent("onAuthRequest",true)
addEventHandler("onAuthRequest", root, function(login,password)
    if (not login or not password) then
        local retval={ success=false, komunikat="Nieprawidłowy login/hasło" }
	triggerClientEvent(source, "onAuthResult", root, retval)
	return
    end
	local password= translit(password)
	local login= translit(login)
    local query=string.format("SELECT id,login,gp,premium>NOW() premium, premium premium_data,blokada_ooc>NOW() blokada_ooc,blokada_ooc blokada_ooc_data,blokada_bicia>NOW() blokada_bicia,blokada_bicia blokada_bicia_data,blokada_aj,blokada_pm>NOW() blokada_pm,blokada_pm blokada_pm_data,voice_allowed,uo_sw,uo_sb,uo_cp FROM lss_users WHERE login='%s' AND hash='%s' LIMIT 1", exports.DB:esc(login), md5(string.lower(login) .. "MRFX_01" .. password))
    local wyniki=exports.DB:pobierzWyniki(query)
    if (not wyniki or not wyniki.id) then
        local retval={ success=false, komunikat="Nieprawidłowy login/hasło" }
        triggerClientEvent(source, "onAuthResult", root, retval)
        return
    end
    
    for i,v in ipairs(getElementsByType("player")) do
	local uid=getElementData(v,"auth:uid")
	if (uid and tonumber(uid)==tonumber(wyniki.id)) then
            local retval={ success=false, komunikat="Jesteś już zalogowany/a." }
	    triggerClientEvent(source, "onAuthResult", root, retval)
	    outputDebugString("Proba podwojnego zalogowania na konto " .. wyniki.id .. " ("..wyniki.login..")")
	    return
	end

    end
    -- rejestrujemy logowanie
    exports.DB:zapytanie("INSERT INTO lss_accesslog SET serial='".. exports.DB:esc(getPlayerSerial(source)) .."',ip=INET_ATON('".. exports.DB:esc(getPlayerIP(source)) .."'),user_id="..tonumber(wyniki.id).." ON DUPLICATE KEY UPDATE ts=NOW(),ip=INET_ATON('".. exports.DB:esc(getPlayerIP(source)) .."');")

    setElementData(source,"auth:uid", tonumber(wyniki.id))

    -- sprawdzamy bany
    if (isPlayerBanned(source)) then return end

    -- sprawdzamy mk
    local mk=exports.DB2:pobierzWyniki("select count(distinct user_id) ile_kont from lss_accesslog where serial=? and datediff(now(),ts)<=7", getPlayerSerial(source))
    if mk and mk.ile_kont and mk.ile_kont>3 then
      autobanPlayer(source,"Multi-Account", true)
      return
    end

    -- finalizujemy logowanie

    setElementData(source,"auth:login", wyniki.login)
    setElementData(source,"GP", tonumber(wyniki.gp))

    if (tonumber(wyniki.blokada_ooc)>0) then
	setElementData(source,"kary:blokada_ooc", wyniki.blokada_ooc_data)
    end

    if (tonumber(wyniki.premium)>0) then
	setElementData(source,"premium", wyniki.premium_data)
    end

    if (tonumber(wyniki.blokada_bicia)>0) then
	setElementData(source,"kary:blokada_bicia", wyniki.blokada_bicia_data)
    end
    if (tonumber(wyniki.blokada_pm)>0) then
	setElementData(source,"kary:blokada_pm", wyniki.blokada_pm_data)
    end

    if (wyniki.blokada_aj and tonumber(wyniki.blokada_aj)>0) then
	setElementData(source,"kary:blokada_aj", wyniki.blokada_aj)
    end

    if (wyniki.voice_allowed and tonumber(wyniki.voice_allowed)>0) then
	setElementData(source,"voice", true)
    end

    if (wyniki.uo_sb and tonumber(wyniki.uo_sb)>0) then
		setElementData(source,"uo_sb", true)
    end

    if (wyniki.uo_sw and tonumber(wyniki.uo_sw)>0) then
		setElementData(source,"uo_sw", true)
    end

    if (wyniki.uo_cp and tonumber(wyniki.uo_cp)>0) then
		setElementData(source,"uo_cp", true)
    end

    local retval={ success=true }
    triggerClientEvent(source, "onAuthResult", root, retval)

    setTimer(auth_fetchPlayerCharacters, 500, 1, source, tonumber(wyniki.id))
end)



function translit(tekst)
    tekst=string.gsub(tekst,"ą","a")
    tekst=string.gsub(tekst,"ć","c")
    tekst=string.gsub(tekst,"ę","e")
    tekst=string.gsub(tekst,"ł","l")
    tekst=string.gsub(tekst,"ń","n")
    tekst=string.gsub(tekst,"ó","o")
    tekst=string.gsub(tekst,"ś","s")
    tekst=string.gsub(tekst,"ź","z")
    tekst=string.gsub(tekst,"ż","z")
    tekst=string.gsub(tekst,"Ą","A")
    tekst=string.gsub(tekst,"Ć","C")
    tekst=string.gsub(tekst,"Ę","E")
    tekst=string.gsub(tekst,"Ł","L")
    tekst=string.gsub(tekst,"Ń","N")
    tekst=string.gsub(tekst,"Ó","O")
    tekst=string.gsub(tekst,"Ś","S")
    tekst=string.gsub(tekst,"Ź","Z")
    tekst=string.gsub(tekst,"Ż","Z")
    return tekst
end

addEvent("onAuthRegister", true)
addEventHandler("onAuthRegister", root, function(login,pass)
    if (not login or not pass) then
    local retval={ success=false, komunikat="Wpisz login i hasło." }
	triggerClientEvent(source, "onAuthResult2", root, retval)
	return
    end

    if not (string.len(pass) >= 5 and string.len(login) >= 3) then -- pilnuje by nowe konto składało się z 5 znakowego hasła i 3 znakowego loginu
	local retval={ success=false, komunikat="Hasło:min. 5 znaków, login:min. 3 znaki!" }
	triggerClientEvent(source, "onAuthResult2", root, retval)
	    return
	end
	if ((string.find(login, " ")~=nil) or (string.find(pass, " ")~=nil)) then
	local retval={ success=false, komunikat="Login lub hasło zawierają spacje." } --pilnuje aby login i hasło nie zawierały spacji
	triggerClientEvent(source, "onAuthResult2", root, retval)
	    return
	end
	local query=string.format("SELECT * FROM lss_users WHERE login='%s'", login) -- sprawdza czy nie ma gracza o tym nicku
	local wyniki=exports.DB:pobierzWyniki(query)
    if wyniki then
	local retval={ success=false, komunikat="Istnieje już takie konto." }
	triggerClientEvent(source, "onAuthResult2", root, retval)
	    return
	end
	quiz =1 
	local pass= translit(pass)
	local login= translit(login)
    exports.DB2:zapytanie("INSERT INTO lss_users (login,hash,quiz) VALUES (?,?,?)", login, md5(string.lower(login) .. "MRFX_01" .. pass), quiz)
	    local retval={ success=true }  --zakłada konto
    triggerClientEvent(source, "onAuthResult2", root, retval)
end)

addEvent("onAuthInfo", true)
addEventHandler("onAuthInfo", root, function(login,password)
       if (not login or not password) then
        local retval={ success=false, komunikat="Nieprawidłowy login/hasło" }
	triggerClientEvent(source, "onAuthResult3", root, retval)
	return
    end
	local password= translit(password)
	local login= translit(login)

    local query=string.format("SELECT id,login,gp,registered,premium>NOW() premium, premium premium_data,blokada_ooc>NOW() blokada_ooc,blokada_ooc blokada_ooc_data,blokada_bicia>NOW() blokada_bicia,blokada_bicia blokada_bicia_data,blokada_aj,blokada_pm>NOW() blokada_pm,blokada_pm blokada_pm_data,voice_allowed,uo_sw,uo_sb,uo_cp FROM lss_users WHERE login='%s' AND hash='%s' LIMIT 1", exports.DB:esc(login), md5(string.lower(login) .. "MRFX_01" .. password))
    local wyniki=exports.DB:pobierzWyniki(query)
    if (not wyniki or not wyniki.id) then
        local retval={ success=false, komunikat="Nieprawidłowy login/hasło" }
        triggerClientEvent(source, "onAuthResult3", root, retval)
        return
    end
    
    for i,v in ipairs(getElementsByType("player")) do
	local uid=getElementData(v,"auth:uid")
	if (uid and tonumber(uid)==tonumber(wyniki.id)) then
            local retval={ success=false, komunikat="Jesteś już zalogowany/a." }
	    triggerClientEvent(source, "onAuthResult3", root, retval)
	    outputDebugString("Proba podwojnego zalogowania na konto " .. wyniki.id .. " ("..wyniki.login..")")
	    return
	end

    end
	setElementData(source,"auth:uid", tonumber(wyniki.id))
    if (isPlayerBanned(source)) then return end
    setElementData(source,"auth:login", wyniki.login)
    setElementData(source,"GP", tonumber(wyniki.gp))
	if (tonumber(wyniki.premium)>0) then
	setElementData(source,"premium", wyniki.premium_data)
	else
	setElementData(source,"premium", "Nieaktywne")
    end
	setElementData(source,"registered", wyniki.registered)
	    if (tonumber(wyniki.blokada_ooc)>0) then
	setElementData(source,"kary:blokada_ooc", wyniki.blokada_ooc_data)
	else
	setElementData(source,"kary:blokada_ooc", "Nieaktywna")
    end

    if (tonumber(wyniki.blokada_bicia)>0) then
	setElementData(source,"kary:blokada_bicia", wyniki.blokada_bicia_data)
	else
	setElementData(source,"kary:blokada_bicia", "Nieaktywna")
    end
    if (tonumber(wyniki.blokada_pm)>0) then
	setElementData(source,"kary:blokada_pm", wyniki.blokada_pm_data)
	else
	setElementData(source,"kary:blokada_pm", "Nieaktywna")
    end

    if (wyniki.blokada_aj and tonumber(wyniki.blokada_aj)>0) then
	setElementData(source,"kary:blokada_aj", wyniki.blokada_aj)
	else
	setElementData(source,"kary:blokada_aj", "Nieaktywna")
    end
    local retval={ success=true }
    triggerClientEvent(source, "onAuthResult3", root, retval)
end)

addEvent("onAuthLogout", true)
addEventHandler("onAuthLogout", root, function()
	removeElementData(source,"auth:uid")
    removeElementData(source,"auth:login")
    removeElementData(source,"premium")
	removeElementData(source,"registered")
	removeElementData(source,"kary:blokada_aj")
	removeElementData(source,"kary:blokada_ooc")
	removeElementData(source,"kary:blokada_pm")
	removeElementData(source,"kary:blokada_bicia")
end)

addEvent("onAuthDaneKon", true)
addEventHandler("onAuthDaneKon", root, function()
   local nick= getElementData(source,"auth:login")
   local id= getElementData(source,"auth:uid")
   local gp= getElementData(source,"GP")
   local premium= getElementData(source,"premium")
   local data= getElementData(source,"registered")
   local aj= getElementData(source,"kary:blokada_aj")
   local ooc= getElementData(source,"kary:blokada_ooc")
   local pm= getElementData(source,"kary:blokada_pm")
   local bicia= getElementData(source,"kary:blokada_bicia")
	triggerClientEvent(source, "onAuthDaneInfo", root, nick,id,gp,premium,data,aj,ooc,pm,bicia)
end)

local womanSkins2 = {
    [9]=true,
    [11]=true,
    [12]=true,
    [13]=true,
    [31]=true,
    [40]=true,
    [63]=true,
    [69]=true,
    [86]=true,
    [90]=true,
    [91]=true,
    [92]=true,
    [93]=true,
    [131]=true,
    [141]=true,
    [150]=true,
    [151]=true,
    [152]=true,
    [169]=true,
    [190]=true,
    [191]=true,
    [192]=true,
    [193]=true,
    [211]=true,
    [214]=true,
    [216]=true,
    [224]=true,
    [226]=true,
    [234]=true,
    [263]=true,
    [298]=true,
}



addEvent("onAuthDanePosIle", true)
addEventHandler("onAuthDanePosIle", root, function()
local userid= getElementData(source,"auth:uid")
    local query=string.format("SELECT id,opis,imie,lastseen,pjB,hunger,playtime,created,bank_money,nazwisko,skin,stylewalki,premiumskin,dead,tytul,lastpos,hp,ar,money,newplayer,fingerprint,energy,satiation,ab_spray,stamina FROM lss_characters  WHERE userid=%d", userid)
    local characters2=exports.DB:pobierzTabeleWynikow(query) -- @todo przerobic na DB2
    -- kick jesli gracz nie ma postaci
    if (not characters2 or #characters2<1) then
	triggerClientEvent(source, "onAuthDaneInfoPosKick", root)
	return
    end

    -- przetwarzamy dane
    -- rozbijamy lastpos=1,2,3,4,... na lastpos={1,2,3,4}
    for i,v in ipairs(characters2) do
        if (getElementData(source,"premium") and characters2[i].premiumskin and tonumber(characters2[i].premiumskin) and tonumber(characters2[i].premiumskin)>0) then
            characters2[i].skin=tonumber(characters2[i].premiumskin)
        end
        characters2[i].imie=translit(characters2[i].imie)
        characters2[i].nazwisko=translit(characters2[i].nazwisko)
        characters2[i].lastpos=split(v.lastpos,",")
        local plec = womanSkins2[tonumber(characters2[i].skin)]
        if plec then
            characters2[i].plec = "woman"
        else
            characters2[i].plec = "man"
        end
        for i2,v2 in ipairs(characters2[i].lastpos) do
            characters2[i].lastpos[i2]=tonumber(v2)
        end
    end



triggerClientEvent(source, "onAuthDaneInfoPos", root,characters2)

end)



addEvent("onAuthPostac", true)
addEventHandler("onAuthPostac", root, function(imie,nazwisko)
    if (not imie or not nazwisko) then
        local retval={ success=false, komunikat="Uzupełnij wszytskie pola." }
	    triggerClientEvent(source, "onAuthResult4", root, retval)
        return
    end
		if ((string.find(imie, " ")~=nil) or (string.find(nazwisko, " ")~=nil)) then
	local retval={ success=false, komunikat="Imię lub nazwisko zawierają spacje." } --pilnuje aby imię i nazwisko nie zawierały spacji
	triggerClientEvent(source, "onAuthResult4", root, retval)
	    return
	end
	    if ((string.find(imie, "1")~=nil) or (string.find(imie, "2")~=nil) or (string.find(imie, "3")~=nil) or (string.find(imie, "4")~=nil) or (string.find(imie, "5")~=nil) or (string.find(imie, "6")~=nil) or (string.find(imie, "7")~=nil) or (string.find(imie, "8")~=nil) or (string.find(imie, "9")~=nil)) then
	local retval={ success=false, komunikat="Imię postaci nie może zawierać liczb." } --pilnuje aby postać nie miała liczb w imieniu
	triggerClientEvent(source, "onAuthResult4", root, retval)
	    return
	end
    if ((string.find(nazwisko, "1")~=nil) or (string.find(nazwisko, "2")~=nil) or (string.find(nazwisko, "3")~=nil) or (string.find(nazwisko, "4")~=nil) or (string.find(nazwisko, "5")~=nil) or (string.find(nazwisko, "6")~=nil) or (string.find(nazwisko, "7")~=nil) or (string.find(nazwisko, "8")~=nil) or (string.find(nazwisko, "9")~=nil)) then
	local retval={ success=false, komunikat="Nazwisko postaci nie może zawierać liczb." } --pilnuje aby postac nie miała liczb w nazwisku
	triggerClientEvent(source, "onAuthResult4", root, retval)
	    return
	end
	local query2=string.format("SELECT * FROM lss_characters WHERE imie='%s' and nazwisko='%s'", imie, nazwisko) --sprawdza czy nie ma postaci o takim imieniu i nazwisku
	local wyniki2=exports.DB:pobierzWyniki(query2)
    if wyniki2 then
	local retval={ success=false, komunikat="Istnieje już taka postać." }
	triggerClientEvent(source, "onAuthResult4", root, retval)
	    return
	end
	nick = getElementData(source,"auth:login")
	imie=translit(imie)
	nazwisko=translit(nazwisko)
	local userid =exports.DB2:pobierzWyniki("SELECT id FROM lss_users WHERE login=?", nick).id
local accepted = 1
exports.DB2:zapytanie( "INSERT INTO lss_characters(userid,imie,nazwisko,accepted) VALUES (?,?,?,?)", userid, imie, nazwisko, accepted ) --zakłada postać
    local retval={ success=true }
    triggerClientEvent(source, "onAuthResult4", root, retval)
end)


																			
local womanSkins = {
    [9]=true,
    [11]=true,
    [12]=true,
    [13]=true,
    [31]=true,
    [40]=true,
    [63]=true,
    [69]=true,
    [86]=true,
    [90]=true,
    [91]=true,
    [92]=true,
    [93]=true,
    [131]=true,
    [141]=true,
    [150]=true,
    [151]=true,
    [152]=true,
    [169]=true,
    [190]=true,
    [191]=true,
    [192]=true,
    [193]=true,
    [211]=true,
    [214]=true,
    [216]=true,
    [224]=true,
    [226]=true,
    [234]=true,
    [263]=true,
    [298]=true,
}


--[[ Funkcja pobiera dane gracza, przetwarza je i przesyła do niego.
     Wywoływana jest w procesie autoryzacji ]]--
function auth_fetchPlayerCharacters(player,userid)
    local query=string.format("SELECT c.id,c.opis,c.imie,c.lastseen,c.nazwisko,c.skin,c.stylewalki,c.premiumskin,c.dead,c.tytul,c.lastpos,c.hp,c.ar,c.money,c.newplayer,c.fingerprint,c.energy,c.satiation,c.ab_spray,c.stamina,cc.co_id,cc.rank co_rank,cc.skin co_skin,co.name co_name,cr.name co_rank_name FROM lss_characters c LEFT JOIN lss_character_co cc ON cc.character_id=c.id LEFT JOIN lss_co co ON co.id=cc.co_id LEFT JOIN lss_co_ranks cr ON cr.co_id=cc.co_id AND cc.rank=cr.rank_id WHERE c.userid=%d AND c.accepted=1 ORDER BY c.dead ASC,c.lastseen DESC,id DESC", userid)
    local characters=exports.DB:pobierzTabeleWynikow(query) -- @todo przerobic na DB2
    -- kick jesli gracz nie ma postaci
    if (not characters or #characters<1) then
	kickPlayer(player,"Twoje konto nie ma żadnych przypisanych postaci.")
	return
    end

    -- przetwarzamy dane
    -- rozbijamy lastpos=1,2,3,4,... na lastpos={1,2,3,4}
    for i,v in ipairs(characters) do
        if (getElementData(player,"premium") and characters[i].premiumskin and tonumber(characters[i].premiumskin) and tonumber(characters[i].premiumskin)>0) then
            characters[i].skin=tonumber(characters[i].premiumskin)
        end
        characters[i].imie=translit(characters[i].imie)
        characters[i].nazwisko=translit(characters[i].nazwisko)
        characters[i].lastpos=split(v.lastpos,",")
        local plec = womanSkins[tonumber(characters[i].skin)]
        if plec then
            characters[i].plec = "woman"
        else
            characters[i].plec = "man"
        end
        for i2,v2 in ipairs(characters[i].lastpos) do
            characters[i].lastpos[i2]=tonumber(v2)
        end
    end

    triggerClientEvent(player, "onCharacterSetReceived", root, characters)
end
