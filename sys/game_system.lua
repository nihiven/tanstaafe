--- Game System
--- TODO: need to map incoming actions to functions
--- TODO: need to facilitate state changes

--#region Global Types
GameState = {
  menu = 1,  -- main menu, not in game
  game = 2,  -- in game, actively playing
  pause = 3, -- in game, but paused
  quit = 4   -- quitting, exit now
}
--- translates GameState to text
GameStateText = {
  [GameState.menu] = 'menu',
  [GameState.game] = 'game',
  [GameState.pause] = 'paused',
  [GameState.quit] = 'quit'
}
--- maps GameState to a list of valid next states
GameStateMap = {
  [GameState.menu] = { GameState.game, GameState.quit },
  [GameState.game] = { GameState.pause },
  [GameState.pause] = { GameState.Menu, GameState.game, GameState.quit }
  -- dont need quit mapped as its a terminal state
}
-- endregion

-- the big game system table
local gm = {}
gm._name = "Game System"
gm._version = "0.1.0"
gm.state = GameState.menu

-- return a given GameState as a string from GameStateText
function gm:stateText()
  return GameStateText[self.state]
end

function gm:subscribeToEvents(state)
  Event:subscribe(EventType.load, self, self.load)
  Event:subscribe(EventType.draw, self, self.draw)
  Event:subscribe(EventType.update, self, self.update)
  Event:subscribe(EventType.keypressed, self, self.keypressed)
  Event:subscribe(EventType.state_change, self, self.stateChange)
end

function gm:load(state)
  print("Game.load: ", self:stateText(state))
end

function gm:draw(state)

end

function gm:update(state, dt, controls)
  --- check controls here!
  if (controls['quit'].pressed) then
    pp(controls)
    Event:publish(EventType.quit)
  end
end

-- TODO: finish this function (gm:stateChange)
function gm:stateChange(state, new_state)
  print("Game.state_change: ", state, "=>", new_state)
  self.state = new_state
end

--- map incoming actions to functions
function gm:input(state, controls)
  print(state, controls)
end

--- replace this with action()
function gm:keypressed(state, k)
  if (k == "h") then
    print("hey")
    pp(Input._controls)
    for key, value in pairs(Input._controls) do
      print(key, value)
    end
  end
end

return gm
