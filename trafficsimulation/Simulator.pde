class Simulator {
  ArrayList<Road> roads = new ArrayList<>();
  float prevMillis;
  MetricTracker metrics;
  Simulator(int laneCount, int vph, float timelapse) {

    prevMillis = millis();
    Road nRoad = new Road(laneCount, vph, timelapse, 270, height, new PVector(200, height));
    roads.add(nRoad);
    nRoad.objs.add(new StopSign(nRoad, height/5));
    nRoad.objs.add(new TrafficLight(nRoad, 2*height/3,720,360,"red",0));
    metrics = new MetricTracker(roads.get(0).lanes.get(0), 400, 50);

  }

  void addRoad(Road road) {
    roads.add(road);
  }

  void run() {
    prevMillis = millis();
    metrics.display();
    for (Road road : roads) {
      road.run();
    }
    
    
    ArrayList<Car> cNear = CarsNearMouse(dispRadius/2.0);

    for (Car car : cNear) {
      car.displayInfo();
    }
  }
}
