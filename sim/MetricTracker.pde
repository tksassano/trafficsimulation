class MetricTracker {
  int yPosition;
  int vehiclesPassed;
  float totalTime;
  float totalDistance;
  float totalSpeed;

  MetricTracker(int yPosition) {
    this.yPosition = yPosition;
    vehiclesPassed = 0;
    totalTime = 0;
    totalDistance = 0;
    totalSpeed = 0;
  }

  void update(Car car, float deltaTime) {
    if (frameCount % (fps * 5) == 0){
      vehiclesPassed = 0;
      totalTime = 0;
      totalDistance = 0;
      totalSpeed = 0;
    }
    if (int(car.position.y) - int(yPosition) < car.speed) {
      vehiclesPassed++;
      totalTime += deltaTime;
      totalDistance += car.position.dist(car.prevPosition);
      totalSpeed += car.speed;
    }
  }

  float getThroughput() {
    return vehiclesPassed / totalTime;
  }

  float getAverageSpeed() {
    return totalSpeed / vehiclesPassed;
  }

  float getDensity() {
    return vehiclesPassed / totalDistance;
  }

  void display(int x) {
    textSize(15);
    fill(0);
    textAlign(LEFT);
    text("T: " + roundToNearestDecimal(getThroughput(), 1), x, yPosition + 10);
    text("S: " + roundToNearestDecimal(getAverageSpeed(), 1), x, yPosition + 30);
    text("D: " + roundToNearestDecimal(getDensity(), 1), x, yPosition + 50);
  }
}
