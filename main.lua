-----------------------
--- TANSTAAFE'23
--- There Ain't No Such Thing As A Free Engine
--- A Game Engine, powered by Love 2D (love2d.org)
--- (C) Justin "nihiven" Behanna
-----------------------

--- TODO: Event System: The event system will broadcast events to all objects that are listening for them. We'll use this for communication between components.
--- TODO: Input System: This will wrap Love2d's input system and allow us to respond to 'actions' instead of keys.
--- TODO: Classes: Let's look into meta tables and see if we can make a system that works like class, but is more flexible.
--- TODO: Game State System: This will allow us to have multiple game states, such as a menu, a game, a pause screen, etc. State switching will trigger events.
--- TODO: Inspector: This is 3rd party component that will allow us to inspect tables at runtime.
--- TODO: Scene System: The is the game screen manager. It allows us to move from one game screen to another.
--- TODO: Resource System: This let's us load resources such as sounds and images.
--- TODO: Sound System: Not sure what this is or how this works, or even if we need it.
--- TODO: GUI system: Allows us to create menus and other GUI elements. There will be 'game' and 'system' GUIs.

Events = {
  --- TODO: meta __tostring using Inspector

}

function love.load()

end
