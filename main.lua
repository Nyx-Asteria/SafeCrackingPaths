-- Safe Cracking Paths
-- Route navigation and custom route management.
local prettyui = assert(PrettyUI or prettyui, "PrettyUI dependency unavailable")

local STOP_NAMES = {
    ["001"] = "Edgeville: General Store",
    ["002"] = "Varrock: Palace",
    ["003"] = "Draynor: Manor",
    ["004"] = "Draynor: Wise Old Man’s House",
    ["005"] = "Draynor: Wizards’ Tower",
    ["006"] = "Lumbridge: Bob’s Axes",
    ["007"] = "Lumbridge: Roddeck’s House",
    ["008"] = "Menaphos: Merchant District",
    ["009"] = "Menaphos: Port District",
    ["010"] = "Menaphos: Imperial District",
    ["011"] = "Al Kharid",
    ["012"] = "Nardah: Mayor’s House",
    ["013"] = "Pollnivneach: Mayor’s House",
    ["014"] = "Asgarnia: Black Knights' Fortress",
    ["015"] = "Burthorpe: Castle",
    ["016"] = "Port Sarim: Jewellery Store",
    ["017"] = "Port Sarim: Brian's Battleaxe Bazaar",
    ["018"] = "Falador: Gardener's House",
    ["019"] = "Falador: House North of Fountain",
    ["020"] = "Falador: House East of Fountain",
    ["021"] = "Falador: South Mining Guild House",
    ["022"] = "Camelot: Castle",
    ["023"] = "Yanille: South Wall",
    ["024"] = "Yanille: The Dragon Inn",
    ["025"] = "Ardougne: Jimmy Dazzler’s House",
    ["026"] = "Ardougne: Castle",
    ["027"] = "Ardougne: House West of Silk Stall",
    ["028"] = "Ardougne: House North of Market",
    ["029"] = "Wilderness: Rogues' Den",
    ["030"] = "Zanaris: Market",
    ["031"] = "Wilderness: Zemouregal's Fort",
}

