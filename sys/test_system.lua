--- Assume Event will always be available
local test = {}
test.message = "jb was here"

function test:load()
  Event:subscribe(EventType.keypressed, self, self.keypressed)
end

function test:keypressed(k)
  print("test.keypressed: ", k)
end

return test
