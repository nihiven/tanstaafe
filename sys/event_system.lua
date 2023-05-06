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
  action = 5,       -- input from baton
}
EventTypeText = {
  [EventType.load] = 'load',
  [EventType.draw] = 'draw',
  [EventType.update] = 'update',
  [EventType.keypressed] = 'keypressed',
  [EventType.state_change] = 'state_change',
  [EventType.action] = 'baton action',
}
local ev = {
  debug = true,
  subscriptions = {}
}
function ev:subscribe(eventType, object, callback)
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

function ev:unsubscribe(eventType, data)
  if not self.subscriptions[eventType] then return end
  for i, sub in ipairs(self.subscriptions[eventType]) do
    if sub.callback == data.callback and sub.object == data.object then
      table.remove(self.subscriptions[eventType], i)
      return
    end
  end
end

return ev
