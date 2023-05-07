--- wrapper for a wrapper!
local inp = require('lib/baton').new({
  controls = {
    action = { 'key:return', 'mouse:1' },
    escape = { 'key:escape' },
    left = { 'key:left', 'key:a', 'axis:leftx-', 'button:dpleft' },
    right = { 'key:right', 'key:d', 'axis:leftx+', 'button:dpright' },
    up = { 'key:up', 'key:w', 'axis:lefty-', 'button:dpup' },
    down = { 'key:down', 'key:s', 'axis:lefty+', 'button:dpdown' },
    jump = { 'key:space' }
  }
})

inp._name = 'Input System'

--- read batons actions and publish them to an input event
function inp:publishActions(state)
  Event:publish(EventType.action, state, self._controls)
end

return inp
