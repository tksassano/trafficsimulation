class Car {
  int w;
  int h;
  PVector position;
  PVector velocity;
  float speed;
  float maxSpeed;
  float angle;
  float acceleration; 
  float maxAcceleration;
  float accelerationTracker;

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
  }

  void move() {
    speed += acceleration; 
    checks();
    velocity = PVector.fromAngle(radians(angle)).mult(speed);
    position.add(velocity);
    accelerationTracker = acceleration;
    acceleration = 0; 
  }

  void applyForce(float force) { 
    acceleration += force;
  }

  void turn(float deg) {
    angle += deg;
  }
  
  void checks(){
    if (speed > maxSpeed) {
      speed = maxSpeed;
    }
    if (speed < 0) {
      speed = 0;
    }
  }

  void display() {
    rect(position.x, position.y, w, h);
    textSize(25);
    text("S: " + roundToNearestDecimal(ppfToMph(speed), 1) + " / " + roundToNearestDecimal(ppfToMph(maxSpeed),1), position.x + 20, position.y + 10);
    text("A: " + roundToNearestDecimal(ppfPerFrameToMphPerSec(accelerationTracker), 1) + " / " + roundToNearestDecimal(ppfPerFrameToMphPerSec(maxAcceleration), 1), position.x + 20, position.y + 30);
  }

  void printInfo() {
    println(position.x + "," + position.y + "," + round(angle % 360) + "," + ppfToMph(speed) + "," + ppfPerFrameToMphPerSec(accelerationTracker));
  }
}
