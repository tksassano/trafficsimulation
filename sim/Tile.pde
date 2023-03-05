class Tile{
  int x;
  int y;
  int type;
  PImage tileArt;
  
  Tile (int tx, int ty, int ttype){
    x = tx;
    y = ty;
    type = ttype;
  }
  void display(){
    tileArt = loadImage(type+".png");
    tileArt.loadPixels();
    image(tileArt, x, y);
  }
}
