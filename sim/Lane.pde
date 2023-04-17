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
    inflow = round(1/(float(vph) * (1. / 60) * (1. / 60) * (1. / fps) * timelapse_));
    timelapse = timelapse_;
    speedLimit = speedLimit_;
    x = width / 2 + (index - 2) * 100;
  }

  void inflow() {
    if (frameCount % inflow == 0) {
      createCar();
    }
  }

  void createCar() {
    carArray.add(carIndex, new Car(x, height, 10, 15, random(speedLimit * 0.5, speedLimit), speedLimit, 30, 270));
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

        if (distance < safeDistance && currentCar.speed > frontCar.speed) {

          float dist_car_desire = 30;
          float dist_car = distance;
          float P = 0.1;

          float distance_control = min(-P*(dist_car_desire - dist_car), currentCar.maxAcceleration);
          currentCar.applyForce(distance_control);
          
        } else if (distance > safeDistance) {
          float force = currentCar.maxAcceleration;

          if (currentCar.speed > frontCar.speed + frontCar.maxAcceleration * 5) {
            println(currentCar.speed);
            println(frontCar.speed + frontCar.maxAcceleration);
            force *= -1;
          }
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
    return frontCar.w * 1.5 + ppfToMph(frontCar.speed);
  }

  void printInfo(int observing) {
    if (carIndex > observing) {
      carArray.get(observing).printInfo();
    }
  }
}
