if (global.mundo) {
    image_blend = c_dkgray;
    image_alpha = 0.5;
} else {
    image_blend = c_white;
    image_alpha = 1;
}
timer++;
ydraw = ystart + sin(timer * .03) * 3;