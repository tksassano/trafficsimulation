class Lane {
  ArrayList<Car> carArray;
  int x, carIndex;
  Road parent;
  Lane left, right;
  float speedLimit;

  Lane(Road parent, int x, Lane left, Lane right, float speedLimit) {
    carArray = new ArrayList<>();
    this.x = x;
    this.left = left;
    this.right = right;
    this.parent = parent;
    this.speedLimit = speedLimit;
  }

  void createCar() {
    Car car = new Car(this, x, height, 10, 15, speedLimit/2, speedLimit, 30, 270);
    addCar(car);
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
      car.think();
      car.move();
      Lane laneToSwitch = car.getLaneToSwitch();
      if (laneToSwitch != null) {
        carsToSwitchLanes.add(car);
      }
    }

    for (Car car : carsToSwitchLanes) {
      if (car.canSwitchLane(car.getLaneToSwitch())) {
        car.switchLane(car.getLaneToSwitch());
      }
    }
  }
}
