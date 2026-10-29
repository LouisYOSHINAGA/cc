/* cc007 */

final color[] cs = {
    color(241, 143, 96),
    color(251, 240, 198),
    color(252, 231, 88),
    color(167, 169, 148),
    color(151, 131, 93),
    color(226, 215, 168),
    color(52, 60, 28),
    color(82, 76, 31),
    color(206, 49, 8)
};

void setup() {
    size(1150, 800);
    noLoop();
}

void draw() {
    background(242, 241, 245);
    for (int i = 0; i < 28; i++) {
        if (random(10) < 1) {
            blendMode(SUBTRACT);
        } else {
            blendMode(BLEND);
        }

        noiseBand(random(width), random(height), random(8, 32), random(1024, 4096));

        noStroke();
        fill(cs[(int)random(cs.length)]);
        square(random(width), random(height), random(80, 320));
    }
}

void noiseBand(float w, float h, float vl, float hl) {
    noiseSeed((long)random(1024));
    pushMatrix();
    translate(w, h);
    rotate(random(-PI, PI));

    float gap, dx, a;
    for (float y = -vl/2; y < vl/2; y += gap/8) {
        stroke(cs[(int)random(cs.length)]);
        gap = random(4, 16);
        dx = 4 * (noise(w/width, h/height) - 0.5);
        a = random(256, 1024);
        for ( float x = -hl/2 - dx; x < dx + hl/2; x++) {
            float nh = y + a * (noise(x/width, y/height) - 0.5);
            line(x, nh, x, nh+gap);
        }
    }
    
    popMatrix();
}


void keyPressed() {
    if ( key == 's' ) {
        saveFrame("cc007.png");
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
