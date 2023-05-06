--- Game System
GameState = {
  menu = 1,
  game = 2,
  paused = 3
}
GameStateText = {
  [GameState.menu] = 'menu',
  [GameState.game] = 'game',
  [GameState.paused] = 'paused'
}

local gm = {}
gm.state = GameState.menu
print(gm.state)

function gm:load()
  Event:subscribe(EventType.draw, self, self.draw)
  Event:subscribe(EventType.update, self, self.update)
  Event:subscribe(EventType.keypressed, self, self.keypressed)
end

function gm:draw(...)

end

function gm:update(dt)

end

function gm:keypressed(k)
  print("Game.keypressed: ", k)
  if k == 'escape' then LE.quit() end
  if k == ',' then
    --- change state to 'next'
    print("Game.state: ", self.state, GameStateText[self.state])
    Event:publish(EventType.state_change, GameState.game)
  end
end

return gm
