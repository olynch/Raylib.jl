using Raylib
using StaticArrays

struct BallGame <: Game
  pos::MVector{2,Float32}
end

function Raylib.update!(g::BallGame)
  if is_key_down(Keys.RIGHT)
    g.pos[1] += 2.0
  elseif is_key_down(Keys.LEFT)
    g.pos[1] -= 2.0
  elseif is_key_down(Keys.UP)
    g.pos[2] -= 2.0
  elseif is_key_down(Keys.DOWN)
    g.pos[2] += 2.0
  end
end

function Raylib.draw(g::BallGame)
  clear_background(WHITE)
  draw_text("move the ball with arrow keys", 10, 10, 20, LIGHTGREY)
  draw_circle(g.pos, 50, RayColor(0,0,0, 255))
end

run(BallGame(SA_F32[400, 225]))
