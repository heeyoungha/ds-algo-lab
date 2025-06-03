import math
keyinput = ["down", "down", "down", "down", "down"]

bx, by = 7, 9
cx, cy = 0, 0
for key in keyinput:
    if key == "left":
        if cx -1 >= -math.floor(bx/2):
            cx = cx-1
    elif key == "right":
        if (cx +1 <= math
                .floor(bx/2)):
            cx = cx+1
    elif key == "up":
        if cy + 1 <= math.floor(by/2):
            cy = cy+1
    elif key == "down":
        if cy - 1 >= -math.floor(by/2):
            cy = cy-1
print(cx, cy)