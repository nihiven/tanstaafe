--- Assume Event will always be available
local test = {}
test.message = "we haven't run load() yet"

function test:subscribeToEvents(state)
  Event:subscribe(EventType.load, self, self.load)
  Event:subscribe(EventType.draw, self, self.draw)
  Event:subscribe(EventType.update, self, self.update)
  Event:subscribe(EventType.keypressed, self, self.keypressed)
end

function test:load(state)
  self.message = "we ran load() at least once"
  print("test.load: ", state)
end

function test:draw(state)

end

function test:update(state, dt)

end

function test:keypressed(state, k)
  if (k == 'i') then
    Input:publishActions()
  end
end

return test