-- Safe locations and ordered actions, including floor transitions.
local STOP_DATA = {["001"] = {["name"] = "Edgeville: General Store", ["steps"] = {{["action"] = "Climb-up", ["detail"] = "Climb the ladder in the general store.", ["travel"] = "Easiest travel: Edgeville lodestone.", ["object"] = "Ladder", ["x"] = 3082, ["y"] = 3513, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 3084, ["y"] = 3507, ["plane"] = 1, ["detail"] = "Upstairs in the general store."}}}, ["002"] = {["name"] = "Varrock: Palace", ["steps"] = {{["action"] = "Climb-up", ["detail"] = "Travel to Varrock Palace and climb the stairs.", ["travel"] = "Varrock Teleport is closer but costs runes; Varrock lodestone is free.", ["object"] = "Staircase", ["x"] = 3212, ["y"] = 3473, ["plane"] = 0, ["advancePlane"] = 1}, {["action"] = "Climb-up", ["detail"] = "Go through the doors and climb the ladder.", ["object"] = "Ladder", ["x"] = 3224, ["y"] = 3472, ["plane"] = 1, ["advancePlane"] = 2}, {["object"] = "Safe", ["x"] = 3200, ["y"] = 3473, ["plane"] = 2, ["detail"] = "Pick-lock the treasury door (may take several attempts) to reach this safe."}, {["object"] = "Safe", ["x"] = 3200, ["y"] = 3471, ["plane"] = 2}, {["object"] = "Safe", ["x"] = 3203, ["y"] = 3469, ["plane"] = 2}}}, ["003"] = {["name"] = "Draynor: Manor", ["steps"] = {{["object"] = "Safe", ["x"] = 3104, ["y"] = 3362, ["plane"] = 0, ["detail"] = "First safe in Draynor Manor.", ["travel"] = "Travel: Draynor lodestone."}, {["object"] = "Safe", ["x"] = 3104, ["y"] = 3355, ["plane"] = 0, ["detail"] = "Second safe in Draynor Manor."}}}, ["004"] = {["name"] = "Draynor: Wise Old Man’s House", ["steps"] = {{["action"] = "Climb-up", ["detail"] = "Enter the Wise Old Man’s house and climb the stairs.", ["travel"] = "Travel: Draynor lodestone.", ["object"] = "Stairs", ["x"] = 3091, ["y"] = 3251, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 3094, ["y"] = 3251, ["plane"] = 1}}}, ["005"] = {["name"] = "Draynor: Wizards’ Tower", ["steps"] = {{["action"] = "Reach the tower second floor", ["detail"] = "Wicked hood: teleport to Runecrafting Guild and descend via the beam. Alternatively, travel from Draynor and ascend using the beam.", ["travel"] = "Fastest: Wicked hood → Runecrafting Guild. Alternative: Draynor lodestone.", ["object"] = "Beam", ["x"] = 3102, ["y"] = 3155, ["plane"] = 1, ["advancePlane"] = 2, ["alternativePlanes"] = {0, 3}}, {["object"] = "Safe", ["x"] = 3096, ["y"] = 3154, ["plane"] = 2}, {["object"] = "Safe", ["x"] = 3109, ["y"] = 3156, ["plane"] = 2}}}, ["006"] = {["name"] = "Lumbridge: Bob’s Axes", ["steps"] = {{["action"] = "Climb-up", ["detail"] = "Climb the stairs inside Bobs Axes.", ["travel"] = "Travel: Lumbridge lodestone.", ["object"] = "Stairs", ["x"] = 3230, ["y"] = 3204, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 3233, ["y"] = 3203, ["plane"] = 1}}}, ["007"] = {["name"] = "Lumbridge: Roddeck’s House", ["steps"] = {{["action"] = "Climb-down", ["detail"] = "Return to the ground floor.", ["object"] = "Stairs", ["x"] = 3230, ["y"] = 3205, ["plane"] = 1, ["advancePlane"] = 0}, {["action"] = "Climb-up", ["detail"] = "Enter Roddecks house and climb the stairs.", ["object"] = "Stairs", ["x"] = 3232, ["y"] = 3239, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 3229, ["y"] = 3238, ["plane"] = 1}}}, ["008"] = {["name"] = "Menaphos: Merchant District", ["steps"] = {{["object"] = "Safe", ["x"] = 3201, ["y"] = 2789, ["plane"] = 0, ["detail"] = "Across from the silk stall.", ["travel"] = "Merchant District teleport for direct access, or Menaphos lodestone."}, {["object"] = "Safe", ["x"] = 3244, ["y"] = 2779, ["plane"] = 0, ["detail"] = "By the general store."}}}, ["009"] = {["name"] = "Menaphos: Port District", ["steps"] = {{["object"] = "Safe", ["x"] = 3166, ["y"] = 2630, ["plane"] = 0, ["travel"] = "Port District teleport for direct access, or Menaphos lodestone."}}}, ["010"] = {["name"] = "Menaphos: Imperial District", ["steps"] = {{["object"] = "Safe", ["x"] = 3120, ["y"] = 2682, ["plane"] = 0, ["travel"] = "Imperial District teleport for direct access, or Menaphos lodestone."}, {["object"] = "Safe", ["x"] = 3095, ["y"] = 2720, ["plane"] = 0, ["detail"] = "Requires tier 5 Imperial District reputation. Checks automatically; use Skip step if unavailable.", ["optional"] = true}}}, ["011"] = {["name"] = "Al Kharid", ["steps"] = {{["object"] = "Safe", ["x"] = 3296, ["y"] = 3189, ["plane"] = 0, ["travel"] = "Teleport to Al Kharid lodestone."}, {["action"] = "Climb-up", ["detail"] = "Climb the steps to the upstairs safe.", ["object"] = "Steps", ["x"] = 3283, ["y"] = 3187, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 3289, ["y"] = 3192, ["plane"] = 1}}}, ["012"] = {["name"] = "Nardah: Mayor’s House", ["steps"] = {{["action"] = "Climb-up", ["detail"] = "Climb the staircase in Nardah.", ["travel"] = "Fastest: Desert amulet 2/3/4 teleport to Nardah. Alternatives: magic carpet, fairy ring DLQ or other desert travel.", ["object"] = "Staircase", ["x"] = 3444, ["y"] = 2911, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 3444, ["y"] = 2909, ["plane"] = 1}}}, ["013"] = {["name"] = "Pollnivneach: Mayor’s House", ["steps"] = {{["object"] = "Safe", ["x"] = 3366, ["y"] = 2974, ["plane"] = 0, ["travel"] = "From Nardah, take the magic carpet to South Pollnivneach."}, {["object"] = "Safe", ["x"] = 3366, ["y"] = 2976, ["plane"] = 0}}}, ["014"] = {["name"] = "Asgarnia: Black Knights' Fortress", ["steps"] = {{["action"] = "Climb down", ["detail"] = "Use the staircase to descend from the upper floor.", ["travel"] = "Fastest: Skull of Remembrance teleport.", ["object"] = "Staircase", ["x"] = 3031, ["y"] = 3577, ["plane"] = 3, ["advancePlane"] = 2}, {["object"] = "Safe", ["x"] = 3014, ["y"] = 3568, ["plane"] = 2}, {["object"] = "Safe", ["x"] = 3018, ["y"] = 3568, ["plane"] = 2}}}, ["015"] = {["name"] = "Burthorpe: Castle", ["steps"] = {{["action"] = "Climb up", ["object"] = "Ladder", ["x"] = 2894, ["y"] = 3559, ["plane"] = 0, ["advancePlane"] = 2, ["travel"] = "Teleport to Burthorpe lodestone."}, {["object"] = "Safe", ["x"] = 2898, ["y"] = 3566, ["plane"] = 2}, {["object"] = "Safe", ["x"] = 2898, ["y"] = 3567, ["plane"] = 2}}}, ["016"] = {["name"] = "Port Sarim: Jewellery Store", ["steps"] = {{["action"] = "Climb up", ["object"] = "Ladder", ["x"] = 3013, ["y"] = 3244, ["plane"] = 0, ["advancePlane"] = 1, ["travel"] = "Teleport to Port Sarim lodestone."}, {["object"] = "Safe", ["x"] = 3017, ["y"] = 3244, ["plane"] = 1}, {["action"] = "Climb down", ["object"] = "Ladder", ["x"] = 3013, ["y"] = 3244, ["plane"] = 1, ["advancePlane"] = 0}}}, ["017"] = {["name"] = "Port Sarim: Brian's Battleaxe Bazaar", ["steps"] = {{["action"] = "Climb-up", ["object"] = "Staircase", ["x"] = 3023, ["y"] = 3248, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 3025, ["y"] = 3246, ["plane"] = 1}}}, ["018"] = {["name"] = "Falador: Gardener's House", ["steps"] = {{["object"] = "Safe", ["x"] = 3029, ["y"] = 3379, ["plane"] = 0, ["travel"] = "Teleport to Falador lodestone."}}}, ["019"] = {["name"] = "Falador: House North of Fountain", ["steps"] = {{["action"] = "Climb-up", ["object"] = "Staircase", ["x"] = 3034, ["y"] = 3363, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 3034, ["y"] = 3361, ["plane"] = 1}, {["action"] = "Climb-down", ["object"] = "Staircase", ["x"] = 3035, ["y"] = 3363, ["plane"] = 1, ["advancePlane"] = 0}}}, ["020"] = {["name"] = "Falador: House East of Fountain", ["steps"] = {{["action"] = "Climb-up", ["object"] = "Staircase", ["x"] = 3048, ["y"] = 3352, ["plane"] = 0, ["advancePlane"] = 1}, {["action"] = "Climb-up", ["object"] = "Ladder", ["x"] = 3050, ["y"] = 3355, ["plane"] = 1, ["advancePlane"] = 2}, {["object"] = "Safe", ["x"] = 3048, ["y"] = 3355, ["plane"] = 2}, {["action"] = "Climb-down", ["object"] = "Ladder", ["x"] = 3050, ["y"] = 3355, ["plane"] = 2, ["advancePlane"] = 1}, {["action"] = "Climb-down", ["object"] = "Staircase", ["x"] = 3049, ["y"] = 3353, ["plane"] = 1, ["advancePlane"] = 0}}}, ["021"] = {["name"] = "Falador: South Mining Guild House", ["steps"] = {{["action"] = "Climb-up", ["object"] = "Staircase", ["x"] = 3021, ["y"] = 3332, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 3023, ["y"] = 3335, ["plane"] = 1}}}, ["022"] = {["name"] = "Camelot: Castle", ["steps"] = {{["object"] = "Safe", ["x"] = 2749, ["y"] = 3500, ["plane"] = 0, ["travel"] = "Camelot Teleport spell or Seers’ Village lodestone."}, {["object"] = "Safe", ["x"] = 2751, ["y"] = 3500, ["plane"] = 0}}}, ["023"] = {["name"] = "Yanille: South Wall", ["steps"] = {{["object"] = "Safe", ["x"] = 2533, ["y"] = 3084, ["plane"] = 0, ["travel"] = "Fastest: Yanille lodestone teleport."}}}, ["024"] = {["name"] = "Yanille: The Dragon Inn", ["steps"] = {{["action"] = "Climb up", ["object"] = "Ladder", ["x"] = 2556, ["y"] = 3081, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 2556, ["y"] = 3077, ["plane"] = 1}}}, ["025"] = {["name"] = "Ardougne: Jimmy Dazzler’s House", ["steps"] = {{["action"] = "Climb-up", ["object"] = "Staircase", ["x"] = 2565, ["y"] = 3322, ["plane"] = 0, ["advancePlane"] = 1, ["travel"] = "Teleport to Ardougne lodestone."}, {["object"] = "Safe", ["x"] = 2568, ["y"] = 3322, ["plane"] = 1}, {["action"] = "Climb-down", ["object"] = "Staircase", ["x"] = 2565, ["y"] = 3322, ["plane"] = 1, ["advancePlane"] = 0}}}, ["026"] = {["name"] = "Ardougne: Castle", ["steps"] = {{["action"] = "Climb-up", ["object"] = "Staircase", ["x"] = 2571, ["y"] = 3285, ["plane"] = 0, ["advancePlane"] = 1, ["alternateTargets"] = {{["x"] = 2571, ["y"] = 3307, ["plane"] = 0}}, ["detail"] = "Either highlighted staircase works."}, {["object"] = "Safe", ["x"] = 2574, ["y"] = 3305, ["plane"] = 1}, {["object"] = "Safe", ["x"] = 2574, ["y"] = 3288, ["plane"] = 1}}}, ["027"] = {["name"] = "Ardougne: House West of Silk Stall", ["steps"] = {{["action"] = "Climb-up", ["object"] = "Staircase", ["x"] = 2649, ["y"] = 3297, ["plane"] = 0, ["advancePlane"] = 1, ["travel"] = "Fastest: Ardougne Teleport spell."}, {["object"] = "Safe", ["x"] = 2649, ["y"] = 3301, ["plane"] = 1}, {["action"] = "Climb-down", ["object"] = "Staircase", ["x"] = 2649, ["y"] = 3297, ["plane"] = 1, ["advancePlane"] = 0}}}, ["028"] = {["name"] = "Ardougne: House North of Market", ["steps"] = {{["action"] = "Climb-up", ["object"] = "Staircase", ["x"] = 2663, ["y"] = 3321, ["plane"] = 0, ["advancePlane"] = 1}, {["object"] = "Safe", ["x"] = 2655, ["y"] = 3319, ["plane"] = 1}}}, ["029"] = {["name"] = "Wilderness: Rogues' Den", ["steps"] = {{["action"] = "Climb-up", ["object"] = "Staircase", ["x"] = 3280, ["y"] = 3936, ["plane"] = 0, ["advancePlane"] = 1, ["travel"] = "Easiest: Use a POH or portable Wilderness obelisk to teleport to level 50 Wilderness. Other routes to level 50 Wilderness also work."}, {["object"] = "Safe", ["x"] = 3296, ["y"] = 3934, ["plane"] = 1}, {["object"] = "Safe", ["x"] = 3295, ["y"] = 3932, ["plane"] = 1}, {["object"] = "Safe", ["x"] = 3293, ["y"] = 3933, ["plane"] = 1}}}, ["030"] = {["name"] = "Zanaris: Market", ["steps"] = {{["object"] = "Safe", ["x"] = 2468, ["y"] = 4421, ["plane"] = 0, ["travel"] = "Easiest: Use a fairy ring in your POH or a portable fairy ring to teleport to Zanaris."}, {["object"] = "Safe", ["x"] = 2479, ["y"] = 4447, ["plane"] = 0}}}, ["031"] = {["name"] = "Wilderness: Zemouregal's Fort", ["steps"] = {{["action"] = "Leave", ["object"] = "Exit", ["x"] = 4196, ["y"] = 5756, ["plane"] = 0, ["exitTransition"] = true, ["travel"] = "Easiest: Use a fairy ring in your POH or a portable fairy ring, code DKQ. Leave through the highlighted exit to reach the Wilderness safes."}, {["object"] = "Safe", ["x"] = 2843, ["y"] = 3847, ["plane"] = 0}, {["object"] = "Safe", ["x"] = 2841, ["y"] = 3847, ["plane"] = 0}, {["object"] = "Safe", ["x"] = 2839, ["y"] = 3847, ["plane"] = 0}, {["object"] = "Safe", ["x"] = 2837, ["y"] = 3847, ["plane"] = 0}}}}

