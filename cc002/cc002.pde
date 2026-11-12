/* cc002 */

final color[] cs = {
    color(244, 246, 241),
    color(242, 243, 234),
    color(220, 221, 210),
    color( 87,  98, 105),
    color(135, 121, 109),
    color(202, 196, 172),
    color( 57,  51,  44),
    color(197, 151,  99),
    color(148, 100,  53)
};
final int FONTSIZE = 16;
final int N_VIBES = 4;
final float R = 0.01;
final int ALPHA_OFFSET = 2;
final int D_ALPHA = (128 - ALPHA_OFFSET) / N_VIBES;

void setup() {
    size(1150, 800);
    noLoop();
    noStroke();
    textFont(createFont("Consolas", FONTSIZE));
    textAlign(CENTER, CENTER);
}

void draw() {
    background(240);
    float r;
    for (float h = 0; h < height+FONTSIZE; h += FONTSIZE) {
        for (float w = 0; w < width+FONTSIZE; w += FONTSIZE) {
            if (random(512) < 1) {
                r = random(32, 128);
            } else {
                r = random(0.8, 3.2);
            }
            vibestr(genstr(1), w, h, r*FONTSIZE);
        }
    }
    for (int i = 0; i < 8; i++) {
        if (random(2) < 1) {
            blendMode(BLEND);
        } else {
            blendMode(DIFFERENCE);
        }
        vibestr(genstr(1), random(width), random(height), random(16, 64)*FONTSIZE);
    }
}

String genstr(int n) {
    String s = "";
    for (int i = 0; i < n; i++) {
        if (random(2) > 1) {
            s += (char)random('A', 'Z'+1);
        } else {
            s += (char)random('a', 'z'+1);
        }
    }
    return s;
}

void vibestr(String s, float x, float y, float size) {
    pushMatrix();
    translate(x, y);

    textSize(size);
    color c = cs[(int)random(cs.length)];
    for (int i = 0; i < N_VIBES; i++) {
        fill(c, ALPHA_OFFSET+D_ALPHA*(N_VIBES-i));
        text(s, random(-1, 1), -R*size*(i+1));
    }

    fill(c);
    text(s, 0, 0);
    for (int i = 0; i < N_VIBES; i++) {
        fill(c, 128-(i+1)*D_ALPHA);
        text(s, random(-1, 1), R*size*(i+1));
    }

    popMatrix();
}


void keyPressed() {
    if ( key == 's' ) {
        saveFrame("cc002__.png");
        exit();
    } else if ( key == 'r' ) {
        blendMode(BLEND);
        redraw();
    }
}
