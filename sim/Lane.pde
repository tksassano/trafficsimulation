class Lane {
  ArrayList<Car> carArray;
  int carIndex;
  int inflow;
  float timelapse;
  float speedLimit;
  int x;
  MetricTracker[] metricTrackers;

  Lane(int index, int vph, float timelapse_, int speedLimit_) {
    carArray = new ArrayList<>();
    carIndex = 0;
    inflow = round(1. / (float(vph) * (1. / 60) * (1. / 60) * (1. / fps) * timelapse_));
    timelapse = timelapse_;
    speedLimit = mphToPpf(speedLimit_);
    x = width / 2 + (index - 2) * 100;
    metricTrackers = new MetricTracker[3];
    for (int i = 0; i < 3; i++) {
      metricTrackers[i] = new MetricTracker(height / 4 * (i + 1));
    }
  }

  void inflow() {
    if (frameCount % inflow == 0) {
      createCar();
    }
  }

  void createCar() {
    carArray.add(carIndex, new Car(x, height, 10, 15, ppfToMph(speedLimit/2), ppfToMph(speedLimit), 30, 270));
    carIndex ++;
  }

  void display() {
    fill(255);
    rect(x - 17.5, 0, 50, height);
    for (int i = 0; i < carIndex; i++) {
      carArray.get(i).display();
    }
    for (MetricTracker metricTracker : metricTrackers) {
      metricTracker.display(x+35);
    }
  }

  void move(float deltaTime) {
    for (int i = 0; i < carIndex; i++) {
      Car car = carArray.get(i);
      car.move();
      for (MetricTracker metricTracker : metricTrackers) {
        metricTracker.update(car, deltaTime);
      }
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
          float P_d = 0.01;
          float A_d = min(-P_d * (safeDistance - distance), currentCar.maxAcceleration);
          float speed_limit = speedLimit;
          float P_v = 0.01;
          float A_v = -P_v * (speed_limit - currentCar.speed);
          float A = min(A_d, A_v, currentCar.maxAcceleration);
          currentCar.applyForce(A);
        } else {
          currentCar.applyForce(currentCar.maxAcceleration);
        }
      } else {
        currentCar.applyForce(currentCar.maxAcceleration);
      }
    }
  }

  float calculateSafeDistance(Car currentCar, Car frontCar) {
    float reactionTime = 1.0;
    float followingDistance = currentCar.speed * reactionTime;
    float bufferDistance = 5.0;

    float carLength = currentCar.h;

    if (currentCar.speed > 0 && frontCar.speed > 0) {
      float decelerationDistance = (currentCar.speed * currentCar.speed) / (2 * currentCar.maxAcceleration) -
        (frontCar.speed * frontCar.speed) / (2 * frontCar.maxAcceleration);
      return followingDistance + decelerationDistance + bufferDistance + carLength;
    } else if (currentCar.speed > 0) {
      float decelerationDistance = (currentCar.speed * currentCar.speed) / (2 * currentCar.maxAcceleration);
      return followingDistance + decelerationDistance + bufferDistance + carLength;
    } else {
      return bufferDistance + carLength;
    }
  }
}
