class MetricTracker {
  int totalCars;
  float totalSpeed;
  int interval;
  int intervalCount;
  int densityInterval;
  int segmentLength;
  ArrayList<Car> carsInSegment;

  MetricTracker(int interval, int densityInterval, int segmentLength) {
    this.interval = interval;
    this.densityInterval = densityInterval;
    this.segmentLength = segmentLength;
    this.carsInSegment = new ArrayList<>();
    reset();
  }

  void reset() {
    totalCars = 0;
    totalSpeed = 0;
    intervalCount = 0;
    carsInSegment.clear();
  }

  void addCar(Car car) {
    totalCars++;
    totalSpeed += car.speed;
    if (car.position.y <= segmentLength) {
      carsInSegment.add(car);
    }
  }

  void removeCar(Car car) {
    carsInSegment.remove(car);
  }

  float getThroughput() {
    return (float) totalCars / interval;
  }

  float getAverageSpeed() {
    if (totalCars == 0) return 0;
    return totalSpeed / totalCars;
  }

  float getDensity() {
    return (float) carsInSegment.size() / segmentLength;
  }

  void update() {
    intervalCount++;
    if (intervalCount >= interval) {
      println("Throughput: " + getThroughput());
      println("Average speed: " + getAverageSpeed());
      reset();
    }
    if (intervalCount % densityInterval == 0) {
      println("Density: " + getDensity());
      carsInSegment.clear();
    }
  }
}
