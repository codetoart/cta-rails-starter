require "image_processing/mini_magick"

class ImageUploader < Shrine
    plugin :derivatives
    # plugin :url_options, store: { host: Rails.application.credentials[Rails.env.to_sym][:image_host] }
    plugin :pretty_location
    plugin :derivation_endpoint,
    secret_key: Rails.application.credentials[Rails.env.to_sym][:aws][:secret_access_key],
    prefix:     "varient/images"
    
    derivation :thumbnail do |file, width, height|
       ImageProcessing::MiniMagick
        .source(file)
        .resize_to_limit!(width.to_i, height.to_i)
    end
 
    # def generate_location(io, record: nil, **context)
    #     fname = context[:metadata]['filename'].split(".")
    #     url_path = super.split("/") 
    #     generated_url = record.present? ? "#{url_path[0]}/#{url_path[1]}/#{context[:metadata]['filename']}" : "images/#{fname[0]}-#{rand.to_s[2..7].to_i}.#{fname[1]}"
    #     return generated_url
    # end

end
