using Makie, AbstractPlotting
AbstractPlotting.inline!(false)

GLMakie.activate!()
##

scene = Scene()

points = [Point2f0(cos(t), sin(t)) for t in LinRange(0, 2pi, 20)]
colors = 1:20
scatter!(scene, points, color = colors, markersize = 15)

##

scatterobject = scene[end]
scatterobject.markersize = 30
scene

##

xs = -pi:0.01:pi
frequency = Node(3.0) # Node === Observable
phase = Node(0.0)

ys = lift(frequency, phase) do fr, ph
    @. 0.3 * sin(fr * xs - ph)
end

lines!(scene, xs, ys, color = :blue, linewidth = 3)

##

frequency[] = 9
scene

##

save("sineplot.png", scene)

##

framerate = 30 # fps
timestamps = 0:1/framerate:3

record(scene, "phase_animation.mp4", timestamps; framerate = framerate) do t
    phase[] = 2 * t * 2pi
end

##

x = Node(0.0)

x2 = Node{Real}(0.0)
x3 = Node{Any}(0.0)

x[] = 3.34

on(x) do x
  println("New value of x is $x")
end

x[]=5.0

##

value = x[]
value = to_value(x)

f(x) = x^2
y = lift(f, x)

y

##

z = lift(y) do y
  -y
end

x[] = 10.0

@show x[]
@show y[]
@show z[]

##

y[] = 20.0

x[]
y[]
z[]

##

x = Node(rand(100))
y = Node(rand(100))
z = lift((x, y) -> x .+ y, x, y)



##

z = @lift($x .+ $y)

##

y[]=20.

x[]
y[]
z[]

##

xs = LinRange(1, 10, 20)
ys = LinRange(1, 15, 20)
us = [cos(x) for x in xs, y in ys]
vs = [sin(y) for x in xs, y in ys]

arrows(xs, ys, us, vs, arrowsize = 0.2, lengthscale = 0.3)


##


using Makie, AbstractPlotting
AbstractPlotting.inline!(false)

xs = cos.(1:0.5:20)
ys = sin.(1:0.5:20)
zs = LinRange(0, 3, length(xs))

meshscatter(xs, ys, zs, markersize = 0.1, color = zs)


##

using Makie, AbstractPlotting
AbstractPlotting.inline!(false)

r = LinRange(-1, 1, 100)
cube = [(x.^2 + y.^2 + z.^2) for x = r, y = r, z = r]
cube_with_holes = cube .* (cube .> 1.4)

volume(cube_with_holes, algorithm = :iso, isorange = 0.05, isovalue = 1.7)



##

using FileIO, Colors, GeometryBasics, MakieGallery, AbstractPlotting
AbstractPlotting.inline!(false)
 

earth = load(MakieGallery.assetpath("earth.png"))
m = uv_mesh(Tesselation(Sphere(Point3f0(0), 1f0), 60))
mesh(m, color=earth, shading = false)


##



