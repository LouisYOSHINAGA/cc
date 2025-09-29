/* cc000 */

void setup() {
    size( 1150, 800 );
    noLoop();
}

void draw() {
    background( 240 );
    for( int i = 0; i < 24; i++ ) {
          new OverlappedCircle( int( random( 120, 160 ) ) ).draw();
    }
}

private class OverlappedCircle {        
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
    private final int n;  // number of iteration
    private final float d;  // adjustment element
    private int cw, ch;  // center width, height
    private float ew, eh;  // ellipse width, height
    private float t;  // rotation angle
    
    OverlappedCircle( int n ) {
        this.n = n;
        this.d = random( 128, 1024 );
        this.cw = int( random( width ) );
        this.ch = int( random( height ) );
        this.ew = random( 64, 1024 );
        this.eh = random( 64, 1024 );
        this.t = random( TAU );
    }
    
    private void selectStrokeColor() {
        strokeWeight( random( 0.8, 3.2 ) );
        stroke( cs[ int( random( cs.length ) ) ], random( 64, 128 ));
        noFill();
    }
    
    public void draw() {
        noiseSeed( int( random(1024) ) );
        selectStrokeColor();

        for( int i = 0; i < this.n; i++ ) {
            pushMatrix();
            translate( cw, ch );
            rotate( t );
            ellipse( 0, 0, ew, eh );
            popMatrix();

            cw += random( -1, 1 ) / d;
            ch += random( -1 ,1 ) / d;
            ew += random( -1, 1 ) / d;
            eh += random( -1, 1 ) / d;
            t += noise( sin( TAU * i/this.n ) ) / d;
        }
    }
}

void keyPressed() {
    if ( key == 's' ) {
        saveFrame( "cc000.png" );
        exit();
    } else if ( key == 'r' ) {
        redraw();
    }
}
