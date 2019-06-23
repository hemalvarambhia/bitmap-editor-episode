require 'ostruct'

class BitmapEditor
  WIDTH  = 0.freeze
  HEIGHT = 1.freeze

  def initialize(image)
    @image = image
  end

  def run(command)
    type, *args = command.split
    case type
    when 'I'
      initialize_image(width: args[WIDTH].to_i, height: args[HEIGHT].to_i)
    when 'L'
      x = args[0].to_i
      y = args[1].to_i
      colour = args[2]
      @image.paint_pixel(coordinate: coordinate(x, y), colour: colour)
    end

  end

  private

  def initialize_image(width:, height:)
    @image.create(width: width, height: height)
  end

  def coordinate(x, y)
    OpenStruct.new(x: x, y: y)
  end
end
