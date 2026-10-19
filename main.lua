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
    route = 1, step = 1, overlay = "highlight",
    customName = "", customIDs = {}, customRoutes = {},
    editing = nil, selectedStop = "001", jsonText = "",
}
-- Both windows share the same route state.
local pathsWindow, customWindow, hubRoot
local routeCombo, progressLabel, objectiveLabel, travelLabel, statusLabel, routeList
local savedCombo, nameField, locationCombo, customList, customFeedback
local selectedIndex = 1
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
local function updateRouting()
    local actions = actionsForRoute()
    local total = #actions
    if total == 0 then return end
    state.step = math.max(1, math.min(state.step, total))
    local item = actions[state.step]
    local action = item.action
    local label = action.action or (action.object == "Safe" and "Crack safe" or "Interact")
    local coords = string.format("%d, %d | Floor %d", action.x or 0, action.y or 0, action.plane or 0)
    local percent = math.floor((state.step - 1) / total * 100)
    if progressLabel then progressLabel.content = string.format("%d%% | Action %d / %d | Location %d / %d", percent, state.step, total, item.locationIndex, #currentIDs()) end
    if objectiveLabel then objectiveLabel.content = string.format("%s: %s", item.location, label) end
    if travelLabel then
        local description = action.detail or (action.object and ("Target: " .. action.object) or "Proceed to the target")
        local travel = action.travel and (" | " .. action.travel) or ""
        travelLabel.content = description .. " | " .. coords .. travel
    end
    if statusLabel then statusLabel.content = "Manual navigation | Overlay: " .. state.overlay .. (action.optional and " | Optional action" or "") end
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
local function changeStep(amount)
    state.step = math.max(1, math.min(#actionsForRoute(), state.step + amount))
    updateRouting()
end
local function routeEntries()
    local entries = {}
    for i, item in ipairs(ROUTES) do
        entries[#entries + 1] = {id = i, label = string.format("%s (%d locations)", item.name, #item.ids)}
    end
    return entries
end
local function refreshCustomList()
    if not customList then return end
    local entries = {}
    for i, id in ipairs(state.customIDs) do
        entries[i] = {id = i, label = string.format("%02d  %s", i, STOP_NAMES[id] or id)}
    end
    if #entries == 0 then entries[1] = {id = 0, label = "No locations added"} end
    customList:SetEntries(entries)
end
local function refreshSaved()
    if not savedCombo then return end
    local entries = {{id = 0, label = "New / unsaved route"}}
    for i, custom in ipairs(state.customRoutes) do
        entries[#entries + 1] = {id = i, label = custom.name}
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
local function saveCustom()
    local name = nameField:GetText()
    if #name < 1 or #name > 60 then feedback("Name must be 1-60 characters.") return end
    if #state.customIDs == 0 then feedback("Add at least one location.") return end
    local entry = {name = name, ids = copyIDs(state.customIDs)}
    if state.editing then
        state.customRoutes[state.editing] = entry
    else
        state.customRoutes[#state.customRoutes + 1] = entry
        state.editing = #state.customRoutes
    end
    refreshSaved()
    feedback("Saved for this session: " .. name)
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
    routeCombo = prettyui.ComboBox.new(pathsWindow.content, {
        x = 12, y = 30, width = -24, widthAnchor = 1.0, height = 28,
        entries = routeEntries(), selectedID = state.route,
        onChange = function(_, index)
            if not ROUTES[index] then return end
            state.route, state.step = index, 1
            updateRouting()
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
    buttonAt(pathsWindow, "Restart", function() state.step = 1 updateRouting() end, 281, 262, 86)
    textAt(pathsWindow, "ROUTE ACTIONS", 12, 303, 20, GOLD)
    routeList = prettyui.List.new(pathsWindow.content, {
        x = 12, y = 328, width = -24, widthAnchor = 1.0,
        height = 114, maxSelected = 1, entries = {},
        onChange = function(_, index, selected)
            if selected and type(index) == "number" and index >= 1 and index <= #actionsForRoute() then
                state.step = index
                updateRouting()
            end
        end,
    })
    statusLabel = textAt(pathsWindow, "", 12, 452, 22)
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
        width = 430, height = 585, resizable = false,
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
        table.remove(state.customRoutes, state.editing)
        showCustom(0)
        refreshSaved()
        feedback("Route deleted from this session.")
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
        stops[i] = {id = stopID, label = STOP_NAMES[stopID] or stopID}
    end
    locationCombo = prettyui.ComboBox.new(customWindow.content, {
        x = 12, y = 152, width = 245, height = 28,
        entries = stops, selectedID = state.selectedStop,
        onChange = function(_, stopID) state.selectedStop = stopID end,
    })
    buttonAt(customWindow, "+ Add", function()
        for _, id in ipairs(state.customIDs) do
            if id == state.selectedStop then feedback("Already in route.") return end
        end
        state.customIDs[#state.customIDs + 1] = state.selectedStop
        refreshCustomList()
        feedback("Location added.")
    end, 266, 152, 67)
    buttonAt(customWindow, "Clear", function()
        state.customIDs = {}
        selectedIndex = 1
        refreshCustomList()
        feedback("Locations cleared.")
    end, 340, 152, 67)
    textAt(customWindow, "ROUTE ORDER", 12, 192, 20, GOLD)
    customList = prettyui.List.new(customWindow.content, {
        x = 12, y = 214, width = -24, widthAnchor = 1.0,
        height = 162, maxSelected = 1,
        entries = {{id = 0, label = "No locations added"}},
        onChange = function(_, index, selected) if selected then selectedIndex = index end end,
    })
    buttonAt(customWindow, "Up", function()
        if selectedIndex <= 1 or selectedIndex > #state.customIDs then return end
        state.customIDs[selectedIndex], state.customIDs[selectedIndex - 1] = state.customIDs[selectedIndex - 1], state.customIDs[selectedIndex]
        selectedIndex = selectedIndex - 1
        refreshCustomList()
    end, 12, 389, 75)
    buttonAt(customWindow, "Down", function()
        if selectedIndex < 1 or selectedIndex >= #state.customIDs then return end
        state.customIDs[selectedIndex], state.customIDs[selectedIndex + 1] = state.customIDs[selectedIndex + 1], state.customIDs[selectedIndex]
        selectedIndex = selectedIndex + 1
        refreshCustomList()
    end, 94, 389, 75)
    buttonAt(customWindow, "Remove", function()
        if selectedIndex < 1 or selectedIndex > #state.customIDs then return end
        table.remove(state.customIDs, selectedIndex)
        selectedIndex = math.max(1, selectedIndex - 1)
        refreshCustomList()
    end, 176, 389, 90)
    buttonAt(customWindow, "Save route", saveCustom, 12, 431, 115)
    buttonAt(customWindow, "Use in Paths >", function()
        if #state.customIDs == 0 then feedback("Add a location first.") return end
        local preview = {id = "custom-preview", name = nameField:GetText() ~= "" and nameField:GetText() or "Custom Preview", ids = copyIDs(state.customIDs)}
        local index
        for i, item in ipairs(ROUTES) do if item.id == "custom-preview" then index = i break end end
        if index then ROUTES[index] = preview else ROUTES[#ROUTES + 1] = preview index = #ROUTES end
        state.route, state.step = index, 1
        if routeCombo then routeCombo:SetEntries(routeEntries(), state.route) end
        updateRouting()
        openPaths()
        feedback("Custom route loaded in Paths.")
    end, 135, 431, 140)
    customFeedback = textAt(customWindow, "Custom routes are session-only.", 12, 473, 40)
    refreshSaved()
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
    if hubRoot then hubRoot:Destroy() hubRoot = nil end
    if pathsWindow then pathsWindow:Destroy() pathsWindow = nil end
    if customWindow then customWindow:Destroy() customWindow = nil end
end
log("Safe Cracking Paths: launcher registered - open Plugins")
