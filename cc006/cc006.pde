/* cc006 */

final color[] cs = {
    color(149, 155, 169),
    color( 94, 101, 102),
    color(211, 210, 191),
    color( 36,  49,  70),
    color( 62,  49,  70),
    color( 62,  87, 112),
    color(217, 117,  86),
    color(241, 173,  95),
    color(225, 198, 192),
    color(224, 140, 122)
};
final int PROCESSING_YEAR = 25;
final float D_TWO_PI = PI / 128;
final String MESSAGE = "Processing 25th Anniversary";


void setup() {
    size(1150, 800);
    noLoop();
    textAlign(CENTER, CENTER);
}

void draw() {
    background(240);
    for (int year = 0; year < PROCESSING_YEAR; year++) {
        drawGrowthRing(random(width), random(height), random(0.32, 1.28));
        putString(MESSAGE, random(width), random(height), random(4, 8), random(4, 8));
    }
}

void drawGrowthRing(float w, float h, float s) {
    noiseSeed((long)random(1024));

    pushMatrix();
    translate(w, h);
    rotate(random(-PI, PI));
    scale(s);

    color c = cs[(int)random(cs.length)];
    strokeWeight(map(s, 0.25, 1.0, 1.6, 2.4));
    stroke(c);
    fill(c, 24);

    float rBase, r;
    for (int year = 0; year < PROCESSING_YEAR; year++) {
        rBase = 16 + (8 + 0.16 * random(-1, 1)) * year;
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

void putString(String t, float w, float h, float s, float n) {
    pushMatrix();
    translate(w, h);
    rotate(random(-PI, PI));
    textSize(pow(2, s));
    for (int i = 0; i < n; i++) {
        scale(1.01);
        rotate(PI/512);
        fill(cs[(int)random(cs.length)]);
        text(t, 0, 0);
    }
    popMatrix();
}


void keyPressed() {
    if ( key == 's' ) {
        saveFrame("cc006.png");
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
