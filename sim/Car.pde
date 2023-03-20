/*Testing Code
Car car;

void setup() {
  size(800, 800);
  background(0);
  imageMode(CENTER);
  car = new Car(width/2, height - 100, 30, 20, 0, 1.5, 0.01; 0.01, 270);
}

void draw() {
  background(0);
  car.display();
  car.update();
  car.printInfo();
}

void keyPressed() {
  if (key == 'a') {
    car.updateAcceleration(0.01);
  }

  if (key == 's') {
    car.updateAcceleration(0);
  }

  if (key == 'd') {
    car.updateAcceleration(-0.01);
  }
  
  if (keyCode == RIGHT){
    car.turn(3);
  }
  if (keyCode == LEFT){
    car.turn(-3);
  }
}*/

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

  Car(int x, int y, int w_, int h_, float speed_, float maxSpeed_, float acceleration_, float maxAcceleration_, float angle_) {
    car = loadImage("test1.png");
    w = w_;
    h = h_;
    position = new PVector(x, y);
    velocity = PVector.fromAngle(radians(angle_)).mult(speed);
    angle = angle_;
    acceleration = acceleration_;
    maxAcceleration = maxAcceleration_;
    speed = speed_;
    maxSpeed = maxSpeed_;
  }

  void update() {
    speed = max(0, speed + acceleration);
    speed = min(maxSpeed, speed);
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
    image(car, 0, 0, 40, 70);
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