-- Keep the built-in routes in their original player-facing order.
-- Route selector uses ordered numeric IDs and clean labels.
local ROUTES = {
    { id = "misthalin", name = "Misthalin", ids = {"001", "002", "003", "004", "005", "006", "007"} },
    { id = "desert", name = "Kharidian Desert", ids = {"008", "009", "010", "011", "012", "013"} },
    { id = "menaphos", name = "Menaphos Only", ids = {"008", "009", "010"} },
    { id = "asgarnia", name = "Asgarnia", ids = {"014", "015", "016", "017", "018", "019", "020", "021"} },
    { id = "kandarin", name = "Kandarin", ids = {"022", "023", "024", "025", "026", "027", "028"} },
    { id = "hidden", name = "Hidden", ids = {"029", "030", "031"} },
    { id = "allSafes", name = "All Safes", ids = {"001", "002", "003", "004", "005", "006", "007", "008", "009", "010", "011", "012", "013", "014", "015", "016", "017", "018", "019", "020", "021", "022", "023", "024", "025", "026", "027", "028", "029", "030", "031"} },
}

local state = {
    route = 1, step = 1, overlay = "highlight", running = false, completed = false,
    customIDs = {}, customRoutes = {},
    editing = nil, selectedStop = 1,
}
-- Both windows share the same route state.
local pathsWindow, customWindow, hubRoot
local routeSelector = nil
local progressLabel, objectiveLabel, travelLabel, routeList, startButton, endButton
local savedCombo, nameField, locationCombo, customList, customFeedback
local selectedIndex = 1
local BUILTIN_ROUTE_COUNT = #ROUTES
local tracking = { lastPosition = nil, note = "Waiting for player position", lastObject = nil }
local TRACK_EVENT = "safecracking-tracking"
local HUB_EVENT = "safecracking-launcher"

local function route() return ROUTES[state.route] end
local function currentIDs() return route().ids end
local function copyIDs(ids)
    local result = {}
    for i, id in ipairs(ids) do result[i] = id end
    return result
end
local function feedback(message)
    if customFeedback then customFeedback.content = message end
end
-- Build the ordered action list for the selected route.
local function actionsForRoute()
    local result = {}
    for locationIndex, stopID in ipairs(currentIDs()) do
        local location = STOP_DATA[stopID]
        if location then
            for actionIndex, action in ipairs(location.steps) do
                result[#result + 1] = {stopID = stopID, locationIndex = locationIndex,
                    actionIndex = actionIndex, location = location.name, action = action}
            end
        end
    end
    return result
end
local function activeAction()
    return actionsForRoute()[state.step]
end

local function matchesTarget(coord, action)
    if not coord or not action then return false end
    if coord.level ~= action.plane then return false end
    if coord.x == action.x and coord.z == action.y then return true end
    for _, alternate in ipairs(action.alternateTargets or {}) do
        if coord.level == alternate.plane and coord.x == alternate.x and coord.z == alternate.y then
            return true
        end
    end
    return false
end

-- Count actual safes rather than locations or travel actions.
local function safeCount(ids)
    local count = 0
    for _, stopID in ipairs(ids) do
        local stop = STOP_DATA[stopID]
        if stop then
            for _, action in ipairs(stop.steps) do
                if action.object == "Safe" then count = count + 1 end
            end
        end
    end
    return count
end

local function safeProgress(actions, step, completed)
    local cracked = 0
    for index, entry in ipairs(actions) do
        if index < step and entry.action.object == "Safe" then
            cracked = cracked + 1
        end
    end
    local total = safeCount(currentIDs())
    if completed then cracked = total end
    return cracked, total
end

local function updateRouting()
    local actions = actionsForRoute()
    local total = #actions
    if total == 0 then return end
    state.step = math.max(1, math.min(state.step, total))
    local item = actions[state.step]
    local action = item.action
    local label = action.action or (action.object == "Safe" and "Crack safe" or "Interact")
    local percent = state.completed and 100 or math.floor((state.step - 1) / total * 100)
    local cracked, totalSafes = safeProgress(actions, state.step, state.completed)
    if progressLabel then progressLabel.content = string.format("%d%% | Action %d / %d | Safes %d / %d", percent, state.step, total, cracked, totalSafes) end
    if objectiveLabel then objectiveLabel.content = state.completed and "Route complete" or string.format("%s: %s", item.location, label) end
    if travelLabel then
        local description = action.detail or (action.object and ("Target: " .. action.object) or "Proceed to the target")
        if action.optional then description = description .. " (Optional)" end
        local travel = action.travel and (" | " .. action.travel) or ""
        travelLabel.content = description .. travel
    end
    if routeList then
        local entries = {}
        for i, entry in ipairs(actions) do
            local a = entry.action
            local name = a.action or (a.object == "Safe" and "Crack safe" or "Interact")
            entries[i] = {id = i, label = string.format("%s %02d  %s - %s", i < state.step and "[x]" or (i == state.step and ">" or " "), i, entry.location, name)}
        end
        routeList:SetEntries(entries)
    end
