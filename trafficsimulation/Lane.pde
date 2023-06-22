class Lane {
  ArrayList<Car> carArray;
  int x, carIndex;
  Road parent;
  Lane left, right;
  float speedLimit;
  float inflow;

  Lane(Road parent, int x, Lane left, Lane right, float speedLimit, int vph) {
    inflow = round(1. / (float(vph) * (1. / 60) * (1. / 60) * (1. / fps) * timelapse));
    carArray = new ArrayList<>();
    this.x = x;
    this.left = left;
    this.right = right;
    this.parent = parent;
    this.speedLimit = speedLimit;
  }

  void inflow() {
    if (frameCount % inflow == 0) {
      createCar();
    }
  
}
  void createCar() {
    float rand = random(0, 1);
    Car car;
    if (rand<=0.25) {
      car = new Car(this, x, height, "truck", 270);
      addCar(car);
    } else if (rand<=1) {
      car = new Car(this, x, height, "car", 270);
      addCar(car);
    }

    carIndex++;
  }

  void display() {
    fill(255);
    stroke(0);
    rect(x - 17.5, 0, 50, height);
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
