class Simulator {
  ArrayList<Car> carArray;
  int carIndex;
  int inflow;
  float timelapse;
  float speedLimit;

  Simulator(int vph, float timelapse_, int speedLimit_) {
    carArray = new ArrayList<>();
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
    int randomSpeed = int(random(45, 60));
    carArray.add(carIndex, new Car(width/2, height, 10, 15, randomSpeed, randomSpeed * 1.5, 10, 270));
    carIndex ++;
  }

  void display() {
    for (int i = 0; i < carIndex; i++) {
      carArray.get(i).display();
    }
  }

  void move() {
    for (int i = 0; i < carIndex; i++) {
      carArray.get(i).move();
    }
  }

  void behavior() {
    for (int i = 0; i < carIndex; i++) {
      Car currentCar = carArray.get(i);
      if (i > 0) {
        Car frontCar = carArray.get(i-1);
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
    return 200.;
  }

  void printInfo(int observing) {
    if (carIndex > observing) {
      carArray.get(observing).printInfo();
    }
  }
}
