class Road {
  ArrayList<Lane>lanes = new ArrayList<Lane>();
  ArrayList<RoadObj> objs = new ArrayList<>();

  int inflow;
  int x;
  int carIndex;
  float timelapse;
  float speedLimit;

  Road(int x, int numLanes, int vph, float timelapse) {
    carIndex = 0;
    this.x = x;
    this.timelapse = timelapse;
    this.speedLimit = mphToPpf(speedLimit);
    Lane lastLane = null;
    for (int i = 0; i < numLanes; i++) {
      Lane newLane = new Lane(this, x+50*i, lastLane, null, 30 + 5 * i, vph / (i+2));
      if (lastLane != null) lastLane.right = newLane;
      addLane(newLane);
      lastLane = newLane;
    }
  }

  void addLane(Lane lane) {
    lanes.add(lane);
  }

  void run() {
    for (Lane lane : lanes) {
      lane.display();
      lane.inflow();
      lane.behavior();
    }

    for (RoadObj obj : objs) {
      obj.update();
      obj.display();
    }
  }
}
