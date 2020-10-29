
class Cell {

  PVector location = new PVector();
  PVector velocity = new PVector();
  float dia;
  boolean isseed;
  float cellred, cellgreen, cellblue;
  float lineweight;
  float speed;

  Cell(int diam) {

    location = new PVector(random(500), random(500));
    dia = diam;
    isseed = false;
    cellred = 0;
    cellgreen = 255;
    cellblue = 0;
    lineweight = 0.5;
  }
  void display() {
    stroke(lineweight);
    fill(cellred, cellgreen, cellblue);
    if (isseed == true) {
      fill(255, 0, 0);
    }
    ellipse(location.x, location.y, dia, dia);
  }
  void update() {
    if (isseed == false) {
      velocity = new PVector(random(-1, 1), random(-1, 1)); 
      location.add(velocity);
    }
  }
}
