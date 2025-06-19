require 'bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain modules that send external commands, but
  # do not create new files.
  module Requests
    extend Bandoleer

    vials = %i[image_info
               sound_info
               video_info
               image_open
               sound_open
               video_open
               vampyre_bite
               vst_request]

    equip vials
  end
end
