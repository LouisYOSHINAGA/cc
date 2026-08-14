/* cc005 */

void setup() {
    size(1150, 800);
    noLoop();
}

void draw() {
    background(240);
    for ( int i = 0; i < 8; i++ ) {
        ring(random(width), random(height), random(512, 1024));
    }
    for ( int i = 0; i < 256; i++ ) {
        ring(random(width), random(height), random(32, 256));
    }
}

void ring(float x, float y, float d) {
    final color[] cs = {
        color( 39, 43, 87),
        color( 38, 55, 130),
        color( 84, 122, 170),
        color(200, 211, 221),
        color( 79, 94, 117),
        color( 45, 44, 45),
        color(233, 77, 71),
        color(237, 111, 0),
        color(251, 203, 114)
    };
    final float dt = PI / 512;

    if (random(2) < 1 ) {
        blendMode(SUBTRACT);
    } else {
        blendMode(BLEND);
    }

    pushMatrix();
    translate(x, y);

    for ( int i = 0; i < 128; i++ ) {
        float ir = random(d) / 2;
        float or = random(1.016, 1.064) * ir;
        float st = random(-PI, PI);
        float et = st + random(HALF_PI);

        noStroke();
        fill(cs[(int)random(cs.length)], random(180, 240));

        beginShape();
        for ( float t = st; t < et; t += dt ) {
            vertex(ir*cos(t), ir*sin(t));
        }
        for ( float t = et; t > st; t -= dt ) {
            vertex(or*cos(t), or*sin(t));
        }
        endShape(CLOSE);
    }

    popMatrix();
}


void keyPressed() {
    if ( key == 's' ) {
        saveFrame("cc005.png");
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
