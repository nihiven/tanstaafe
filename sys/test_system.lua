--- Assume Event will always be available
local test = {
  message = "jb was here",
  load = function()
    print("test.load")
  end,
  keypressed = function(data)
    print("test.keypressed: ", data.key)
    if data.key == 'escape' then LE.quit() end
  end,
}

--- subscribe to events
Event.subscribe(EventType.load, test.load)
Event.subscribe(EventType.keypressed, test.keypressed)

return test
