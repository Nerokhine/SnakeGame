public class Segment{
  int xPos;
  int yPos;
  int dir;
  
  public Segment(int xPos, int yPos, int dir){
    this.xPos = xPos;
    this.yPos = yPos;
    this.dir = dir;
  }
  
  public int getxPos() {
    return xPos;
  }

  public void setxPos(int xPos) {
    this.xPos = xPos;
  }

  public int getyPos() {
    return yPos;
  }

  public void setyPos(int yPos) {
    this.yPos = yPos;
  }

  public int getDir() {
    return dir;
  }

  public void setDir(int dir) {
    this.dir = dir;
  }
  
}
