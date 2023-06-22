class MetricTracker {
  int Throughput;
  int AverageSpeed;
  int Density;
  int numCars;
  PVector position;
  Lane lane;
  int dStart;
  int dEnd;
  int tTime;
  int tStart;
  int tEnd;
  int tick;
  MetricTracker(Lane lane, int x, int y) {
    this.position = new PVector(x, y);
    this.lane = lane;
    this.dStart = 450;
    this.dEnd = 200;
    this.tTime = 900;
    this.tStart = 600;
    this.tEnd = 599;
    tick = 0;
  }
  float Density(int start, int end) {
    numCars = 0;
    for (Car car : lane.carArray) {
      if (car.position.y <= start && car.position.y >= end) {
        numCars ++;
      }
    }
    return numCars*250/(start-end);
  }
  float Throughput(int time, int start, int end) {
    int through = Throughput;
    tick--;

    if (tick <= 0) {

      tick = time;

      through = Throughput/time;
      Throughput = 0;
      return through;
    } else {
      for (Car car : lane.carArray) {
        if (car.position.y <= start && car.position.y >= end) {
          Throughput ++;
        }
      }
    }
    return through;
  }
  float avgSpeed() {
    int numCar = 0;
    int speed = 0;
    for (Car car : lane.carArray) {
      if (car.position.y <= 900) {
        speed += car.velocity.mag();
        numCar ++;
      }
    }
    if (numCar != 0) {
      return speed/numCar;
    } else {
      return speed;
    }
  }
  void display() {
    textSize(20);
    fill(0);
    text("Density: " + Density(dStart, dEnd), position.x, position.y);
    text("Throughput: " + Throughput(tTime, tStart, tEnd), position.x, position.y + 30);
    text("Average Speed: " + ppfToMph(avgSpeed()), position.x, position.y + 60);
  }
}
