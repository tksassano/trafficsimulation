class Car {
  int w, h;
  PVector position, velocity;
  float speed, maxSpeed, angle, acceleration, maxAcceleration, accelerationTracker;
  color c;

  Car(int x, int y, int w_, int h_, float mph, float maxmph, float maxAcceleration_, float angle_) {
    w = feetToPixels(w_);
    h = feetToPixels(h_);
    position = new PVector(x, y);
    speed = mphToPpf(mph);
    maxSpeed = mphToPpf(maxmph);
    velocity = PVector.fromAngle(radians(angle_)).mult(speed);
    angle = angle_;
    acceleration = 0; 
    maxAcceleration = mphPerSecToPpfPerFrame(maxAcceleration_);
    c = color(random(255), random(255), random(255));
  }

  void move() {
    if (mouseHeld && position.dist(new PVector(mouseX,mouseY)) < dispRadius) {
      acceleration = -maxAcceleration;
    }
    speed = constrain(speed + acceleration, 0, maxSpeed); 
    velocity = PVector.fromAngle(radians(angle)).mult(speed);
    position.add(velocity);
    accelerationTracker = acceleration;
    acceleration = 0; 
  }

  void applyForce(float force) { 
    acceleration = force;
  }

  void turn(float deg) {
    angle += deg;
  }

  void display() {
    fill(c);
    rect(position.x, position.y, w, h);
  }
  
  void displayInfo() {
    textSize(25);
    fill(0);
    text("S: " + roundToNearestDecimal(ppfToMph(speed), 1) + " / " + roundToNearestDecimal(ppfToMph(maxSpeed),1), position.x + 20, position.y + 10);
    text("A: " + roundToNearestDecimal(ppfPerFrameToMphPerSec(accelerationTracker), 1) + " / " + roundToNearestDecimal(ppfPerFrameToMphPerSec(maxAcceleration), 1), position.x + 20, position.y + 30);
 
  }

  void printInfo() {
  //  println(position.x + "," + position.y + "," + round(angle % 360) + "," + ppfToMph(speed) + "," + ppfPerFrameToMphPerSec(accelerationTracker));
  }
}