end
local function updatePlayerTracking()
    local player = Player.GetEntity()
    local coord = player and player.coordGrid
    if not coord then
        tracking.lastPosition = nil
        tracking.note = "Waiting for player position"
        return
    end

    local previous = tracking.lastPosition
    tracking.lastPosition = {x = coord.x, z = coord.z, level = coord.level}
    local item = activeAction()
    if not item or state.completed then return end
    local action = item.action
    local dx, dz = coord.x - action.x, coord.z - action.y
    local distance = math.floor(math.sqrt(dx * dx + dz * dz) + 0.5)
    tracking.note = string.format("%d tiles | Floor %d/%d", distance, coord.level, action.plane)

    -- A floor transition is meaningful only when it starts at the correct
    -- staircase and arrives on the expected floor. Safe interactions are not
    -- inferred from position alone.
    if state.running and previous and action.advancePlane ~= nil and previous.level == action.plane
        and coord.level == action.advancePlane then
        local from = {x = previous.x, z = previous.z, level = previous.level}
        if matchesTarget(from, action) or
            (math.abs(from.x - action.x) <= 2 and math.abs(from.z - action.y) <= 2) then
            if state.step >= #actionsForRoute() then
                state.running, state.completed = false, true
                if startButton then startButton.label = "Restart route" end
            else
                state.step = state.step + 1
            end
            tracking.note = "Floor transition detected"
            updateRouting()
        end
    end
end

-- Safe state tracking: observe the active object configuration at the target tile.
-- Advance only after observing a crackable safe become open/looted.
local safeWatch = {step = nil, wasAvailable = false, lastName = nil}

local function safeNameAtTarget(action)
    if not LocList or type(LocList.All) ~= "function" then return nil end
    local ok, locations = pcall(LocList.All)
    if not ok or not locations then return nil end
    for _, loc in pairs(locations) do
        local coord = loc and loc.coordGrid
        if coord and matchesTarget(coord, action) then
            local config = loc.config
            local name = config and config.configName
            if type(name) == "string" and name:lower():find("safe", 1, true) then
                return name
            end
        end
    end
    return nil
end

local function updateSafeTracking()
    local item = activeAction()
    if not state.running or state.completed or not item or item.action.object ~= "Safe" then
        safeWatch.step, safeWatch.wasAvailable, safeWatch.lastName = nil, false, nil
        return
    end
    if safeWatch.step ~= state.step then
        safeWatch.step, safeWatch.wasAvailable, safeWatch.lastName = state.step, false, nil
    end
    local name = safeNameAtTarget(item.action)
    if not name then return end
    local normalized = name:lower()
    local looted = normalized:find("looted", 1, true) ~= nil
        or normalized:find("_open", 1, true) ~= nil
    local available = normalized:find("_closed", 1, true) ~= nil
        or (not looted and normalized:find("safe", 1, true) ~= nil)
    if name ~= safeWatch.lastName then
        log("Safe Cracking Paths: safe state " .. name .. " (action " .. state.step .. ")")
        safeWatch.lastName = name
    end
    if available then
        safeWatch.wasAvailable = true
    elseif safeWatch.wasAvailable then
        safeWatch.wasAvailable = false
        safeWatch.step = nil
        tracking.note = "Safe looted - advancing"
        if state.step >= #actionsForRoute() then
            state.running, state.completed = false, true
            if startButton then startButton.label = "Restart route" end
        else
            state.step = state.step + 1
        end
        updateRouting()
    end
end

local function inspectLocation(event, description)
    local item = activeAction()
    if not item or not event or not matchesTarget(event.coordGrid, item.action) then return end
    tracking.lastObject = description
    tracking.note = "Target object: " .. description
    log("Safe Cracking Paths: " .. description .. " at " .. tostring(event.coordGrid))
end

-- Draw a compass ring around the player with an outward-facing pointer.
-- Distance is drawn with filled numerals in world space.
local ARROW_EVENT = "safecracking-direction-arrow"
local RING_COLOUR = 0xF2C66DFF
local LABEL_COLOUR = 0xFFFFFFFF
local DIGITS = {
    ["0"] = "abcfed", ["1"] = "bc", ["2"] = "abged", ["3"] = "abgcd",
    ["4"] = "fgbc", ["5"] = "afgcd", ["6"] = "afgecd", ["7"] = "abc",
    ["8"] = "abcdefg", ["9"] = "abcdfg",
}
local SEGMENTS = {
    a = {0, 2, 1, 2}, b = {1, 2, 1, 1}, c = {1, 1, 1, 0},
    d = {0, 0, 1, 0}, e = {0, 1, 0, 0}, f = {0, 2, 0, 1},
    g = {0, 1, 1, 1},
}

