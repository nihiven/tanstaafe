--- Assume Event will always be available
local test = {}
test._name = "Test System"
test.message = "we haven't run load() yet"

function test:subscribeToEvents(state)
  Event:subscribe(EventType.load, self, self.load)
  Event:subscribe(EventType.draw, self, self.draw)
  Event:subscribe(EventType.update, self, self.update)
  Event:subscribe(EventType.keypressed, self, self.keypressed)
end

function test:load(state)
  self.message = "we ran load() at least once"
  print("test.load: ", Game:stateText())
end

function test:draw(state)

end

function test:update(state, dt, controls)

end

function test:keypressed(state, k)
  -- "trace" "debug" "info" "warn" "error" "fatal"
  local level = { "trace", "debug", "info", "warn", "error", "fatal" }
  local text = level[tonumber(k)]

  if (k == 'i') then
    Input:publishActions()
  elseif (k == 'p') then
    Event:printSubscriptions()
  elseif (k == 'u') then
    Log.info(Game:stateText())
  elseif (text) then
    Log.level = text
  end
end

return test
