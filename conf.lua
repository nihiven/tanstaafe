function love.conf(t)
  t.title = "TANSTAAFE'23"            -- The title of the window the game is in (string)
  t.identity = "TANSTAAFE"            -- The name of the save directory (string)
  t.version = "11.4"                  -- The LÖVE version this game was made for (string)
  t.console = true                    -- Attach a console (boolean, Windows only)

  t.window.borderless = false         -- Remove all border visuals from the window (boolean)
  t.window.resizable = false          -- Let the window be user-resizable (boolean)
  t.window.fullscreen = false         -- Enable fullscreen (boolean)
  t.window.fullscreentype = "desktop" -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
  t.window.vsync = 1                  -- Vertical sync mode (number)
  t.window.msaa = 0                   -- The number of samples to use with multi-sampled antialiasing (number)
end
