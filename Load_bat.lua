local t = {}

-- Customize your profile ID here
local profileID = "EXP:ACB0BCA2"

local vbsPath = "C:\\Users\\andre\\Documents\\Rockstar Games\\Red Dead Redemption 2\\Profiles\\" .. profileID .. "\\Laucher.vbs"

-- Run VBS as if manually clicked
local function runBAT(path)
    local command = [[
powershell -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath ']] .. path .. [[' -WorkingDirectory ']] .. path:match("(.+)\\") .. [['"
]]
    print("Running VBS as if manually launched...")
    os.execute(command)
end

function t.OnLoad()
    print("Script started from RedLua")
end

function t.OnTick()
    if PLAYER:IS_PLAYER_PLAYING(PLAYER:PLAYER_ID()) and not t.batExecuted then
        runBAT(vbsPath)
        print("BAT file executed after game load")
        t.batExecuted = true
    end
end

function t.OnReload()
    t.batExecuted = false
end

function t.OnStop()
    print("Script stopped")
end

return t

-- Mod created by TyrRakzort – Save Sentinel RDR2 – July 2025. This project is protected by copyright