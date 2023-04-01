class Car {
  int w;
  int h;
  PVector position;
  PVector velocity;
  float speed;
  float maxSpeed;
  float angle;
  float mass;
  float acceleration; 

  Car(int x, int y, int w_, int h_, float mph, float maxmph, float angle_, float mass_) {
    w = w_;
    h = h_;
    position = new PVector(x, y);
    speed = mphToPpf(mph);
    maxSpeed = mphToPpf(maxmph);
    velocity = PVector.fromAngle(radians(angle_)).mult(speed);
    angle = angle_;
    mass = mass_;
    acceleration = 0; 
  }

  void move() {
    speed += acceleration; 
    checks();
    velocity = PVector.fromAngle(radians(angle)).mult(speed);
    position.add(velocity);
    acceleration = 0; 
  }

  void applyForce(float force) { 
    acceleration += force / mass; 
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
    rect(position.x, position.y, feetToPixels(10), feetToPixels(15));
  }

  void printInfo() {
    println(position.x + "," + position.y + "," + round(angle % 360) + "," + ppfToMph(speed) + "," + acceleration);
  }
}
