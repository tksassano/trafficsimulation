class Lane {
  ArrayList<Car> carArray;
  int carIndex;
  Road parent;
  Lane left, right;
  float speedLimit;
  float dir;
  float laneLength;
  PVector laneStart;

  Lane(Road parent, Lane left, Lane right, float speedLimit, float dir, float laneLength, PVector laneStart) {
    carArray = new ArrayList<>();
    this.left = left;
    this.right = right;
    this.parent = parent;
    this.speedLimit = speedLimit;
    this.dir = dir;
    this.laneLength = laneLength;
    this.laneStart = laneStart;
  }

  void createCar() {
    float rand = random(0, 1);
    Car car;
    if (rand<=0.25) {
      car = new Car(this, int(laneStart.x), int(laneStart.y), "truck", dir);
      addCar(car);
    } else if (rand<=1) {
      car = new Car(this, int(laneStart.x), int(laneStart.y), "car", dir);
      addCar(car);
    }

    carIndex++;
  }

  void display() {
    fill(255);
    stroke(0);
    rect(laneStart.x - 17.5, 0, 50, height);
    for (Car car : carArray) {
      car.display();
    }
  }

  void addCar(Car car) {
    carArray.add(car);
  }

  void removeCar(Car car) {
    carArray.remove(car);
  }

  void behavior() {
    ArrayList<Car> carsToSwitchLanes = new ArrayList<>();

    for (Car car : carArray) {
      car.driver.think();
      car.move();
      Lane laneToSwitch = car.driver.laneToSwitch;
      if (laneToSwitch != null) {
        carsToSwitchLanes.add(car);
      }
    }

    for (Car car : carsToSwitchLanes) {
      if (car.driver.canSwitchLane(car.driver.laneToSwitch)) {
        car.switchLane(car.driver.laneToSwitch);
      }
    }
  }
}
