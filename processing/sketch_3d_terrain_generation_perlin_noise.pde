int cols, rows;
int scl=20;
int w=1200;
int h=1200;

float fly=0;

float[][] landscape;

void setup(){
 size(600,600,P3D);

 cols = w/scl;
 rows = h/scl;
 landscape = new float[cols][rows];
 
}

void draw(){
  
  fly -= 0.1;
  
  float yoff = fly;
 for (int y=0; y< rows;y++){
   float xoff = 0; 
   for (int x=0; x< cols; x++){
      landscape[x][y] = map(noise(xoff,yoff),0,1,-100,100);
      xoff += 0.2;
    }
    yoff += 0.2 ;
 }
  
  
  
 background(0);
 stroke(255);
 noFill();
 
 translate(width/2,height/2);
 rotateX(PI/3);
 translate(-width/1.5,-height/2);
 frameRate(1);
 for (int y=0; y< rows-1;y++){
   beginShape(TRIANGLE_STRIP);
   for (int x=0; x< cols; x++){
   vertex(x*scl,y*scl, landscape[x][y]);
   vertex(x*scl,(y+1)*scl,landscape[x][y+1]);
     
     //rect(x*scl,y*scl, scl,scl);
     
   }
   
   endShape();
 }
  
  
}
