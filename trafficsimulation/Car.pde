class Car {
  int w, h,cQ;
  PVector position, velocity;
  float speed, maxSpeed, angle, acceleration, maxAcceleration, accelerationTracker;
  color c;
  PVector prevPosition;
  Driver driver;
  Lane lane;
  
  Car(Lane lane, int x, int y, String carType, float angle) {
    switch(carType){
     case "car":
        h=15;
        speed = 2*maxSpeed/3;
        maxSpeed = 75;
        maxAcceleration = 30;
        w = 10;
       break;
      case "truck":
        h=30;
        speed = 2*maxSpeed/3;
        maxSpeed = 50;
        maxAcceleration = 10;
        w = 10;
        break;
    }
    
    w = feetToPixels(w);
    h = feetToPixels(h);
    this.lane = lane;
    position = new PVector(x, y);
    speed = mphToPpf(speed);
    maxSpeed = mphToPpf(maxSpeed);
    velocity = PVector.fromAngle(radians(angle)).mult(speed);
    this.angle = angle;
    acceleration = 0;
    maxAcceleration = mphPerSecToPpfPerFrame(maxAcceleration);
    c = color(random(255), random(255), random(255));
    prevPosition = new PVector(x, y);
    driver = new Driver(this);
  }

  void switchLane(Lane newLane) {
    lane.removeCar(this);
    position.x = newLane.x;
    newLane.addCar(this);
    lane = newLane;
    maxSpeed = mphToPpf(lane.speedLimit);
}

  void move() {
    prevPosition = position.copy();
    if (mouseHeld && position.dist(new PVector(mouseX, mouseY)) < dispRadius/2) {
      acceleration = -maxAcceleration;
    }
    speed = constrain(speed + acceleration, 0, maxSpeed);
    velocity = PVector.fromAngle(radians(angle)).mult(speed);
    position.add(velocity);
    accelerationTracker = acceleration;
    acceleration = 0;
    cQ = 100; //reset priority

  }


  void queueForce(float force, int p) {
    if(p<cQ || (p == cQ && acceleration > force)){
      cQ = p;
      
      acceleration = constrain(force,-maxAcceleration,maxAcceleration);
      /*
      overwrite more dangerous actions of the same priority
      i.e. stopsign like halfway up the road will have higher accel than a car within braking dist
      so you don't want that : O
      */
    }

    return;
  }
  void applyForce(float force,String debug) {
    print("[" + debug + "] cA: " + roundToNearestDecimal(ppfPerFrameToMphPerSec(acceleration),1) + ", nA: ");
    if(abs(force) > abs(acceleration)) {
      acceleration = constrain(force,-maxAcceleration,maxAcceleration);
      switch(debug){
       case "Safe":
         c = color(200,255,200);
         break;
       case "PID":
         c = color(255,255,200);
         break;
       case "Stop":
         c = color(255,200,200);
         break;
       default:
         c = color(255);
         break;
      }
    }
    println(roundToNearestDecimal(ppfPerFrameToMphPerSec(acceleration),1));
  
  }
  void turn(float deg) {
    angle += deg;
  }



  void display() {
    fill(c);
    rect(position.x, position.y, w, h);
    
  //  line(0,frontCar.position.y+dist,width,frontCar.position.y+dist);

  }

  void displayInfo() {
    textSize(25);
    fill(0);
    text("S: " + roundToNearestDecimal(ppfToMph(speed), 1) + " / " + roundToNearestDecimal(ppfToMph(maxSpeed), 1), position.x + 20, position.y + 10);
    text("A: " + roundToNearestDecimal(ppfPerFrameToMphPerSec(accelerationTracker), 1) + " / " + roundToNearestDecimal(ppfPerFrameToMphPerSec(maxAcceleration), 1), position.x + 20, position.y + 30);
  }
}
