module Paperclip
  # Handles grayscale conversion of images that are uploaded.
  class Multiply < Processor

    def initialize file, options = {}, attachment = nil
      super
      @format = File.extname(@file.path)
      @basename = File.basename(@file.path, @format)
    end

    def make  
      src = @file
      dst = Tempfile.new([@basename, @format])
      dst.binmode

      begin
        parameters = []
        parameters << "-compose Multiply -gravity center"
        parameters << ":yellow :source"
        parameters << ":dest"

        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")

        success = Paperclip.run("composite", parameters, :yellow => "#{Rails.root.to_s}/config/yellow_layer.jpg", :source => "#{File.expand_path(src.path)}[0]", :dest => File.expand_path(dst.path))
      rescue 
        raise PaperclipError, "There was an error during the grayscale conversion for #{@basename}" if @whiny
      end

     dst
   end

  end
end