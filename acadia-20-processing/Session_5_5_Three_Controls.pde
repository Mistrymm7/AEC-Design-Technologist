import processing.pdf.*;
import controlP5.*;


Cell[] myCells = new Cell[2000];

int seed_counter = 0;
boolean run = false;
boolean showcells = false;
float influence_distance = 10;

ControlP5 cp5;

void setup() {
  size(500, 500);
  cp5 = new ControlP5(this);
  for (int i = 0; i < myCells.length; i++) {
    myCells[i] = new Cell(5);
  }

  myCells[0].isseed = true;

  beginRecord(PDF, "mydrawing.pdf");

  cp5.addToggle("run")
    .setPosition(10, 10)
    .setSize(75, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    ;

  cp5.addToggle("showcells")
    .setPosition(10, 60)
    .setSize(75, 20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    ;
    
  cp5.addSlider("influence_distance")
    .setPosition(10, 100)
    .setRange(0, 20)
    ;
}


void draw() {
  if (run == true) {
    //background(255);
    for (int i = 0; i < myCells.length; i++) {
      //Visiting every slot in our array.
      if (myCells[i].isseed == false) {
        // if this cell is not a see do the following
        for (int j = 0; j < myCells.length; j++) {
          //run through the array agai
          if (myCells[j].isseed == true) {
            //if the cell is a seed/
            float d;
            d = PVector.dist(myCells[i].location, myCells[j].location);
            //evaluate my position in relation to the seed.
            if (d < influence_distance) {
              //if the distance is below a threshold value make me a seed.
              myCells[i].isseed = true;
              seed_counter = seed_counter + 1;
              stroke(seed_counter/4, 255, seed_counter/4);
              line(myCells[i].location.x, myCells[i].location.y, myCells[j].location.x, myCells[j].location.y);
              break;
            }
          }
        }
      }

      if (showcells == true) {
        myCells[i].display();
      }
      myCells[i].update();
    }
    println(seed_counter);
  }
}

void keyPressed() {
  if (key == 'e') {
    endRecord();
  }
}
