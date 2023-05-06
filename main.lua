---------------------------------------------------------------------
---- TANSTAAFE'23
--- "There Ain't No Such Thing As A Free Engine 2023"
--- A Game Engine, powered by Love 2D (love2d.org) and lots of Lua.
--- (C) Justin "nihiven" Behanna
--- https://nvn.io - jb@nvn.io
---------------------------------------------------------------------
---- Version History
--- 0.1.0 - 'Genesis'
-- MUSIC: Miami Vice, Duran Duran, FFVII
-- DONE: Build the first major components of the engine; Events, [v0.1.0]
-- DONE: Inspector: A 3rd party component that will allow us to inspect tables at runtime. [v0.1.0]
-- DONE: Build test system [v0.1.0]
-- DONE: Classes: Let's look into metatables and see if we can make a system that works like a class, but is more flexible.
-- TODO: GUI system: Manage menus and other GUI elements. There will be game level and system level GUIs. [lib: ???]
-- TODO: Game State System: Controls flow of multiple game states, (menu/game/pause/etc). State switching will trigger events. [lib: ???]
---------------------------------------------------------------------

--- TODO: v0.1.0
-- TODO: Input System: Wrap Love2d's input system, implementing 'action' triggers, replacing direct key references. [lib: Baton?]
-- TODO: Scene System: Screen manager that controls transition from one screen to another. [lib: hump?]
-- TODO: Resource System: Load and reference resources such as sounds and images. [lib: home grown]
-- TODO: Sound System: Not sure what this is or how this works, or even if we need it. [lib: ???]
-- TODO: Logging? [lib: ???]
--- TODO: v0.2.0
-- TODO: ???
---luv--------------------------------
LE = love.event
LG = love.graphics
LW = love.window

---helpers----------------------------
Help = {}
-- saves color to a table with named components
function Help.saveColor()
  local r, g, b, a = LG.getColor()
  return { red = r, green = g, blue = b, alpha = a }
end

-- loads color from a table with named components
function Help.loadColor(color)
  LG.setColor(color.red, color.green, color.blue, color.alpha)
end

-- sets color using one of the predefined colors (Color)
function Help.setColor(color)
  LG.setColor(color.red, color.green, color.blue, color.alpha)
end

---lib--------------------------------
Inspect = require('lib/inspect')

---sys--------------------------------
Input = require('sys/input_system')
Event = require('sys/event_system')
Game = require('sys/game_system')
GUI = require('sys/gui_system')

---test-------------------------------
Test = require('sys/test_system')

---callbacks
function love.load()
  -- do we hardcode the subscribe calls in the sys files then publish a load event
  -- or do we run the subscribe calls in the the sys load() functions?

  -- setup system subscriptions
  Game:subscribeToEvents()
  GUI:subscribeToEvents()
  Test:subscribeToEvents()

  -- publish load event
  Event:publish(EventType.load, Game.state)
end

function love.draw()
  Event:publish(EventType.draw, Game.state)
end

function love.keypressed(k)
  Event:publish(EventType.keypressed, Game.state, k)
end

function love.update(dt)
  Input:update()                   -- update baton
  Input:publishActions(Game.state) -- publish baton actions
  Event:publish(EventType.update, Game.state, dt)
end
