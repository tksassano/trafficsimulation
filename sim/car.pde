class Car {
  int w;
  int h;
  PVector position;
  PVector velocity;
  float speed;
  float maxSpeed;
  float angle;

  float mass;

  PVector acceleration;

  Car(int x, int y, int w_, int h_, float mph, float maxmph, float angle_, float mass_) {
    w = w_;
    h = h_;
    position = new PVector(x, y);
    speed = mphToPpf(mph);
    maxSpeed = mphToPpf(maxmph);
    velocity = PVector.fromAngle(radians(angle_)).mult(speed);
    angle = angle_;
    mass = mass_;
    acceleration = new PVector(0, 0); 
  }

  void update() {
    velocity.add(acceleration);
    speed = velocity.mag();
    if (speed > maxSpeed) {
      velocity.normalize();
      velocity.mult(maxSpeed);
      speed = maxSpeed;
    }
    acceleration.mult(0);
    position.add(velocity);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void turn(float deg) {
    angle += deg;
    velocity = PVector.fromAngle(radians(angle)).mult(speed);
  }

  void display() {
    rect(position.x, position.y, feetToPixels(10), feetToPixels(15));
  }

  void printInfo() {
    println(position.x + "," + position.y + "," + round(angle % 360) + "," + ppfToMph(speed));
  }
}
