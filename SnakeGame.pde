import java.util.ArrayList;
import java.util.Random;
int sizeX = 20;
int sizeY = 20;
int board[][] = new int [sizeX][sizeY]; //0 - nothing, 1 - snake
int boardDir[][] = new int [sizeX][sizeY]; //0 - nothing, 1 - up, 2 - right, 3 - down, 4 - left
ArrayList<Segment> segments = new ArrayList<Segment>();
int foodX = 0;
int foodY = 0;
int score = 0;
boolean pressedKeyUp = false, pressedKeyDown = false, pressedKeyLeft = false, pressedKeyRight = false;
int t = 0;
Random randomGenerator = new Random();
void setup() {
  foodX = randomGenerator.nextInt(sizeX) + 0;
  foodY = randomGenerator.nextInt(sizeY) + 0;
  while(board[foodX][foodY] != 0){
    foodX = randomGenerator.nextInt(sizeX) + 0;
    foodY = randomGenerator.nextInt(sizeY) + 0;
  }
  Segment seg1 = new Segment(15, 15, 1);
  Segment seg2 = new Segment(15, 16, 1);
  Segment seg3 = new Segment(15, 17, 1);
  segments.add(seg1);
  segments.add(seg2);
  segments.add(seg3);
  
  
  size(sizeX * 30, sizeY * 30);
  
  for(int x = 0; x < sizeX; x ++){
    for(int y = 0; y < sizeY; y ++){
      boardDir[x][y] = 0;
      board[x][y] = 0;
    }
  }
  System.out.println("Score: " + score);
}
void draw() {
  background(#000000);
  t += 1;
  
  
  fill(#5792DE);
  for(int x = 0; x < segments.size(); x ++){
    ellipse(segments.get(x).getxPos() * 30 + 10, segments.get(x).getyPos() * 30 + 10, 20, 20);
  }
  if(pressedKeyUp){
      if(segments.get(0).getDir() != 3){
        boardDir[segments.get(0).getxPos()][segments.get(0).getyPos()] =  1;
      }
    } else if(pressedKeyDown){
      if(segments.get(0).getDir() != 1){
        boardDir[segments.get(0).getxPos()][segments.get(0).getyPos()] =  3;
      }
    } else if(pressedKeyLeft){
      if(segments.get(0).getDir() != 2){
        boardDir[segments.get(0).getxPos()][segments.get(0).getyPos()] =  4;
      }
    } else if(pressedKeyRight){
      if(segments.get(0).getDir() != 4){
        boardDir[segments.get(0).getxPos()][segments.get(0).getyPos()] =  2;
      }
  }
    
  if(t == 7){
    
    for(int x = 0; x < segments.size(); x ++){
      if(boardDir[segments.get(x).getxPos()][segments.get(x).getyPos()] != 0){
        segments.get(x).setDir(boardDir[segments.get(x).getxPos()][segments.get(x).getyPos()]);
      }
      if(segments.get(x).getDir() == 1){
        segments.get(x).setyPos(segments.get(x).getyPos() - 1);
        if(segments.get(x).getyPos() == - 1){
          segments.get(x).setyPos(sizeY - 1);
        }
      } else if(segments.get(x).getDir() == 2){
        segments.get(x).setxPos(segments.get(x).getxPos() + 1);
        if(segments.get(x).getxPos() == sizeX){
          segments.get(x).setxPos(0);
        }
      } else if(segments.get(x).getDir() == 3){
        segments.get(x).setyPos(segments.get(x).getyPos() + 1);
        if(segments.get(x).getyPos() == sizeY){
          segments.get(x).setyPos(0);
        }
      } else if(segments.get(x).getDir() == 4){
        segments.get(x).setxPos(segments.get(x).getxPos() - 1);
        if(segments.get(x).getxPos() == -1){
          segments.get(x).setxPos(sizeX - 1);
        }
      }
    }
    
    for(int x = 0; x < sizeX; x ++){
      for(int y = 0; y < sizeY; y ++){
        board[x][y] = 0;
      }
    }
    for(int x = 1; x < segments.size(); x ++){
      board[segments.get(x).getxPos()][segments.get(x).getyPos()] = 1;
    }
    //before updating board for first segment, check for collision
    if(board[segments.get(0).getxPos()][segments.get(0).getyPos()] == 1){
      System.out.println("Game Over");
      System.exit(0);
    }
    // update front segment
    board[segments.get(0).getxPos()][segments.get(0).getyPos()] = 1;
    for(int x = 0; x < sizeX; x ++){
      for(int y = 0; y < sizeY; y ++){
        if(board[x][y] == 0){
          boardDir[x][y] = 0;
        }
      }
    }
    //eating food and addition of segments
    if(segments.get(0).getxPos() == foodX && segments.get(0).getyPos() == foodY){
      if(segments.get(segments.size() - 1).getDir() == 1){      
        Segment seg = new Segment(segments.get(segments.size() - 1).getxPos(), segments.get(segments.size() - 1).getyPos() + 1, segments.get(segments.size() - 1).getDir());
        segments.add(seg);
      } else if(segments.get(segments.size() - 1).getDir() == 2){      
        Segment seg = new Segment(segments.get(segments.size() - 1).getxPos() - 1, segments.get(segments.size() - 1).getyPos(), segments.get(segments.size() - 1).getDir());
        segments.add(seg);
      } else if(segments.get(segments.size() - 1).getDir() == 3){      
        Segment seg = new Segment(segments.get(segments.size() - 1).getxPos(), segments.get(segments.size() - 1).getyPos() - 1, segments.get(segments.size() - 1).getDir());
        segments.add(seg);
      } else if(segments.get(segments.size() - 1).getDir() == 4){      
        Segment seg = new Segment(segments.get(segments.size() - 1).getxPos() + 1, segments.get(segments.size() - 1).getyPos(), segments.get(segments.size() - 1).getDir());
        segments.add(seg);
      }
      foodX = randomGenerator.nextInt(sizeX) + 0;
      foodY = randomGenerator.nextInt(sizeY) + 0;
      while(board[foodX][foodY] != 0){
        foodX = randomGenerator.nextInt(sizeX) + 0;
        foodY = randomGenerator.nextInt(sizeY) + 0;
      }
      score += 1;
      System.out.println("Score: " + score);
    }
  t = 0;
  }
  fill(#56EA1C);
  ellipse(foodX * 30 + 10, foodY * 30 + 10, 20, 20);

}

void keyPressed() {
  if (key == 119) {
    pressedKeyUp = true;
  } 
  if (key == 115) {
    pressedKeyDown = true;
  }
  if (key == 97) {
    pressedKeyLeft = true;
  }
  if (key == 100) {
    pressedKeyRight = true;
  }
}

void keyReleased() {
  if (key == 119) {
    pressedKeyUp = false;
  } 
  if (key == 115) {
    pressedKeyDown = false;
  }
  if (key == 97) {
    pressedKeyLeft = false;
  }
  if (key == 100) {
    pressedKeyRight = false;
  }
}
