
# SRC_DIR has been volume-mounted to /data
# prints the image_name associated with SRC_DIR
# This is the image_name property of /data/docker/image_name.json

require 'json'

filename = '/data/docker/image_name.json'
content = IO.read(filename)
puts JSON.parse(content)['image_name']