local function drawDirectionArrow()
    if not state.running or state.completed or not World.IsAvailable() then return end
    local player = Player.GetEntity()
    local coord = player and player.coordGrid
    local item = activeAction()
    if not coord or not item then return end

    local target = item.action
    if coord.level ~= target.plane then return end
    local dx, dz = target.x - coord.x, target.y - coord.z
    local distance = math.sqrt(dx * dx + dz * dz)
    if distance < 1.5 then return end

    local fx, fz = dx / distance, dz / distance
    local sx, sz = -fz, fx
    local origin = coord:ToCoordFine(true).position
    origin.y = World.GetGroundHeight(coord.level, origin.x, origin.z) + 150
    local function point(forward, side)
        return Vector3.new(origin.x + fx * forward + sx * side,
            origin.y, origin.z + fz * forward + sz * side)
    end

    -- A narrow filled annulus provides consistent thickness without line-width limits.
    local ringPositions, ringTriangles = {}, {}
    local segments = 64
    local innerRadius, outerRadius = 375, 400
    for i = 0, segments - 1 do
        local angle = i * 2 * math.pi / segments
        local forward, side = math.cos(angle), math.sin(angle)
        ringPositions[#ringPositions + 1] = point(innerRadius * forward, innerRadius * side)
        ringPositions[#ringPositions + 1] = point(outerRadius * forward, outerRadius * side)
    end
    for i = 0, segments - 1 do
        local nextIndex = (i + 1) % segments
        local inner, outer = i * 2, i * 2 + 1
        local nextInner, nextOuter = nextIndex * 2, nextIndex * 2 + 1
        ringTriangles[#ringTriangles + 1] = inner
        ringTriangles[#ringTriangles + 1] = outer
        ringTriangles[#ringTriangles + 1] = nextOuter
        ringTriangles[#ringTriangles + 1] = inner
        ringTriangles[#ringTriangles + 1] = nextOuter
        ringTriangles[#ringTriangles + 1] = nextInner
        -- Double-sided triangles avoid disappearing with camera-facing winding.
        ringTriangles[#ringTriangles + 1] = nextOuter
        ringTriangles[#ringTriangles + 1] = outer
        ringTriangles[#ringTriangles + 1] = inner
        ringTriangles[#ringTriangles + 1] = nextInner
        ringTriangles[#ringTriangles + 1] = nextOuter
        ringTriangles[#ringTriangles + 1] = inner
    end
    ShapeList.Draw({shapePositions = ringPositions, shapeTris = ringTriangles,
        colour = RING_COLOUR, ignoreDepth = true})
    -- A thin outline adds definition at distant camera zoom levels.
    local outlinePositions, outlineIndices = {}, {}
    for i = 0, segments - 1 do
        local angle = i * 2 * math.pi / segments
        local nextAngle = (i + 1) * 2 * math.pi / segments
        local radius = (innerRadius + outerRadius) / 2
        outlinePositions[#outlinePositions + 1] = point(radius * math.cos(angle), radius * math.sin(angle))
        outlinePositions[#outlinePositions + 1] = point(radius * math.cos(nextAngle), radius * math.sin(nextAngle))
        outlineIndices[#outlineIndices + 1] = i * 2
        outlineIndices[#outlineIndices + 1] = i * 2 + 1
    end
    ShapeList.Draw({shapePositions = outlinePositions, shapeLines = outlineIndices,
        colour = RING_COLOUR, lineWidth = 3, ignoreDepth = true})

    -- Arrowhead extends outward from the ring toward the objective.
    ShapeList.Draw({
        shapePositions = {
            point(505, 0), point(387, -72), point(405, 0),
            point(387, 72),
        },
        shapeTris = {0, 1, 2, 0, 2, 3},
        colour = RING_COLOUR, ignoreDepth = true,
    })

    -- Filled seven-segment numerals. Lines alone are too faint on the ground.
    -- Each segment is a solid quad, with a dark backing for contrast.
    local value = tostring(math.floor(distance + 0.5))
    local unit = 62
    local spacing = unit * 1.55
    local first = -(#value - 1) * spacing / 2

    local function digitMesh(thickness, heightOffset)
        local vertices, triangles = {}, {}
        local function quad(a, b, c, d)
            local base = #vertices
            vertices[#vertices + 1] = a
            vertices[#vertices + 1] = b
            vertices[#vertices + 1] = c
            vertices[#vertices + 1] = d
            triangles[#triangles + 1] = base
            triangles[#triangles + 1] = base + 1
            triangles[#triangles + 1] = base + 2
            triangles[#triangles + 1] = base
            triangles[#triangles + 1] = base + 2
            triangles[#triangles + 1] = base + 3
            triangles[#triangles + 1] = base + 2
            triangles[#triangles + 1] = base + 1
            triangles[#triangles + 1] = base
            triangles[#triangles + 1] = base + 3
            triangles[#triangles + 1] = base + 2
            triangles[#triangles + 1] = base
        end
        for i = 1, #value do
            local digit = DIGITS[value:sub(i, i)] or ""
            local offset = first + (i - 1) * spacing
            for j = 1, #digit do
                local segment = SEGMENTS[digit:sub(j, j)]
                local x1, y1, x2, y2 = segment[1], segment[2], segment[3], segment[4]
                -- Forward axis is the text's vertical axis; side is horizontal.
                -- Rotate the numerals 180 degrees in place so they face the player.
                local f1, f2 = -555 - (2 - y1) * unit, -555 - (2 - y2) * unit
                local s1, s2 = -(offset + (x1 - 0.5) * unit), -(offset + (x2 - 0.5) * unit)
                local df, ds = f2 - f1, s2 - s1
                local length = math.sqrt(df * df + ds * ds)
                if length > 0 then
                    local pf, ps = -ds / length * thickness / 2, df / length * thickness / 2
                    local function raised(f, side)
                        local v = point(f, side)
                        v.y = v.y + heightOffset
                        return v
                    end
                    quad(raised(f1 + pf, s1 + ps), raised(f1 - pf, s1 - ps),
                        raised(f2 - pf, s2 - ps), raised(f2 + pf, s2 + ps))
                end
            end
        end
        return vertices, triangles
    end
    local shadowPositions, shadowTriangles = digitMesh(26, 0)
    if #shadowPositions > 0 then
        ShapeList.Draw({shapePositions = shadowPositions, shapeTris = shadowTriangles,
            colour = 0x141414FF, ignoreDepth = true})
    end
    local labelPositions, labelTriangles = digitMesh(17, 2)
    if #labelPositions > 0 then
        ShapeList.Draw({shapePositions = labelPositions, shapeTris = labelTriangles,
            colour = LABEL_COLOUR, ignoreDepth = true})
    end
end

-- Objective markers use the same action coordinates as navigation.
-- The highlight is a spatial outline, not a model-level selection effect.
local MARKER_COLOUR = 0xF2C66DFF
local TILE_COLOUR = 0xF2C66D88
-- Locate the loaded world object corresponding to the current route objective.
-- Multi-tile objects can have an origin tile different from the target tile.
local function markerObject(target, kind)
    if not LocList or type(LocList.All) ~= "function" then return nil end
    local ok, objects = pcall(LocList.All)
    if not ok or not objects then return nil end
    local chosen, best = nil, math.huge
    for _, loc in pairs(objects) do
        if loc and loc.isValid ~= false then
            local okInfo, c, w, l, name = pcall(function()
                local cfg = loc.config
                return loc.coordGrid, loc.width, loc.length,
                    ((cfg and cfg.configName) or "") .. " " .. (loc.displayName or "")
            end)
            if okInfo and c and c.level == target.plane then
                w, l = math.max(1, tonumber(w) or 1), math.max(1, tonumber(l) or 1)
                local dx, dz = target.x - c.x, target.y - c.z
                local near = dx >= -1 and dz >= -1 and dx <= w and dz <= l
                local lower = name:lower()
                local wanted = kind == "Safe" and lower:find("safe", 1, true)
                    or kind == "Ladder" and lower:find("ladder", 1, true)
                    or (kind == "Steps" or kind == "Staircase") and
                        (lower:find("stair", 1, true) or lower:find("step", 1, true))
                    or kind == "Exit" and (lower:find("door", 1, true)
                        or lower:find("exit", 1, true) or lower:find("gate", 1, true))
                if near and wanted then
                    local score = math.abs(dx) + math.abs(dz)
                    if score < best then chosen, best = loc, score end
                end
            end
        end
    end
    return chosen
end

-- Use the actual rotated footprint and, when provided, custom picking bounds.
-- The custom AABB is local to the object's placement; transform it to world space.
local function markerBounds(target, kind, ground)
    local loc = markerObject(target, kind)
    if not loc then return nil end
    local ok, result = pcall(function()
        local c, cfg = loc.coordGrid, loc.config
        local width = math.max(1, tonumber(loc.width) or 1)
        local length = math.max(1, tonumber(loc.length) or 1)
        local x0, z0 = c.x * 512, c.z * 512
        local x1, z1 = x0 + width * 512, z0 + length * 512
        local bottom, top = ground + 12, ground + 640
        if kind == "Ladder" then top = ground + 1550
        elseif kind == "Staircase" or kind == "Steps" then top = ground + 1100 end
        local custom = cfg and cfg.hasCustomBounding and cfg.customBounding
        if custom then
            local lo, hi = custom.minimum, custom.maximum
            if lo and hi and hi.x > lo.x and hi.y > lo.y and hi.z > lo.z
                and hi.x - lo.x < 4096 and hi.z - lo.z < 4096
                and hi.y - lo.y < 4096 then
                -- Object-local AABBs are centred on the object's origin.
                -- Rotate horizontal corners using the entity's quarter-turn orientation.
                local angle = (tonumber(loc.rotationType) or 0) % 4
                local cx, cz = (c.x + width / 2) * 512, (c.z + length / 2) * 512
                local minX, maxX, minZ, maxZ = math.huge, -math.huge, math.huge, -math.huge
                for _, px in ipairs({lo.x, hi.x}) do
                    for _, pz in ipairs({lo.z, hi.z}) do
                        local rx, rz = px, pz
                        if angle == 1 then rx, rz = -pz, px
                        elseif angle == 2 then rx, rz = -px, -pz
                        elseif angle == 3 then rx, rz = pz, -px end
                        minX, maxX = math.min(minX, cx + rx), math.max(maxX, cx + rx)
                        minZ, maxZ = math.min(minZ, cz + rz), math.max(maxZ, cz + rz)
                    end
                end
                x0, x1, z0, z1 = minX, maxX, minZ, maxZ
                bottom, top = ground + lo.y, ground + hi.y
            end
        end
        return {x0=x0, x1=x1, z0=z0, z1=z1, bottom=bottom, top=top}
    end)
    if ok then return result end
    return nil
end

local function drawObjectiveMarker()
    if not state.running or state.completed or not World.IsAvailable() then return end
    local player = Player.GetEntity()
    local coord = player and player.coordGrid
    local item = activeAction()
    if not coord or not item then return end
    local action = item.action
    if coord.level ~= action.plane then return end

    local targets = {{x = action.x, y = action.y, plane = action.plane}}
    for _, alternate in ipairs(action.alternateTargets or {}) do
        targets[#targets + 1] = alternate
    end

    for _, target in ipairs(targets) do
        if target.plane == coord.level then
            local dx, dz = target.x - coord.x, target.y - coord.z
            -- Avoid drawing over distant unloaded terrain.
            if dx * dx + dz * dz <= 48 * 48 then
                local x, z = (target.x + 0.5) * 512, (target.y + 0.5) * 512
                local ground, valid = World.GetGroundHeight(target.plane, x, z)
                if valid then
                    local bounds = markerBounds(target, action.object, ground)
                    local x0 = bounds and bounds.x0 or x - 242
                    local x1 = bounds and bounds.x1 or x + 242
                    local z0 = bounds and bounds.z0 or z - 242
                    local z1 = bounds and bounds.z1 or z + 242
                    local y = bounds and bounds.bottom or ground + 12
                    local vertices = {
                        Vector3.new(x0, y, z0), Vector3.new(x1, y, z0),
                        Vector3.new(x1, y, z1), Vector3.new(x0, y, z1),
                    }
                    if state.overlay == "tile" then
                        ShapeList.Draw({shapePositions = vertices,
                            shapeTris = {0, 1, 2, 0, 2, 3, 2, 1, 0, 3, 2, 0},
                            colour = TILE_COLOUR, ignoreDepth = false})
                        ShapeList.Draw({shapePositions = vertices,
                            shapeLines = {0, 1, 1, 2, 2, 3, 3, 0},
                            colour = MARKER_COLOUR, lineWidth = 5, ignoreDepth = false})
                    else
                        -- The object footprint/custom bounds drive the outline;
                        -- use the existing tile-sized box if no object was found.
                        local top = bounds and bounds.top or ground + 640
                        for i = 1, 4 do
                            local p = vertices[i]
                            vertices[#vertices + 1] = Vector3.new(p.x, top, p.z)
                        end
                        -- Solid rectangular beams keep the outline visible
                        -- regardless of the renderer's line-width limits.
                        local beamRadius = 13
                        local positions, triangles = {}, {}
                        local edges = {
                            {1,2},{2,3},{3,4},{4,1},
                            {5,6},{6,7},{7,8},{8,5},
                            {1,5},{2,6},{3,7},{4,8},
                        }
                        for _, edge in ipairs(edges) do
                            local a, b = vertices[edge[1]], vertices[edge[2]]
                            local dx, dy, dz = b.x-a.x, b.y-a.y, b.z-a.z
                            local length = math.sqrt(dx*dx + dy*dy + dz*dz)
                            if length > 0 then
                                local ux, uy, uz = dx / length, dy / length, dz / length
                                local sx, sy, sz
                                if math.abs(uy) > 0.9 then
                                    sx, sy, sz = 1, 0, 0
                                else
                                    sx, sy, sz = -uz, 0, ux
                                    local sl = math.sqrt(sx*sx + sz*sz)
                                    sx, sz = sx/sl, sz/sl
                                end
                                local tx = uy*sz - uz*sy
                                local ty = uz*sx - ux*sz
                                local tz = ux*sy - uy*sx
                                local corners = {
                                    {sx+tx,sy+ty,sz+tz}, {-sx+tx,-sy+ty,-sz+tz},
                                    {-sx-tx,-sy-ty,-sz-tz}, {sx-tx,sy-ty,sz-tz},
                                }
                                local base = #positions
                                for _, endpoint in ipairs({a,b}) do
                                    for _, c in ipairs(corners) do
                                        positions[#positions+1] = Vector3.new(
                                            endpoint.x + c[1]*beamRadius,
                                            endpoint.y + c[2]*beamRadius,
                                            endpoint.z + c[3]*beamRadius)
                                    end
                                end
                                local faces = {
                                    {0,1,2},{0,2,3},{4,6,5},{4,7,6},
                                    {0,4,5},{0,5,1},{1,5,6},{1,6,2},
                                    {2,6,7},{2,7,3},{3,7,4},{3,4,0},
                                }
                                for _, face in ipairs(faces) do
                                    for _, index in ipairs(face) do
                                        triangles[#triangles+1] = base + index
                                    end
                                end
                            end
                        end
                        ShapeList.Draw({shapePositions = positions,
                            shapeTris = triangles,
                            colour = MARKER_COLOUR, ignoreDepth = false})
                    end
                end
            end
        end
    end
end

Event.Draw.Subscribe("safecracking-object-marker", drawObjectiveMarker)

Event.Draw.Subscribe(ARROW_EVENT, drawDirectionArrow)

Event.ServerLogic.Subscribe(TRACK_EVENT, function()
    updatePlayerTracking()
    updateSafeTracking()
end)
Event.LocAdded.Subscribe(TRACK_EVENT, function(event)
    local name = event.config and event.config.configName or "unknown"
    inspectLocation(event, "Added " .. name)
end)
Event.LocRemoved.Subscribe(TRACK_EVENT, function(event)
    inspectLocation(event, "Removed")
end)
Event.LocAnimation.Subscribe(TRACK_EVENT, function(event)
    inspectLocation(event, event.animation and "Animated" or "Animation stopped")
end)

local function changeStep(amount)
    local total = #actionsForRoute()
    if total == 0 then return end
    if amount > 0 and state.step >= total then
        state.running, state.completed = false, true
        if startButton then startButton.label = "Restart route" end
    else
        state.step = math.max(1, math.min(total, state.step + amount))
        state.completed = false
        if startButton then startButton.label = state.running and "Pause route" or "Start route" end
    end
    updateRouting()
end

local MAX_CUSTOM_ROUTES = 5
local saveAsNewButton
local routeLimitText
local routeLimitHint

local function refreshRouteLimit()
    local count = #state.customRoutes
    local full = count >= MAX_CUSTOM_ROUTES
    if routeLimitText then
        routeLimitText.content = string.format("CUSTOM ROUTES: %d / %d", count, MAX_CUSTOM_ROUTES)
    end
    if routeLimitHint then
        routeLimitHint.content = full and "Limit reached - delete a saved route to make room." or ""
    end
    if saveAsNewButton then
        -- Keep the button clickable so the capacity message remains available.
        -- The save handler enforces the limit independently of button styling.
        saveAsNewButton.label = full and "Save as new (full)" or "Save as new"
    end
end

local function syncCustomRoutes()
    for i = #ROUTES, BUILTIN_ROUTE_COUNT + 1, -1 do ROUTES[i] = nil end
    for i, custom in ipairs(state.customRoutes) do
        ROUTES[#ROUTES + 1] = {id = "custom-" .. i, name = custom.name, ids = copyIDs(custom.ids)}
    end
    if state.route > #ROUTES then
        state.route, state.step, state.running, state.completed = 1, 1, false, false
    end
    if routeSelector then
        local active = ROUTES[state.route]
        routeSelector:SetText(string.format("%s (%d safes)", active.name, safeCount(active.ids)))
        routeSelector:SetExpanded(false)
    end
    if state.route > BUILTIN_ROUTE_COUNT then updateRouting() end
    refreshRouteLimit()
end

local function refreshCustomList()
    if not customList then return end
    local entries = {}
    for i, id in ipairs(state.customIDs) do
        entries[i] = {id = i, label = string.format("%02d  %s  (%d safes)", i, STOP_NAMES[id] or id, safeCount({id}))}
    end
    if #entries == 0 then entries[1] = {id = 0, label = "No safes added"} end
    customList:SetEntries(entries)
end
local function refreshSaved()
    if not savedCombo then return end
    local entries = {{id = 0, label = "New / unsaved route"}}
    for i, custom in ipairs(state.customRoutes) do
        entries[#entries + 1] = {id = i, label = string.format("%s (%d safes)", custom.name, safeCount(custom.ids))}
    end
    savedCombo:SetEntries(entries)
end
local function showCustom(index)
    state.editing = index ~= 0 and index or nil
    local selected = state.editing and state.customRoutes[state.editing]
    state.customIDs = selected and copyIDs(selected.ids) or {}
    selectedIndex = 1
    if nameField then nameField:SetText(selected and selected.name or "", false) end
    refreshCustomList()
    feedback(selected and ("Editing: " .. selected.name) or "New route")
end
local function saveCustom(asNew)
    local name = nameField:GetText()
    if #name < 1 or #name > 60 then feedback("Name must be 1-60 characters.") return end
    if #state.customIDs == 0 then feedback("Add at least one safe.") return end
    local entry = {name = name, ids = copyIDs(state.customIDs)}
    local creating = asNew or not state.editing
    if creating then
        if #state.customRoutes >= MAX_CUSTOM_ROUTES then
            feedback("Custom routes full (5 / 5). Delete a saved route to create another.")
            refreshRouteLimit()
            return
        end
        state.customRoutes[#state.customRoutes + 1] = entry
        state.editing = #state.customRoutes
    else
        local editingActive = state.route == BUILTIN_ROUTE_COUNT + state.editing
        state.customRoutes[state.editing] = entry
        if editingActive then
            -- An edited active route may have different actions; pause before applying it.
            state.running, state.completed = false, false
            if startButton then startButton.label = "Start route" end
        end
    end
    refreshSaved()
    syncCustomRoutes()
    feedback((creating and "Created new route: " or "Updated route: ") .. name .. " (session only)")
    refreshRouteLimit()
end

-- Position controls relative to the window content area.
local function textAt(win, value, x, y, height, colour)
    return prettyui.Text.new(win.content, {
        text = value, x = x, y = y, width = -x - 12, widthAnchor = 1.0,
        height = height or 22, colour = colour or 0xE7D7B0FF,
    })
end
local function buttonAt(win, label, action, x, y, width)
    return prettyui.SimpleButton.new(win.content, label, action, {
        x = x, y = y, width = width, height = 28,
    })
end
local GOLD = 0xF2C66DFF

local function openPaths()
    if pathsWindow and pathsWindow.root then pathsWindow:Show() return end
    local parent = ui.Interfaces:GetComponent(id.Component.TOPLEVEL_V2__PLUGIN_BUILD_LAYER_BOTTOM)
    assert(parent, "Plugin build layer unavailable")
    pathsWindow = prettyui.Window.new(parent, {
        title = "Safe Cracking Paths - Paths", x = 270, y = 145,
        width = 430, height = 525, resizable = false,
    })
    textAt(pathsWindow, "ROUTE", 12, 8, 20, GOLD)
    -- Keep PrettyUI's native gold-accented CollapseButton header, but do not
    -- add children to its flow region. The ordered choices live in a separate
    -- foreground layer so the window never resizes or repositions.
    local menuLayer
    local function routeCaption()
        local route = ROUTES[state.route]
        return string.format("%s (%d safes)", route.name, safeCount(route.ids))
    end
    local function hideRouteMenu()
        if menuLayer then menuLayer:Destroy() menuLayer = nil end
    end
    local function chooseRoute(index)
        state.route, state.step, state.running, state.completed = index, 1, false, false
        if startButton then startButton.label = "Start route" end
        routeSelector:SetText(routeCaption())
        routeSelector:SetExpanded(false)
        hideRouteMenu()
        updateRouting()
    end
    local function showRouteMenu()
        hideRouteMenu()
        -- Construct AFTER all ordinary controls; this layer paints on top.
        menuLayer = ui.Layer.new(pathsWindow.content)
        menuLayer:SetPos(12, 59)
        menuLayer:SetSize(395, #ROUTES * 29)
        for index, item in ipairs(ROUTES) do
            local routeIndex = index
            local button = ui.Button.new(menuLayer)
            button.stylesheetID = id.StyleSheet.BUTTON_DEFAULT
            button.label = string.format("%s (%d safes)", item.name, safeCount(item.ids))
            button:SetPos(0, (index - 1) * 29)
            button:SetSize(395, 29)
            button:Subscribe(ui.Hook.ONBUTTONPRESSED, function()
                chooseRoute(routeIndex)
                return false
            end)
        end
    end
    routeSelector = prettyui.CollapseButton.new(pathsWindow.content,
        routeCaption(), {
            x = 12, y = 30, width = 395, expanded = false,
            resizeParent = false,
            onToggle = function(_, expanded)
                if expanded then showRouteMenu() else hideRouteMenu() end
            end,
        })
    textAt(pathsWindow, "OVERLAY", 12, 67, 20, GOLD)
    prettyui.RadioButton.new(pathsWindow.content, {
        {text = "Highlight", value = "highlight"}, {text = "Tile", value = "tile"},
    }, {x = 90, y = 65, width = 250, selectedValue = state.overlay, inline = true,
        onChange = function(_, value) state.overlay = value updateRouting() end,
    })
    textAt(pathsWindow, "ROUTE PROGRESS", 12, 102, 20, GOLD)
    progressLabel = textAt(pathsWindow, "0%", 12, 125, 24)
    textAt(pathsWindow, "CURRENT OBJECTIVE", 12, 157, 20, GOLD)
    objectiveLabel = textAt(pathsWindow, "", 12, 180, 27)
    travelLabel = textAt(pathsWindow, "", 12, 210, 48)
    buttonAt(pathsWindow, "Previous", function() changeStep(-1) end, 12, 262, 88)
    buttonAt(pathsWindow, "Next >", function() changeStep(1) end, 107, 262, 78)
    buttonAt(pathsWindow, "Refresh", updateRouting, 192, 262, 82)
    buttonAt(pathsWindow, "Restart", function()
        state.step, state.completed = 1, false
        if startButton then startButton.label = state.running and "Pause route" or "Start route" end
        updateRouting()
    end, 281, 262, 86)
    startButton = buttonAt(pathsWindow, "Start route", function()
        if state.completed then state.step, state.completed = 1, false end
        state.running = not state.running
        if startButton then startButton.label = state.running and "Pause route" or "Start route" end
        updateRouting()
    end, 12, 300, 155)
    endButton = buttonAt(pathsWindow, "End route", function()
        state.running, state.completed = false, false
        state.step = 1
        if startButton then startButton.label = "Start route" end
        updateRouting()
    end, 171, 300, 145)
    textAt(pathsWindow, "ROUTE ACTIONS", 12, 342, 20, GOLD)
    routeList = prettyui.List.new(pathsWindow.content, {
        x = 12, y = 365, width = -24, widthAnchor = 1.0,
        height = 100, maxSelected = 1, entries = {},
        onChange = function(_, index, selected)
            if selected and type(index) == "number" and index >= 1 and index <= #actionsForRoute() then
                state.step = index
                updateRouting()
            end
        end,
    })
    updateRouting()
    pathsWindow:Show()
    log("Safe Cracking Paths: Paths window opened")
end

local function openCustom()
    if customWindow and customWindow.root then customWindow:Show() return end
    local parent = ui.Interfaces:GetComponent(id.Component.TOPLEVEL_V2__PLUGIN_BUILD_LAYER_BOTTOM)
    assert(parent, "Plugin build layer unavailable")
    customWindow = prettyui.Window.new(parent, {
        title = "Safe Cracking Paths - Custom Paths", x = 730, y = 145,
        width = 430, height = 625, resizable = false,
    })
    textAt(customWindow, "SAVED CUSTOM ROUTES", 12, 8, 20, GOLD)
    savedCombo = prettyui.ComboBox.new(customWindow.content, {
        x = 12, y = 30, width = 250, height = 28,
        entries = {{id = 0, label = "New / unsaved route"}}, selectedID = 0,
        onChange = function(_, index) showCustom(index) end,
    })
    buttonAt(customWindow, "New", function() showCustom(0) end, 270, 30, 60)
    buttonAt(customWindow, "Delete", function()
        if not state.editing then feedback("Select a saved route first.") return end
        local deleted = state.editing
        if state.route == BUILTIN_ROUTE_COUNT + deleted then
            state.route, state.step, state.running, state.completed = 1, 1, false, false
        elseif state.route > BUILTIN_ROUTE_COUNT + deleted then
            state.route = state.route - 1
        end
        table.remove(state.customRoutes, deleted)
        showCustom(0)
        refreshSaved()
        syncCustomRoutes()
        feedback("Route deleted from this session.")
        refreshRouteLimit()
    end, 337, 30, 70)
    textAt(customWindow, "ROUTE NAME", 12, 68, 20, GOLD)
    nameField = prettyui.TextField.new(customWindow.content, {
        x = 12, y = 90, width = -24, widthAnchor = 1.0,
        height = 30, placeholder = "My safecracking route", maxLength = 60,
    })
    textAt(customWindow, "ADD LOCATION", 12, 130, 20, GOLD)
    local stops = {}
    for i = 1, 31 do
        local stopID = string.format("%03d", i)
        stops[i] = {id = i, label = STOP_NAMES[stopID] or stopID}
    end
    locationCombo = prettyui.ComboBox.new(customWindow.content, {
        x = 12, y = 152, width = 395, height = 28,
        entries = stops, selectedID = state.selectedStop,
        onChange = function(_, stopIndex) state.selectedStop = stopIndex end,
    })
    buttonAt(customWindow, "+ Add", function()
        local stopID = string.format("%03d", state.selectedStop)
        for _, id in ipairs(state.customIDs) do
            if id == stopID then feedback("Location already in route.") return end
        end
        state.customIDs[#state.customIDs + 1] = stopID
        refreshCustomList()
        feedback("Location added.")
    end, 12, 185, 90)
    buttonAt(customWindow, "Clear", function()
        state.customIDs = {}
        selectedIndex = 1
        refreshCustomList()
        feedback("Route cleared.")
    end, 110, 185, 90)
    textAt(customWindow, "ROUTE ORDER - SELECT A LOCATION TO MOVE", 12, 229, 20, GOLD)
    customList = prettyui.List.new(customWindow.content, {
        x = 12, y = 251, width = -24, widthAnchor = 1.0,
        height = 162, maxSelected = 1,
        entries = {{id = 0, label = "No safes added"}},
        onChange = function(_, index, selected) if selected then selectedIndex = index end end,
    })
    buttonAt(customWindow, "Up", function()
        if selectedIndex <= 1 or selectedIndex > #state.customIDs then return end
        state.customIDs[selectedIndex], state.customIDs[selectedIndex - 1] = state.customIDs[selectedIndex - 1], state.customIDs[selectedIndex]
        selectedIndex = selectedIndex - 1
        refreshCustomList()
    end, 12, 426, 75)
    buttonAt(customWindow, "Down", function()
        if selectedIndex < 1 or selectedIndex >= #state.customIDs then return end
        state.customIDs[selectedIndex], state.customIDs[selectedIndex + 1] = state.customIDs[selectedIndex + 1], state.customIDs[selectedIndex]
        selectedIndex = selectedIndex + 1
        refreshCustomList()
    end, 94, 426, 75)
    buttonAt(customWindow, "Remove", function()
        if selectedIndex < 1 or selectedIndex > #state.customIDs then return end
        table.remove(state.customIDs, selectedIndex)
        selectedIndex = math.max(1, selectedIndex - 1)
        refreshCustomList()
    end, 176, 426, 90)
    buttonAt(customWindow, "Save route", function() saveCustom(false) end, 12, 468, 112)
    saveAsNewButton = buttonAt(customWindow, "Save as new", function() saveCustom(true) end, 131, 468, 112)
    buttonAt(customWindow, "Use in Paths >", function()
        if not state.editing or not state.customRoutes[state.editing] then
            feedback("Save your route before using it.") return
        end
        syncCustomRoutes()
        state.route = BUILTIN_ROUTE_COUNT + state.editing
        state.step, state.running, state.completed = 1, false, false
        if startButton then startButton.label = "Start route" end
        if routeSelector then
            local chosen = ROUTES[state.route]
            routeSelector:SetText(string.format("%s (%d safes)", chosen.name, safeCount(chosen.ids)))
            routeSelector:SetExpanded(false)
        end
        updateRouting()
        openPaths()
        feedback("Custom route loaded in Paths.")
    end, 250, 468, 157)
    routeLimitText = textAt(customWindow, "", 12, 506, 22, GOLD)
    routeLimitHint = textAt(customWindow, "", 12, 528, 22)
    customFeedback = textAt(customWindow, "Routes are saved for this session only.", 12, 552, 22)
    refreshSaved()
    refreshRouteLimit()
    refreshCustomList()
    customWindow:Show()
    log("Safe Cracking Paths: Custom Paths window opened")
end

-- The native plugin panel is intentionally ONLY a two-button launcher.
local function launcherButton(parent, label, y, callback)
    local button = ui.Button.new(parent)
    button.stylesheetID = id.StyleSheet.BUTTON_DEFAULT
    button.label = label
    button:SetPos(12, y)
    button:SetSize(-24, 34, 1, 0)
    button:Subscribe(ui.Hook.ONBUTTONPRESSED, function()
        callback()
        return false
    end)
    return button
end
local function mountLauncher(parent)
    if hubRoot then hubRoot:Destroy() hubRoot = nil end
    hubRoot = ui.Layer.new(parent)
    hubRoot:SetPos(0, 0)
    hubRoot:SetSize(0, 0, 1, 1)
    launcherButton(hubRoot, "Open Paths", 12, openPaths)
    launcherButton(hubRoot, "Open Custom Paths", 54, openCustom)
    log("Safe Cracking Paths: launcher mounted")
end
Event.ContentLayerReady.Subscribe(HUB_EVENT, function(event)
    if event and event.component then mountLauncher(event.component) end
end)
function PluginShutdown()
    Event.ContentLayerReady.Unsubscribe(HUB_EVENT)
    Event.Draw.Unsubscribe(ARROW_EVENT)
    Event.Draw.Unsubscribe("safecracking-object-marker")
    Event.ServerLogic.Unsubscribe(TRACK_EVENT)
    Event.LocAdded.Unsubscribe(TRACK_EVENT)
    Event.LocRemoved.Unsubscribe(TRACK_EVENT)
    Event.LocAnimation.Unsubscribe(TRACK_EVENT)
    if hubRoot then hubRoot:Destroy() hubRoot = nil end
    if pathsWindow then pathsWindow:Destroy() pathsWindow = nil end
    routeSelector = nil
    if customWindow then customWindow:Destroy() customWindow = nil end
end
log("Safe Cracking Paths: launcher registered - open Plugins")
