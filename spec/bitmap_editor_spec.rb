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
      @image.paint_pixel(coordinate: coordinate(x, y), colour: 'A')
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

describe BitmapEditor do
  let(:image) { double(:image) }
  let(:bitmap_editor) { BitmapEditor.new(image) }

  describe 'Creating an image' do
    context '1 x 1 image' do
      it 'creates an image that is 1px by 1px, coloured white' do
        expect(image).to receive(:create).with(width: 1, height: 1)

        bitmap_editor.run('I 1 1')
      end
    end

    context '2 x 1 image' do
      it 'creates an image that is 2px by 1px, coloured white' do
        expect(image).to receive(:create).with(width: 2, height: 1)

        bitmap_editor.run('I 2 1')
      end
    end

    context '3 x 2 image' do
      it 'creates an image that is 3px by 2px, coloured white' do
        expect(image).to receive(:create).with(width: 3, height: 2)

        bitmap_editor.run('I 3 2')
      end
    end
  end

  describe 'Painting a pixel on the image' do
    context 'L 1 1 A' do
      it 'colours the pixel at (1, 1) the colour A' do
        expect(image).to receive(:paint_pixel).with(coordinate: OpenStruct.new(x: 1, y: 1), colour: 'A')

        bitmap_editor.run('L 1 1 A')
      end
    end

    context 'L 2 1 A' do
      it 'colours the pixel at (2, 1) the colour A' do
        expect(image).to receive(:paint_pixel).with(coordinate: OpenStruct.new(x: 2, y: 1), colour: 'A')

        bitmap_editor.run('L 2 1 A')
      end
    end

    context 'L 2 2 A' do
      it 'colours the pixel at (2, 2) the colour A' do
        expect(image).to receive(:paint_pixel).with(coordinate: OpenStruct.new(x: 2, y: 2), colour: 'A')

        bitmap_editor.run('L 2 2 A')
      end
    end

    context 'L 1 1 B' do
      it 'colours the pixel at (1, 1) the colour B'
    end
  end
end
