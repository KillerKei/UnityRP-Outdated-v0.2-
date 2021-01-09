Config = {}

-- priority list can be any identifier. (hex steamid, steamid34, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
    --Staff
    ["steam:11000010df5cc6d"] = 90, -- Keiron
    ["ssteam:1100001343cdf96"] = 90, -- Mortal
    ["steam:11000013713d911"] = 90, -- Alfie
    ["steam:110000136b52d18"] = 90, -- Kian
    ["steam:1100001012DB6BE"] = 90, -- Toon
    ["steam:110000100a2f5d2"] = 90, -- Mathis
    ["steam:110000132034861"] = 90, -- Cole

    -- Bronze -- 
    ["steam:110000132043956"] = 15, -- 999#4824
    ["steam:11000011a612892"] = 15, -- Lorenzo#0007

    -- Silver --

    -- Gold -- 

    -- Platinum --
    ["steam:110000107b68c56"] = 90, -- Everlicht#0001

    -- LEO + EMS --

    
}

-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 120

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = true

-- how much priority power grace time will give
Config.GracePower = 85

-- how long grace time lasts in seconds
Config.GraceTime = 120

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 60000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Joining UnityRP...",
    connecting = "\xE2\x8F\xB3Connecting to UnityRP...",
    idrr = "\xE2\x9D\x97[URPQueue] Error: Couldn't retrieve any of your id's, try restarting.",
    err = "\xE2\x9D\x97[URPQueue] There was an error",
    pos = "\xF0\x9F\x90\x8CYou are %d/%d in queue \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[URPQueue] Error: Error adding you to connecting list",
    timedout = "\xE2\x9D\x97[URPQueue] Error: Timed out?",
    wlonly = "\xE2\x9D\x97[URPQueue] You must be whitelisted to join this server. To apply, head to : http://discord.gg/GVSmGfhMMD",
    steam = "\xE2\x9D\x97 [URPQueue] Error: Steam must be running"
}