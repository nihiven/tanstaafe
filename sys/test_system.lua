--- Assume Event will always be available
local test = {}
test.message = "jb was here"

function test:load(state)
  Event:subscribe(EventType.keypressed, self, self.keypressed)
end

function test:keypressed(state, k)
  print("test.keypressed: ", k)
end

return test
