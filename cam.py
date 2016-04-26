#!/usr/bin/python
# ^^ If you install opencv with apt-get
# Otherwise, if you compile from source, update to the virtualenv you installed it in
#
# Note: I don't feel like compiling this or installing hy system-wide,
#       so regular python it is.

import os
import sys
try:
    import cv2
except:
    cv2 = None


def get_cap():
    if sys.argv[-1] == '1':
        cap = cv2.VideoCapture(0)
    else:
        cap = cv2.VideoCapture(1)

    return cap


def save(frame):
    cur_dir = os.path.dirname(os.path.realpath(__file__))
    picdump = os.path.join(cur_dir, 'picdump')
    if not os.path.exists(picdump):
        os.mkdir(picdump)

    cv2.imwrite(os.join(picdump, 'picout.png', frame)


def capture(cap):
    cap.set(3,640)
    cap.set(4,480)
    ret, frame = cap.read()
    cap.release()
    return frame


def main():
    if cv2:
        cap = get_cap()
        frame = capture(cap)
        save(frame)


if __name__ == '__main__':
    main()

