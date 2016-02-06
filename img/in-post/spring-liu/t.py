#!/usr/bin/env python3

from PIL import Image
import exifread

import sys
import os
import os.path

IMAGE_EXTENSIONS = ["jpg", "png", "gif"]

os.chdir(sys.argv[1])
for filename in os.listdir():
	if not os.path.splitext(filename)[1][1:].lower() in IMAGE_EXTENSIONS:
		continue
	tags = exifread.process_file(open(filename, 'rb'))
	if not 'Image Orientation' in tags:
		continue

	print(tags['Image Orientation'].printable)
	if 'Rotated 90' in tags['Image Orientation'].printable:
		print(filename)
		Image.open(filename).transpose(Image.ROTATE_90).save(filename)
