

defmodule Raytracer do
  def render(width, height) do
    pixels = for y <- 0..height-1, x <- 0..width-1 do
      ray = create_ray(x, y, width, height)
      color = trace(ray)
      {x, y, color}
    end
    pixels
  end

  def create_ray(x, y, width, height) do
    fov = 90
    aspect_ratio = width / height
    angle = :math.tan(fov / 2 * :math.pi / 180)
    norm_x = (2 * (x + 0.5) / width - 1) * angle * aspect_ratio
    norm_y = (1 - 2 * (y + 0.5) / height) * angle
    dir = {norm_x, norm_y, -1}
    origin = {0, 0, 0}
    {origin, dir}
  end

  def trace(ray) do
    intersected = intersect_scene(ray)
    case intersected do
      {object, intersection_point} ->
        shade(object, intersection_point)
      :missed ->
        {0, 0, 0}
    end
  end

  def intersect_scene(ray) do
    # Implementation of object intersection goes here
  end

  def shade(object, point) do
    # Implementation of shading goes here
  end
import Gleam
import PNG

  def run() do
    width = 640
    height = 480
    pixels = Raytracer.render(width, height)
    image = png.create_rgba(width, height, pixels)
    png.write_file(image, "output.png")
    IO.puts("Rendered image to output.png")
  end
  def start() do
    RaytracerDemo.run()
  end

end
