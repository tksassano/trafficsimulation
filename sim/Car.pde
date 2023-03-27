class Car {
  int w;
  int h;
  PVector position;
  PVector velocity;
  float speed;
  float maxSpeed;
  float acceleration;
  float maxAcceleration;
  float angle;
  PImage car;

  Car(int x, int y, int w_, int h_, float mph, float maxmph, float acceleration_, float maxAcceleration_, float angle_) {
    car = loadImage("test1.png");
    w = w_;
    h = h_;
    position = new PVector(x, y);
    speed = (mph * 800) / (60 * fps);
    maxSpeed = (maxmph * 1600) / (60 * fps);
    println(speed);
    velocity = PVector.fromAngle(radians(angle_)).mult(speed);
    angle = angle_;
    acceleration = acceleration_;
    maxAcceleration = maxAcceleration_;
  }

  void update() {
    speed = max(0, speed + acceleration);
    if (speed >= maxSpeed){
      acceleration = 0;
      speed = maxSpeed;
    }
    velocity = PVector.fromAngle(radians(angle)).mult(speed);
    position.add(velocity);
  }

  void updateAcceleration(float amt) {
    if (abs(amt) > maxAcceleration) {
      if (amt > 0) {
        acceleration = maxAcceleration;
      } else {
        acceleration = -maxAcceleration;
      }
    } else {
      acceleration = amt;
    }
  }

  void turn(float deg) {
    angle += deg;
    velocity = PVector.fromAngle(radians(angle)).mult(speed);
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(radians(angle+90));
    fill(255);
    image(car, 0, 0, 20, 35);
    popMatrix();
  }

  void printInfo() {
    println("-------");
    println("position: " + position.x + ", " + position.y);
    println("speed: " + speed);
    println("angle: " + round(angle % 360));
    println("acceleration: " + acceleration);
  }
}
