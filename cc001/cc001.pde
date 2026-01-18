/* cc001 */

void setup() {
    size( 1150, 800 );
    noLoop();
}

void draw() {
    background( 30 );
    for ( int i = 0; i < 128; i++ ) {
        new RotFlower( 
            random( width ), 
            random( height ), 
            random( 400, 1000 ) 
        ).draw();
    }
}

private class RotFlower {
      final color[] cs = {
          color( 163, 214, 206 ), 
          color( 100, 187, 186 ), 
          color(  63, 171, 155 ), 
          color( 133, 203, 191 ), 
          color( 165, 213, 183 ), 
          color(  89, 188, 157 ), 
          color( 100, 157, 112 ), 
          color(  48, 128, 152 ), 
          color(  74, 172, 188 ), 
          color( 234,  77,  21 ), 
          color( 214,  85,  11 )
      };

      final private int n;  // number of rotation
      final private float cw, ch;  // center width, center height
      final private float d;  // default diameter of flower
      final private color c;  // color
      private float a;  // alpha
      private float r;  // radius of flower
      private float s;  // noise seed
      
      RotFlower( float cw, float ch, float d ) {
          this.n = int( random( 5, 12 ) );
          this.cw = cw;
          this.ch = ch;
          this.d = d;
          this.c = this.cs[ int( random( this.cs.length) ) ];
          this.a = 15;
          this.s = int( random( 1024 ) );
          noiseSeed( int( random( 1024 ) ) );
      }
      
      public void draw() {
          pushMatrix();
          translate( this.cw, this.ch );
          for ( float t = 0; t < this.n*TWO_PI; t += PI/400 ) {
              stroke( this.c, a );
              line( 0,  0,  this.r * cos( t ), this.r * sin( t ) );
              this.update();
          }
          popMatrix();
      }
      
      private void update() {
          this.s += 0.04;
          this.a *= map( noise( this.s ), 0, 1, 0.98, 1.02 );
          this.r = this.d / 2 * noise( this.s );
      }
}

void keyPressed() {
    if ( key == 's' ) {
        saveFrame( "cc001.png" );
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
