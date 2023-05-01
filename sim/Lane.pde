class Lane {
  ArrayList<Car> carArray;
  int carIndex;
  int inflow;
  float timelapse;
  float speedLimit;
  int x;

  Lane(int index, int vph, float timelapse_, int speedLimit_) {
    carArray = new ArrayList<>();
    carIndex = 0;
    inflow = round(1./(float(vph) * (1. / 60) * (1. / 60) * (1. / fps) * timelapse_));
    println(inflow);
    timelapse = timelapse_;
    speedLimit = mphToPpf(speedLimit_);
    x = width / 2 + (index - 2) * 100;
  }

  void inflow() {
    if (frameCount % inflow == 0) {
      createCar();
    }
  }

  void createCar() {
    carArray.add(carIndex, new Car(x, height, 10, 15, random(ppfToMph(speedLimit) * 0.5, ppfToMph(speedLimit)), ppfToMph(speedLimit), 30, 270));
    carIndex ++;
  }

  void display() {
    fill(255);
    rect(x - 17.5, 0, 50, height);
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
        if (distance < safeDistance){
          float P_d = 0.01;
          float A_d = min(-P_d * (safeDistance - distance), currentCar.maxAcceleration);
          float speed_limit = speedLimit;
          float P_v = 0.01;
          float A_v = -P_v * (speed_limit - currentCar.speed);
          float A = min(A_d, A_v, currentCar.maxAcceleration);
          currentCar.applyForce(A);
        }
        else {
          currentCar.applyForce(currentCar.maxAcceleration);
        }
      } else  {
        currentCar.applyForce(currentCar.maxAcceleration);
      }
    }
  }

float calculateSafeDistance(Car currentCar, Car frontCar) {
  float reactionTime = 2.0; 
  float currentCarSpeedMph = ppfToMph(currentCar.speed);
  float frontCarSpeedMph = ppfToMph(frontCar.speed);
  float speedDifference = currentCarSpeedMph - frontCarSpeedMph;

  float reactionDistance = currentCarSpeedMph * reactionTime * 5280 / 3600;

  float additionalDistance = max(0, speedDifference * reactionTime * 5280 / 3600);

  float safeDistance = frontCar.w * 1.5 + reactionDistance + additionalDistance;

  return safeDistance;
}


  void printInfo(int observing) {
    if (carIndex > observing) {
      carArray.get(observing).printInfo();
    }
  }
}
