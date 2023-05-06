--- TODO: Event System: Broadcast events to all objects that are listening for them. Use this for communication between components. [lib: home grown]
--- Event System
--- This will go into it's own file once it's working.
--- The Event System publishes events to subscribed objects.
--- Objects subscribe by providing an event type and a callback function.
-- EventType enum
EventType = {
  --- basic events
  load = 0,
  draw = 1,
  update = 2,
  keypressed = 3,
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

return ev
