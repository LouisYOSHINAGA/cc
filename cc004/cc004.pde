/* cc004 */ //<>//

void setup() {
  size(1150, 800);
  noiseSeed(317);
  noLoop();
}

void draw() {
  background(235, 230, 237);
  blendMode(BLEND);
  for (int i = 0; i < 8; i++) {
    if (i % 3 != 0) {
      blendMode(BLEND);
    } else {
      blendMode(EXCLUSION);
    }
    ambLights(32);
    flows();
  }
}

void ambLights(int n) {
  final color[] cs = {
    color(218, 65, 72),
    color(208, 15, 49),
    color(165, 26, 41),
    color( 68, 81, 54),
    color( 33, 22, 10),
    color(255, 240, 193),
    color(240, 208, 129),
    color(231, 168, 73)
  };

  noStroke();
  for ( int i = 0; i < n; i++ ) {
    fill(cs[(int)random(cs.length)]);
    if (random(2) < 1) {
      circle(random(width), random(height), random(80, 360));
    } else {
      square(random(width), random(height), random(80, 360));
    }
  }
}

void flows() {
  for (int h = 0; h < height; h++) {
    for (int w = 0; w < width; w++) {
      if (random(256) < 1) {
        flow(w, h, get(w, h));
      }
    }
  }
}

void flow(float w, float h, color c) {
  strokeWeight(0.5);
  stroke(c);
  int n = (int)random(240, 640);
  for (int i = 0; i < n; i++) {
    point(w, h);
    w += cos(noise(16*w/width));
    h += sin(noise(16*h/height));
  }
}


void keyPressed() {
  if ( key == 's' ) {
    saveFrame("cc004.png");
    exit();
  } else if ( key == 'r' ) {
    redraw();
  }
}
