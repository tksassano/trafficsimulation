/* Testing Code:
Car car;

void setup(){
  size(800, 800);
  background(0);
  car = new Car(400, 400, 800, 800, 1, 90, 5);
}

void draw(){
  background(0);
  car.display();
  car.update();
  car.printInfo();
}

void keyPressed(){
  if (key == 't'){
    car.turn(90);
  }
  
  if (key == 'a'){
    car.updateAcc(0.01);
  }
  
  if (key == 'a'){
    car.updateAcc(0.01);
  }
  
  if (key == 's'){
    car.updateAcc(0);
  }
  
  if (key == 'd'){
    car.updateAcc(-0.01);
  }
}
*/

class Car {
  PVector pos;
  PVector dpos;
  PVector vel;
  float acc;
  float maxSpeed;
  float ang;
  float spe;
  Car(int x, int y, int dx, int dy, float speed, float angle, float speedLimit){
    pos = new PVector(x, y);
    dpos = new PVector(dx, dy);
    vel = PVector.fromAngle(radians(angle)).mult(speed);
    spe = speed;
    ang = radians(angle);
    acc =  0;
    maxSpeed = speedLimit;
  }
  
  void update(){
    spe = max(0, spe + acc);
    spe = min(maxSpeed, spe);
    vel = PVector.fromAngle(ang).mult(spe);
    pos.add(vel);
  }
  
  void updateAcc(float amt){
    acc = amt;
  }
  
  void turn(float amt){
    ang += radians(amt);
    vel = PVector.fromAngle(ang).mult(spe);
  }
  
  void display(){
    fill(255);
    rect(pos.x, pos.y, 50, 50);
  }
  
  void printInfo(){
    println("-------");
    println("position: " + pos.x + ", " + pos.y);
    println("speed: " + spe);
    println("angle: " + round(degrees(ang)));
    println("acceleration: " + acc);
  }
}
