float dia = 5;
float spd = 3;
float spread = 6;
int spokes = 6;
Flake cur;
ArrayList<Flake> flakes;

void setup() {
  size(500, 500);
  flakes = new ArrayList<Flake> ();
  createAddFlake();
}
void draw() {
  translate(width/2, height/2);
  background(0);
  while (!cur.stopped() && !cur.collided()) {
    cur.move();
  }
  showFlakes();
  createAddFlake();
}
void keyPressed() {
  flakes.clear();
  loop();
}
void showFlakes() {
  for (int i=0; i < spokes; i++) {
    rotate(2*PI/spokes);
    for (Flake f : flakes) {
      f.show();
    }
  }
}
void createAddFlake() {
  if (Math.random()>=0.1) {
    cur = new Flake(width/2-dia, 0);
    flakes.add(cur);
  } else {
    cur = new CFlake();
    cur.d *= 1;
    flakes.add(cur);
  }
  if (cur.collided()) {
    saveFrame("images/flake####.tif");
    flakes.clear();
  }
}
class Flake {
  float x, y, d;
  Flake(){
    x = width/2 - dia; 
    y = 0; 
    d = dia;
  }

  Flake(float x_, float y_) {
    x = x_;
    y = y_;
    d = dia;
  }

  void show() {
    noFill();
    stroke(255);
    ellipse(x, y, d, d);
  }

  void move() {
    x -= spd;
    y += (int)(Math.random()*(spread+1))-spread/2;
  }

  boolean stopped() {
    boolean res = false;
    if (x <= dia) {
      res = true;
    }
    return res;
  }

  boolean collided() {
    boolean ret = false;
    for (Flake f : flakes) {
      if (this != f) {
        if (dist(f.x, f.y, x, y) <= dia) {
          ret = true;
          continue;
        }
      }
    }
    return ret;
  }
}
class CFlake extends Flake{
  float r, g, b; 
  CFlake(){
    r =(float)(Math.random()*256);
    g =(float)(Math.random()*256);
    b =(float)(Math.random()*256);
  }
  void show() {
    fill (r, b, g);
    stroke(r, b, g);
    ellipse(x, y, d, d);  
    noFill();
  }
}
