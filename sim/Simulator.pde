class Simulator {
  ArrayList<Lane> lanes;
  
  Simulator(int laneCount, int vph, float timelapse, int speedLimit) {
    lanes = new ArrayList<>();
    for (int i = 0; i < laneCount; i++){
      addLane(new Lane(i, vph * (i+1), timelapse, speedLimit));
    }
  }
  
  void addLane(Lane lane) {
    lanes.add(lane);
  }
  
  void run() {
    for (int i = 0; i < lanes.size(); i++) {
      lanes.get(i).inflow();
      lanes.get(i).behavior();
      lanes.get(i).move();
      
      lanes.get(i).display();
     // lanes.get(i).printInfo(0);
    }
    ArrayList<Car> cNear = CarsNearMouse(dispRadius/2.0);

    for(int u = 0; u < cNear.size(); u++){
        cNear.get(u).displayInfo();

      }
  }
}
