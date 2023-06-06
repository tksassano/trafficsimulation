class Simulator {
  ArrayList<Road> roads = new ArrayList<>();
  float prevMillis;

  Simulator(int laneCount, int vph, float timelapse) {
    prevMillis = millis();
    Road nRoad = new Road(200, laneCount, vph, timelapse);
    roads.add(nRoad);
    nRoad.objs.add(new StopSign(nRoad, height/2));
    nRoad.objs.add(new TrafficLight(nRoad, 2*height/3,720,360));

  }

  void addRoad(Road road) {
    roads.add(road);
  }

  void run() {
    prevMillis = millis();

    for (Road road : roads) {
      road.run();
    }
    
    
    ArrayList<Car> cNear = CarsNearMouse(dispRadius/2.0);

    for (Car car : cNear) {
      car.displayInfo();
    }
  }
}
