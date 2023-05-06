--- Event System
--- Publishes events (EventType) to subscribed callbacks.
--- Subscriptions require an EventType and a callback function.

-- EventType enum
EventType = {
  --- basic events
  load = 0,
  draw = 1,
  update = 2,
  keypressed = 3,
  state_change = 4, -- when the game state changes
}
local ev = {
  subscriptions = {}
}
function ev:subscribe(eventType, object, callback)
  if not self.subscriptions[eventType] then
    self.subscriptions[eventType] = {}
  end
  table.insert(self.subscriptions[eventType], { object = object, callback = callback })
end

function ev:publish(eventType, ...)
  if not self.subscriptions[eventType] then return end
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
