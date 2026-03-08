local addonName, ns = ...

ns.ReleaseNotes = {
    notes = {
        ["v2.0.1"] = {
            "|cff00d1ff[New]|r Added login Welcome and Update notification messages.",
            "|cff00d1ff[New]|r Automatic |cffffd100/reload|r prompt when handling incompatible configurations.",
            "|cff00ff00[Improved]|r Enhanced addon versioning and compatibility check system.",
            "|cff00ff00[Fixed]|r Adjusted Non-Lethal Poison icon anchoring relative to default text.",
        },
        ["v2.0.0"] = {
            "|cff00d1ff[New]|r Redesigned configuration interface using |cffffd100LibEQOL|r |cff808080(by R41Z0R)|r.",
            "|cff00d1ff[New]|r Integrated Profile System with Import/Export functionality.",
            "|cff00d1ff[New]|r Added a 'Test Message' button to preview Shroud alerts.",
            "|cff00d1ff[New]|r Added 2 fully configurable fallback channels for Shroud (automatically ignores group channels when solo).",
            "|cff00d1ff[New]|r Version-check system implemented to prevent config corruption.",
            "|cff00ff00[Improved]|r Enhanced Shroud countdown tracking for precision.",
            "|cff00ff00[Refactored]|r The instance-based detection system has been completely rewritten for better reliability.",
            "|cff00ff00[Fixed]|r Resolved errors when using Shroud of Concealment outside of instances.",
            "|cff00ff00[Fixed]|r Shroud start and end messages now broadcast correctly.",
            "|cff00ff00[Fixed]|r Custom Shroud messages are now properly saved between sessions.",
            "|cffffd100[Changed]|r Shroud time variable changed from |cffffd100%t|r to |cffffd100%time|r to avoid conflicts.",
            "|cffffd100[Localization]|r Full translation support for all official WoW languages.",
            "|cffffff00[UI]|r Moved the Reset button to the native 'Defaults' button in the settings menu.",
            "|cffff2020[Removed]|r Shadow Dance support due to stability issues and limited utility.",
            "|cffff2020[Removed]|r SAY and YELL options removed due to Blizzard limitations on scripted messages in these channels.",
        },
        ["v1.0.1"] = {
            "|cff00d1ff[New]|r Added |cffffd100Rogue Poison Tracker|r module with visual alerts.",
            "|cff00d1ff[New]|r Support for |cffffd100Addon Compartment|r (Minimap button integration).",
            "|cff00ff00[Improved]|r Renamed addon to better reflect core features and future updates.",
            "|cff00ff00[Improved]|r Enhanced icon anchoring and dynamic scaling system.",
            "|cff00ff00[Improved]|r Optimized instance and combat state detection filters.",
            "|cffffd100[Visual]|r Added high-fidelity text animations and transition effects.",
            "|cffffff00[Misc]|r Updated default configuration values and localization files.",
        },
        ["v1.0.0"] = {
            "|cffffff00[Initial]|r First stable public release.",
            "|cff00d1ff[Core]|r Full support for |cffffd100Stealth|r and |cffffd100Shadow Dance|r visual states.",
            "|cff00d1ff[Core]|r Integrated |cffffd100Self-Highlight|r visibility features for character tracking.",
            "|cff00d1ff[Core]|r Specialized chat broadcast system for Shroud of Concealment.",
            "|cffffd100[Visual]|r Extensive styling options and visual effect customization.",
        },
    }
}