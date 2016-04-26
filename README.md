# Pushy.hy

This is a [hy-ified](https://github.com/hylang/hy) fork of my other small project, [pushpy](https://github.com/jaemk/pushpy).


* An opencv install:
  * compile from source... see [pyimagesearch](http://www.pyimagesearch.com/2015/07/27/installing-opencv-3-0-for-both-python-2-7-and-python-3-on-your-raspberry-pi-2/)
  * or do a dirty and install using apt-get `apt-get install python-opencv` (only python2 bindings) 
  * make sure the shebang line in `cam.py` points to the python with opencv
* Rename `settings_copy.hy` to `settings.hy` -- enter personal pushbullet api key and main user's name

