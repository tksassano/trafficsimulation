class Simulator {
  Car[] carArray;
  int carIndex;
  int inflow;
  float timelapse;
  float speedLimit;

  Simulator(int vph, float timelapse_, int speedLimit_) {
    carArray = new Car[1000];
    carIndex = 0;
    inflow = round(1/(float(vph) * (1. / 60) * (1. / 60) * (1. / fps) * timelapse_));
    timelapse = timelapse_;
    speedLimit = speedLimit_;
  }

  void inflow() {
    if (frameCount % inflow == 0) {
      createCar();
    }
  }

  void createCar() {
    int randomSpeed = int(random(30, 45));
    carArray[carIndex] = new Car(width/2, height, 40, 70, randomSpeed, randomSpeed * 1.25, 10, 270);
    carIndex ++;
  }

  void display() {
    for (int i = 0; i < carIndex; i++) {
      carArray[i].display();
    }
  }

  void move() {
    for (int i = 0; i < carIndex; i++) {
      carArray[i].move();
    }
  }

  void behavior() {
    for (int i = 0; i < carIndex; i++) {
      Car currentCar = carArray[i];
      if (i > 0) {
        Car frontCar = carArray[i-1];
        float distance = currentCar.position.dist(frontCar.position);
        float safeDistance = calculateSafeDistance(currentCar, frontCar);
        if (distance < safeDistance) {
          float force = map(distance, 0, safeDistance, -currentCar.maxAcceleration, currentCar.maxAcceleration);
          if (force > 0 && currentCar.speed >= currentCar.maxSpeed) {
            force = 0;
          }
          currentCar.applyForce(force);
        } else if (currentCar.speed < speedLimit && currentCar.speed < currentCar.maxSpeed) {
          float force = currentCar.maxAcceleration;
          currentCar.applyForce(force);
        } else if (currentCar.speed > speedLimit) {
          float force = -currentCar.maxAcceleration;
          currentCar.applyForce(force);
        }
      } else if (currentCar.speed < currentCar.maxSpeed) {
        currentCar.applyForce(currentCar.maxAcceleration);
      }
    }
  }

  float calculateSafeDistance(Car currentCar, Car frontCar) {
    return 300.;
  }

  void printInfo(int observing) {
    if (carIndex > observing) {
      carArray[observing].printInfo();
    }
  }
}
