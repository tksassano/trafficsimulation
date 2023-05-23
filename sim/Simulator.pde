class Simulator {
  ArrayList<Road> roads;
  float prevMillis;
  Simulator(int laneCount, int vph, float timelapse, int speedLimit) {
    prevMillis = millis();
    roads = new ArrayList<>();
    roads.add(new Road(200,laneCount,vph,timelapse,speedLimit));
    
  }

  void addRoad(Road road) {
    roads.add(road);
  }

  void run() {
    float deltaTime = (millis() - prevMillis) / 1000.0;
    prevMillis = millis();
    
    for(Road road: roads){
     road.run(); 
    }
    ArrayList<Car> cNear = CarsNearMouse(dispRadius/2.0);

    for (Car car: cNear) {
      car.displayInfo();
    }
  }
}
