# Safe Cracking Paths

A planned native RuneScape 3 plugin for guided safecracking routes, built with the official Lua plugin API and intended to use PrettyUI for its interface.

> **Status:** WIP This repository is not yet a working plugin.

## Features

### Built-in routes

Seven routes are planned, preserving the existing RuneTools version:

| Route | Locations |
| --- | --- |
| Misthalin | Edgeville, Varrock, Draynor, Lumbridge |
| Kharidian Desert | Menaphos, Al Kharid, Nardah, Pollnivneach |
| Menaphos Only | Merchant, Port, and Imperial Districts |
| Asgarnia | Black Knights' Fortress, Burthorpe, Port Sarim, Falador |
| Kandarin | Camelot, Yanille, Ardougne |
| Hidden | Wilderness and Zanaris locations |
| All Safes | Every included location |

The source contains **31 location groups**, each identified by a stable three-digit stop ID. A location may contain multiple safes and navigation steps.

### Guided navigation

- Show the current location, target object, action, and travel instructions.
- Include ladders, stairs, floor transitions, and alternate targets.
- Offer Previous, Skip Step, Refresh, and Restart Route controls.
- Provide a collapsible route-step overview with selectable steps.
- Preserve the existing route order and safe coordinates.

### World overlays

- Highlight the current target where supported by the official API.
- Offer a tile-marker alternative.
- Handle multiple valid staircase targets.
- Remove stale markers on route changes or completion.

### Automatic progression

- Detection of relevant player floor transitions.
- Tracking safes by observing their crackable state and subsequent state change.
- Handling the special exit transition at Zemouregal's Fort.
- Alternate arrival floors for the Wizards' Tower.
- Checking Imperial District tier-five reputation where state data is available.
- Manual skipping when automatic detection is unavailable.

### Route progress

- Display completion percentage and completed/remaining steps.
- Show an expandable, clickable list of steps.
- Persist progress separately for each route, subject to official storage support.
- Support manual step navigation and route restart.

### Custom routes

- Create and name custom routes.
- Add locations from the existing location database.
- Move locations up or down or remove them.
- Save, select, edit, and delete routes.
- Use saved custom routes in the main Routing view.
- Validate names, stop IDs, duplicates, and route length.

### JSON import and export

```json
{
  "format": "safe-cracking-paths-route",
  "version": 1,
  "name": "My Route",
  "ids": ["001", "002", "003"]
}
```

A route contains a name and ordered location IDs, not copied coordinates. IDs must reference known stops, and each stop can appear only once.

### Interface

- Routing and Custom tabs.
- Route selector with location and safe counts.
- Current-step panel and route progress display.
- Custom-route editor with import/export controls.
- PrettyUI styling and native theme integration, pending API verification.

## Dependencies

**PrettyUI** is the intended required UI dependency. Its exact manifest identifier, exported functions, and compatibility need to be confirmed before the dependency is committed.

## Sources

- [Official API getting started](https://developer.runescape.com/rs/getting-started.html)
- [Official plugin structure and dependencies](https://developer.runescape.com/rs/structure.html)
- [Official developer setup](https://developer.runescape.com/rs/tutorial/1helloworld.html)
- [Official submission guidelines](https://developer.runescape.com/rs/submission/guidelines.html)
- [PrettyUI repository](https://github.com/PrettyRS/prettyui)
