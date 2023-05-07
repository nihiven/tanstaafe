--- Game System
--- TODO: need to map incoming actions to functions
--- TODO: need to facilitate state changes

--#region Global Types
GameState = {
  menu = 1,   -- main menu, not in game
  game = 2,   -- in game, actively playing
  paused = 3, -- in game, but paused
  quit = 4    -- quitting, exit now
}
--- translates GameState to text
GameStateText = {
  [GameState.menu] = 'menu',
  [GameState.game] = 'game',
  [GameState.paused] = 'paused',
  [GameState.quit] = 'quit'
}
--- maps GameState to a list of valid next states
GameStateMap = {
  [GameState.menu] = { GameState.game, GameState.quit },
  [GameState.game] = { GameState.paused },
  [GameState.paused] = { GameState.Menu, GameState.game, GameState.quit }
  -- dont need quit mapped as its a terminal state
}
-- endregion

local gm = {}
gm._name = "Game System"
gm.state = GameState.menu
gm.actionMap = {
  [GameState.menu] = {
    ['action'] = function() print("menu action") end,
    ['escape'] = function() print("menu escape") end
  },
  [GameState.game] = {
    ['action'] = function() print("game action") end,
    ['escape'] = function() print("game escape") end
  },
  [GameState.paused] = {
    ['action'] = function() print("paused action") end,
    ['escape'] = function() print("paused escape") end
  }
}

function gm:subscribeToEvents(state)
  Event:subscribe(EventType.load, self, self.load)
  Event:subscribe(EventType.draw, self, self.draw)
  Event:subscribe(EventType.update, self, self.update)
  Event:subscribe(EventType.keypressed, self, self.keypressed)
  Event:subscribe(EventType.state_change, self, self.stateChange)
  Event:subscribe(EventType.action, self, self.action)
end

function gm:load(state)
  print("Game.load: ", state)
end

function gm:draw(state)

end

function gm:update(state, dt)

end

function gm:stateChange(state, new_state)
  print("Game.state_change: ", state, "=>", new_state)
  self.state = new_state
end

--- map incoming actions to functions
function gm:action(state, input)
  for _, v in ipairs(input) do
    if self.actionMap[state][v] then
      print(state, v)
      self.actionMap[state][v]()
    end
  end
end

--- replace this with action()
function gm:keypressed(state, k)
  if k == 'escape' then
    if self.state == GameState.game then
      self.state = GameState.paused
    elseif self.state == GameState.paused then
      self.state = GameState.game
    elseif self.state == GameState.menu then
      LE.quit()
    end
    Event:publish(EventType.stateChange, GameState.paused)
  end
  if k == ',' then
    --- change state to 'next'
    print("Game.state: ", self.state, GameStateText[self.state])
    Event:publish(EventType.stateChange, GameState.game)
  end
end

return gm
