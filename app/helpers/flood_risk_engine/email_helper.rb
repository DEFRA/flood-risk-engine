# frozen_string_literal: true

module FloodRiskEngine
  module EmailHelper

    # Embed an image inline into html email
    def email_image_tag(image, **)
      path = File.join("/app/assets/images", image)

      full_path = Rails.root.join path

      # This lets us resolve assets that are inside this gem
      full_path = File.join(Gem.loaded_specs["flood_risk_engine"].full_gem_path, path) unless File.exist? full_path

      attachments[image] = File.read full_path
      image_tag(attachments[image].url, **)
    end

  end
end
