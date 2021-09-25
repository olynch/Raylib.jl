using Raylib

struct HelloWorldGame <: Game
end

Raylib.title(::HelloWorldGame) = "Hello World Game"

Raylib.draw(::HelloWorldGame) = begin
  clear_background(WHITE)
  draw_text("Raylib init success!", 190, 200, 20, LIGHTGREY)
end

run(HelloWorldGame())
