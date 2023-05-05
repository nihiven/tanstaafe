---------------------------------------------------------------------
---- TANSTAAFE'23
--- "There Ain't No Such Thing As A Free Engine 2023"
--- A Game Engine, powered by Love 2D (love2d.org) and lots of Lua.
--- (C) Justin "nihiven" Behanna
--- https://nvn.io - jb@nvn.io
---------------------------------------------------------------------
---- Version History
--- 0.1.0 - 'Genesis'
-- MUSIC: Miami Vice: The Complete Collection
-- TODO: Build the first major components of the engine; Events, [v0.1.0]
-- DONE: Inspector: A 3rd party component that will allow us to inspect tables at runtime. [v0.1.0]
---------------------------------------------------------------------

--- TODO: Input System: Wrap Love2d's input system, implementing 'action' triggers, replacing direct key references. [lib: Baton?]
--- TODO: Classes: Let's look into metatables and see if we can make a system that works like a class, but is more flexible. [lib: home grown]
--- TODO: Game State System: Controls flow of ultiple game states, (menu/game/pause/etc). State switching will trigger events. [lib: ???]
--- TODO: Scene System: Screen manager that controls transition from one screen to another. [lib: hump?]
--- TODO: Resource System: Load and reference resources such as sounds and images. [lib: home grown]
--- TODO: Sound System: Not sure what this is or how this works, or even if we need it. [lib: ???]
--- TODO: GUI system: Manage menus and other GUI elements. There will be game level and system level GUIs. [lib: ???]
--- TODO: Logging? [lib: ???]

LW = love.window
LG = love.graphics
-----------------------------------
Inspect = require('lib/inspect')

-----------------------------------
--- TODO: Event System: Broadcast events to all objects that are listening for them. Use this for communication between components. [lib: home grown]
--- Event System
--- This will go into it's own file once it's working.
--- The Event System publishes events to subscribed objects.
--- Objects subscribe by providing an event type and a callback function.
-- EventType enum
EventType = {
  draw = 0,
  update = 1
}
local ev = {}
Events = {
  __index = function(value, key)
    if (Events[key]) then
      return Events[key]
    else
      print("Events: Unknown key: ", key)
    end
  end,
  __tostring = function(obj)
    return Inspect(obj)
  end,
  subscriptions = {},
  subscribe = function(eventType, callback)
    if not Events.subscriptions[eventType] then
      Events.subscriptions[eventType] = {}
    end
    table.insert(Events.subscriptions[eventType], callback)
  end,
  publish = function(eventType, ...)
    if not Events.subscriptions[eventType] then return end
    for _, callback in ipairs(Events.subscriptions[eventType]) do
      callback(...)
    end
  end,
  unsubscribe = function(eventType, callback)
    if not Events.subscriptions[eventType] then return end
    for i, cb in ipairs(Events.subscriptions[eventType]) do
      if cb == callback then
        table.remove(Events.subscriptions[eventType], i)
        return
      end
    end
  end
}
setmetatable(ev, Events);
local subtest = function()
  print("Draw Event from a subscriber!")
end

function love.load()

end

function love.draw()
  ev.publish(EventType.draw)
end

function love.keypressed(k)
  print("Key: ", k)
  if k == 'escape' then love.event.quit() end
  if k == 'j' then
    ev.unsubscribe(EventType.draw, subtest)
  end
  if k == 's' then
    ev.subscribe(EventType.draw, subtest)
  end
end

-- HACK: Testing
-- BUG: Testing
-- INFO: Testing
-- MUSIC: Testing
-- NEW: Testing
-- NEXT: Testing
-- NOTE: Testing
-- TODO: Testing
-- ???: Testing
