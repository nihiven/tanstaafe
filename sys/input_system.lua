--- wrapper for a wrapper!
local inp = require('lib/baton').new({
  controls = {
    action = { 'key:return', 'mouse:1' },
    quit = { 'key:escape', 'key:q' },
    left = { 'key:left', 'key:a', 'axis:leftx-', 'button:dpleft' },
    right = { 'key:right', 'key:d', 'axis:leftx+', 'button:dpright' },
    up = { 'key:up', 'key:w', 'axis:lefty-', 'button:dpup' },
    down = { 'key:down', 'key:s', 'axis:lefty+', 'button:dpdown' },
    jump = { 'key:space' }
  }
})

inp._name = 'Input System'

return inp
