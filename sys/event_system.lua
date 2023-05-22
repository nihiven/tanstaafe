--- Event System
--- Publishes events (EventType) to subscribed callbacks.
--- Subscriptions require an EventType and a callback function.

-- EventType enum
EventType = {
  --- basic events
  load = 0,       -- love load
  draw = 1,       -- love draw
  update = 2,     -- love update
  keypressed = 3, -- any key pressed

  --- game events
  state_change = 4, -- when the game state changes
  input = 5,        -- input from baton
  quit = 6,         -- quit the game
}
EventTypeText = {
  [EventType.load] = 'love.load',
  [EventType.draw] = 'love.draw',
  [EventType.update] = 'love.update',
  [EventType.keypressed] = 'key pressed',
  [EventType.state_change] = 'gamestate change',
  [EventType.input] = 'baton input',
  [EventType.quit] = 'quit signal',
}
local ev = {
  _name = 'Event System',
  debug = true,
  subscriptions = {}
}

--- We need the object because we need to know the calling context when we execute the callback
--- functions are first class citizens in Lua and are not 'owned' by their parent tables, which
--- means we can't deduce the calling table/object/parent from the function itself.
function ev:subscribe(eventType, object, callback)
  if (eventType == nil) then
    Log.fatal("Event type cannot be nil")
    return
  end

  if not self.subscriptions[eventType] then
    self.subscriptions[eventType] = {}
  end
  table.insert(self.subscriptions[eventType], { object = object, callback = callback })
end

function ev:publish(eventType, ...)
  if not self.subscriptions[eventType] then
    if self.debug then
      print("No subscriptions for event type: ", EventTypeText[eventType])
    end
    return
  end
  for _, data in ipairs(self.subscriptions[eventType]) do
    data.callback(data.object, ...)
  end
end

--- we need to use the object when ubsubscribing because it is possible for the same callback
--- function to be subscribed to the same event type multiple times, but with different objects.
--- this could happen with a metamethod or similar situation.
--- a = {}; b = {}; function foo() return end
--- a.foo = foo; b.foo = foo
--- print(a.foo, b.foo, a.foo == b.foo)
function ev:unsubscribe(eventType, data)
  if not self.subscriptions[eventType] then return end
  for i, sub in ipairs(self.subscriptions[eventType]) do
    if sub.callback == data.callback and sub.object == data.object then
      table.remove(self.subscriptions[eventType], i)
      return
    end
  end
end

--- The AI thought this would be a good idea...
--- this is a convenience function for creating a subscription that will only be called once.
--- it is useful for things like loading assets, where you only want to load them once.
--- the callback will be unsubscribed after it is called.
function ev:subscribeOnce(eventType, object, callback)
  local function once(...)
    callback(object, ...)
    self:unsubscribe(eventType, { object = object, callback = once })
  end
  self:subscribe(eventType, object, once)
end

--- print the current subscriptions
function ev:printSubscriptions()
  for eventType, subs in pairs(self.subscriptions) do
    print("Event: ", EventTypeText[eventType])
    for _, sub in ipairs(subs) do
      print("  ", sub.object._name, sub.callback)
    end
  end
end

return ev
