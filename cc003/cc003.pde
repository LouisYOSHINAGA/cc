/* cc003 */

void setup() {
  size(1150, 800);
  noLoop();
}

void draw() {
  background(0);

  for (int i = 0; i < 512; i++) {
    beziers((int)random(32, 256));
  }

  noStroke();
  fill(240, 0, 0, 100);
  circle(width/2, height/2, 720);

  for (int i = 0; i < 64; i++) {
    beziers((int)random(32, 128));
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
    color(185, 64, 71)
  };
  final float R = random(0.8, 1.2);

  noiseSeed((int)random(1024));
  stroke(cs[(int)random(cs.length)]);
  noFill();

  float sx = random((1-R)*width, R*width);
  float sy = random((1-R)*height, R*height);
  float c1x = random(width);
  float c1y = random(height);
  float c2x = random(width);
  float c2y = random(height);
  float ex = random((1-R)*width, R*width);
  float ey = random((1-R)*height, R*height);
  float amp = random(2);

  for (int i = 0; i < n; i++) {
    bezier(sx, sy, c1x, c1y, c2x, c2y, ex, ey);
    sx += amp * (noise(sx/width) - 0.5);
    sy += amp * (noise(sy/height) - 0.5);
    c1x += amp * (noise(sx/width) - 0.5);
    c1y += amp * (noise(sy/height) - 0.5);
    c2x += amp * (noise(sx/width) - 0.5);
    c2y += amp * (noise(sy/height) - 0.5);
    ex += amp * (noise(ex/width) - 0.5);
    ey += amp * (noise(ey/height) - 0.5);
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
