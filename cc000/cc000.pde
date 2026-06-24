/* cc000 */

private final color[] cs = {
    color(  39,  43,  87 ),
    color(  38,  55, 130 ),
    color(  84, 122, 170 ),
    color( 200, 211, 221 ),
    color(  79,  94, 117 ),
    color(  45,  44,  45 ),
    color( 233,  77,  71 ),
    color( 237, 111,   0 ),
    color( 251, 203, 114 )
};

void setup() {
    size( 1150, 800 );
    noLoop();
}

void draw() {
    background( 240 );
    
    blendMode(BLEND);
    for( int i = 0; i < 18; i++ ) {
          new OverlappedCircle( int( random( 120, 180 ) ) ).draw();
    }
    
    blendMode(DIFFERENCE);
    noStroke();
    for( int i = 0; i < 24; i++ ){
          fill( cs[ int( random( cs.length ) ) ] );
          circle( random( width ), random( height ), random( 80, 480 ) );
    }
    
    blendMode(BLEND);
    for( int i = 0; i < 8; i++ ) {
          new OverlappedCircle( int( random( 180, 240 ) ) ).draw();
    }
}

private class OverlappedCircle {        
    private final int n;  // number of iteration
    private final float d;  // adjustment element
    private int cw, ch;  // center width, height
    private float ew, eh;  // ellipse width, height
    private float t;  // rotation angle
    
    OverlappedCircle( int n, int lw, int rw, float le, float re ) {
        this.n = n;
        this.d = random( 128, 1024 );
        this.cw = int( random( lw, rw ) );
        this.ch = int( random( height ) );
        this.ew = random( le, re );
        this.eh = random( le, re );
        this.t = random( TAU );
    }
    
    private void selectStrokeColor() {
        strokeWeight( random( 0.8, 3.2 ) );
        stroke( cs[ int( random( cs.length ) ) ], random( 50, 100 ));
        noFill();
    }
    
    public void draw() {
        noiseSeed( int( random(1024) ) );
        this.selectStrokeColor();

        for( int i = 0; i < this.n; i++ ) {
            pushMatrix();
            translate( this.cw, this.ch );
            rotate( this.t );
            ellipse( 0, 0, this.ew, this.eh );
            popMatrix();

            cw += random( -1, 1 ) / d;
            ch += random( -1, 1 ) / d;
            ew += random( -1, 1 ) / d;
            eh += random( -1, 1 ) / d;
            t += noise( sin( TAU * i/this.n ) ) / d;
        }
    }
}

class DecreasedHole {
    final color[] cs = {
        color( 226,  69,  31 ),
        color( 231, 117,  52 ),
        color( 244, 164,  88 ),
    };
    final float cw, ch;  // center width, height
    float d;  // diameter

    DecreasedHole( float cw, float ch, float d ){
        this.cw = cw;
        this.ch = ch;
        this.d = d;
    }
    
    private int selectStrokeColorAsIndex() {
        strokeWeight( 1 );
        noFill();
        return int( random( cs.length ) );
    }
    
    public void draw() {
        final int ci = this.selectStrokeColorAsIndex();
        for( float a = 100; a > 0; a -= random( 0.5 ) ){
            stroke( this.cs[ ci ], a );
            circle( this.cw, this.ch, this.d );
            this.d += 0.5;
        }
    }
}

void glitch( float w, float h ) {
    color c = get( int( w ), int( h ) );
    strokeCap( SQUARE );
    stroke( c, max( 128 * noise( w/width, h/height ), 100 ) );
    pushMatrix();
    translate( w, h );
    rotate( PI * noise( w/width, h/height ) );
    line( 0, 0, 200 * noise( w/width, h/height ), 0 );
    popMatrix();
}

void keyPressed() {
    if ( key == 's' ) {
        saveFrame( "cc000.png" );
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
