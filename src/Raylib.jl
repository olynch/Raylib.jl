module Raylib

export Game, RayColor, WHITE, LIGHTGREY,
  clear_background, draw_text, draw_circle, draw_line, is_key_down,
  Keys

using Raylib_jll

module Keys
include("Keys.jl")
end

struct RayColor
  r::UInt8
  g::UInt8
  b::UInt8
  a::UInt8
end

const WHITE = RayColor(255,255,255,255)
const LIGHTGREY = RayColor(180,180,180,255)

abstract type Game end

struct WindowSettings
  width::Int
  height::Int
  title::String
  fps::Int
end

width(g::Game) = 800

height(g::Game) = 450

title(g::Game) = "raylib game in Julia"

fps(g::Game) = 60

settings(g::Game) = WindowSettings(width(g), height(g), title(g), fps(g))

draw(g::Game) = nothing

update!(g::Game) = nothing

function Base.run(game::Game)
  s = settings(game)
  ccall((:InitWindow, libraylib), Cvoid, (Cint,Cint,Cstring), s.width, s.height, s.title)
  ccall((:SetTargetFPS, libraylib), Cvoid, (Cint,), s.fps)
  while ccall((:WindowShouldClose, libraylib), Cuchar, ()) == 0
    update!(game)
    ccall((:BeginDrawing, libraylib), Cvoid, ())
    draw(game)
    ccall((:EndDrawing, libraylib), Cvoid, ())
  end
  ccall((:CloseWindow, libraylib), Cvoid, ())
end

clear_background(c::RayColor) =
  ccall((:ClearBackground, libraylib), Cvoid, (RayColor,), c)

draw_text(t::String, x::Int, y::Int, w::Int, c::RayColor) =
  ccall((:DrawText, libraylib), Cvoid, (Cstring, Cint, Cint, Cint, RayColor), t, x, y, w, c)

struct RayVector2
  x::Float32
  y::Float32
  RayVector2(v::AbstractVector{<:Real}) = new(convert(Float32, v[1]),convert(Float32, v[2]))
end

draw_circle(v::AbstractVector{<:Real}, r::Real, c::RayColor) =
  ccall((:DrawCircleV, libraylib), Cvoid, (RayVector2, Cfloat, RayColor),
        RayVector2(v), convert(Float32, r), c)

draw_line(v1::AbstractVector{<:Real}, v2::AbstractVector{<:Real}, r::Real, c::RayColor) =
  ccall((:DrawLineEx, libraylib), Cvoid, (RayVector2, RayVector2, Cfloat, RayColor),
        RayVector2(v1), RayVector2(v2), convert(Float32, r), c)

is_key_down(k::Int) =
  ccall((:IsKeyDown, libraylib), Cuchar, (Cint,), k) == 1

end
