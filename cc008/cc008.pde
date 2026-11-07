/* cc008 */

final color[] cs = {
    color(163, 214, 206),
    color(100, 187, 186),
    color( 63, 171, 155),
    color(133, 203, 191),
    color(165, 213, 183),
    color( 89, 188, 157),
    color(100, 157, 112),
    color( 48, 128, 152),
    color( 74, 172, 188)
};


void setup() {
    size(1150, 800);
    noLoop();
}

void draw() {
    background(240);
    for (int i = 0; i < 16; i++) {
        circleObjects(random(width), random(height), random(320, 640));
    }
    for (int i = 0; i < 64; i++) {
        circleObjects(random(width), random(height), random(80, 240));
    }
}

void circleObjects(float x, float y, float d) {
    switch((int)random(4)) {
    case 0:
        strokedCircle(x, y, d);
        break;
    case 1:
        hole(x, y, d);
        break;
    case 2:
        dotSpiral(x, y, d);
        break;
    case 3:
        trembleCircle(x, y, d);
        break;
    default:  // never reached
        break;
    }
}

void strokedCircle(float x, float y, float d) {
    strokeWeight(random(1.6, 7.2));
    stroke(cs[(int)random(cs.length)]);
    fill(cs[(int)random(cs.length)], random(80, 240));
    circle(x, y, d);
}

void dotSpiral(float x, float y, float d) {
    strokeWeight(random(0.8, 2.4));
    stroke(cs[(int)random(cs.length)]);

    float dr = random(0.01, 0.1);
    float t = random(-PI, PI);
    float dt = random(-1, 1) * PI;
    for (float r = d/2; r > 0; r -= dr) {
        point(x+r*cos(t), y+r*sin(t));
        t += dt;
        if (random(512) < 1) {
            dt = random(-1, 1) * PI;
        }
    }
}

void trembleCircle(float x, float y, float d) {
    strokeWeight(random(1.0, 2.2));
    stroke(cs[(int)random(cs.length)]);
    noFill();

    float dr, t;
    while (d > 16) {
        dr = random(8);
        t = random(-PI, PI);
        x += dr * cos(t);
        y += dr * sin(t);
        d -= 2 * dr;
        circle(x, y, d);
    }
}

void hole(float x, float y, float d) {
    float a = random(64, 72);
    float r = random(0.4, 0.8) * d;
    color c = cs[(int)random(cs.length)];

    noFill();
    while (a > 0) {
        stroke(c, a--);
        circle(x, y, r++);
    }
}


void keyPressed() {
    if ( key == 's' ) {
        saveFrame("cc008.png");
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
