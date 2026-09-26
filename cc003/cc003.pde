/* cc003 */

void setup() {
    size(1150, 800);
    noLoop();
}

void draw() {
    background(240);

    blendMode(BLEND);
    for (int i = 0; i < 10; i++) {
        beziers((int)random(256, 512));
    }

    blendMode(DIFFERENCE);
    noStroke();
    fill(240);
    circle(width/2, height/2, 480);

    for (int i = 0; i < 6; i++) {
        beziers((int)random(256, 512));
    }
}

void beziers(int n) {
    final color cs[] = {
        color(240, 145, 153),
        color(242, 160, 161),
        color(254, 244, 244),
        color(239, 132, 104),
        color(244, 165, 131),
        color(252, 226, 196),
        color(185,  64,  71)
    };
    final float R = random(0.8, 0.9);
    final float NR = 10;

    color c = cs[(int)random(cs.length)];
    noFill();
    noiseSeed((int)random(1024));

    float sx = random((1-R)*width, R*width);
    float sy = random((1-R)*height, R*height);
    float c1x = random(width);
    float c1y = random(height);
    float c2x = random(width);
    float c2y = random(height);
    float ex = random((1-R)*width, R*width);
    float ey = random((1-R)*height, R*height);
    float amp = random(5);

    for (int i = 0; i < n; i++) {
        if (random(10) < 1) {
            stroke(cs[(int)random(cs.length)]);
        } else {
            stroke(c, 128*noise(0.01*i/n));
        }
        
        bezier(sx, sy, c1x, c1y, c2x, c2y, ex, ey);
        sx += amp * (noise(NR*sx/width) - 0.5);
        sy += amp * (noise(NR*sy/height) - 0.5);
        c1x += amp * (noise(NR*sx/width) - 0.5);
        c1y += amp * (noise(NR*sy/height) - 0.5);
        c2x += amp * (noise(NR*sx/width) - 0.5);
        c2y += amp * (noise(NR*sy/height) - 0.5);
        ex += amp * (noise(NR*ex/width) - 0.5);
        ey += amp * (noise(NR*ey/height) - 0.5);
    }
}


void keyPressed() {
    if ( key == 's' ) {
        saveFrame("cc003.png");
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
