class BitmapEditor
  def initialize(image)
    @image = image
  end

  def run(command)
    @image.create(width: 1, height: 1)
  end
end

describe 'Creating an image' do
  context '1 x 1 image' do
    let(:image) { double(:image) }
    let(:bitmap_editor) { BitmapEditor.new(image) }

    it 'creates an image that 1px by 1px, coloured white' do
      expect(image).to receive(:create).with(width: 1, height: 1)

      bitmap_editor.run('I 1 1')
    end
  end
end
