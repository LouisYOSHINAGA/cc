/* cc009 */

final color[] cs = {
    color(218, 205, 139),
    color(174, 154, 107),
    color( 92, 118, 100),
    color(  0, 126, 118),
    color(245, 242, 210),
    color(230, 224, 196),
    color( 85, 125,  62),
    color( 73,  49,  60),
    color(235,  92,  50),
};

void setup() {
    size(1150, 800);
    noLoop();
    rectMode(CENTER);
}

void draw() {
    background(240);
    for (int i = 0; i < 64; i++) {
        if (random(8) < 1) {
            blendMode(DIFFERENCE);
        } else {
            blendMode(BLEND);
        }
        squareSpiral(random(width), random(height), random(64, 256));
    }
}

void squareSpiral(float x, float y, float n) {
    noiseSeed((long)random(1024));

    pushMatrix();
    translate(x, y);

    strokeWeight(random(1, 4));
    noFill();

    color c = cs[(int)random(cs.length)];
    float t = PI / random(128, 256);
    float s = random(2) < 1? 1: -1;
    float l = 0;
    float dl = random(2);
    float w = random(1);
    float ws = random(1);
    float h = random(1);
    float hs = random(1);

    for (int i = 0; i < n; i++) {
        stroke(c, 255 * noise(i/n));
        rotate(s * t);
        square(w, h, l);

        if (random(32) < 1) {
            c = cs[(int)random(cs.length)];
            t = PI / random(128, 256);
            s = random(2) < 1? 1: -1;
        }

        l += dl;
        w += 2 * (noise(ws) - 0.5);
        h += 2 * (noise(hs) - 0.5);
    }

    popMatrix();
}


void keyPressed() {
    if ( key == 's' ) {
        saveFrame("cc009.png");
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
