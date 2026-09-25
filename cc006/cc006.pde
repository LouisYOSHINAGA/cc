/* cc006 */

final color[] cs = {
    color(149, 155, 169),
    color( 94, 101, 102),
    color(211, 210, 191),
    color( 36, 49, 70),
    color( 62, 49, 70),
    color( 62, 87, 112),
    color(217, 117, 86),
    color(241, 173, 95),
    color(225, 198, 192),
    color(224, 140, 122)
};
final float D_TWO_PI = PI / 128;


void setup() {
    size(1150, 800);
    noLoop();
}

void draw() {
    background(240);
    for (int i = 0; i < 32; i++) {
        drawGrowthRing(random(width), random(height), random(0.8, 1.2));
    }
    for (int i = 0; i < 24; i++) {
        drawGrowthRing(random(width), random(height), random(0.4, 0.8));
    }
}

void drawGrowthRing(float w, float h, float s) {
    noiseSeed((long)random(1024));

    pushMatrix();
    translate(w, h);
    rotate(random(-PI, PI));
    scale(s);

    noStroke();
    fill(cs[(int)random(cs.length)], 18);

    float rBase, r;
    for (int i = 0; i < 32; i++) {
        rBase = 16 + (6 + 0.08 * random(-1, 1)) * i;
        beginShape();
        for (float t = 0; t < TWO_PI+3*D_TWO_PI; t += D_TWO_PI) {
            r = rBase * (1 + 0.25 * periodicNoise(t));
            vertex(r*cos(t), r*sin(t));
        }
        endShape(CLOSE);
    }
    popMatrix();
}

float periodicNoise(float t) {
    final float OFFSET = 4;
    final float COEF = 0.75;
    return 2 * (noise(OFFSET+COEF*cos(t), OFFSET+COEF*sin(t)) - 0.5);
}


void keyPressed() {
    if ( key == 's' ) {
        saveFrame("cc006.png");
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
