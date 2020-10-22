require "image_processing/mini_magick"

class ImageUploader < Shrine
    plugin :derivatives
    # plugin :url_options, store: { host: Rails.application.credentials[Rails.env.to_sym][:image_host] }
    plugin :pretty_location
    
    Attacher.derivatives do |original|
        magick = ImageProcessing::MiniMagick.source(original)
        { 
          thumbnail:  magick.resize_to_limit!(400, 400),
        }
      end
 
    def generate_location(io, record: nil, **context)
        fname = context[:metadata]['filename'].split(".")
        url_path = super.split("/") 
        generated_url = context[:derivative].present? ? "#{url_path[0]}/#{url_path[1]}/thumb/#{JSON.parse(record["image_data"])["metadata"]["filename"]}" : "#{url_path[0]}/#{url_path[1]}/#{context[:metadata]['filename']}"
        return generated_url
    end

end
