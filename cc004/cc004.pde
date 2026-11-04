/* cc004 */ //<>//

void setup() {
    size(1150, 800);
    noLoop();
}

void draw() {
    background(235, 230, 237);
    blendMode(BLEND);
    for (int i = 0; i < 8; i++) {
        ambLights(random(4, 16));
    }
    for (int i = 0; i < 16; i++) {
        flows();
    }
    for (int i = 0; i < 2; i++) {
        blendMode(DIFFERENCE);
        ambLights(random(4, 16));
    }
}

void ambLights(float n) {
    final color[] cs = {
        color(218,  65,  72),
        color(208,  15,  49),
        color(165,  26,  41),
        color( 68,  81,  54),
        color( 33,  22,  10),
        color(255, 240, 193),
        color(240, 208, 129),
        color(231, 168,  73)
    };

    noStroke();
    for ( int i = 0; i < n; i++ ) {
        fill(cs[(int)random(cs.length)]);
        if (random(2) < 1) {
            circle(random(width), random(height), random(80, 320));
        } else {
            square(random(width), random(height), random(80, 320));
        }
    }
}

void flows() {
    for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
            if (random(1024) < 1) {
                flow(w, h, get(w, h));
            }
        }
    }
}

void flow(float w, float h, color c) {
    strokeWeight(random(4));
    stroke(c);
    int n = (int)random(80, 240);
    float ws = random(64);
    float dws = noise(w);
    float hs = random(64);
    float dhs = noise(h);
    for (int i = 0; i < n; i++) {
        point(w, h);
        w += cos(16*noise(ws));
        h += sin(16*noise(hs));
        ws += dws;
        hs = dhs;
    }
}


void keyPressed() {
    if ( key == 's' ) {
        saveFrame("cc004.png");
        exit();
    } else if ( key == 'r' ) {
        noiseSeed((long)random(1024));
        redraw();
    }
}
