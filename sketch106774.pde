/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/106774*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
snake test;
food food1;
int highScore;

void setup(){
  size(1000, 600);
  frameRate(50); //changed speed of snake from 14 to 50
  test = new snake();
  food1 = new food();
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  
  highScore = 0;
}



void draw(){
  background(110, 123, 209); //changed the color of the screen
  drawScoreboard();
  
  test.move();
  test.display();
  food1.display();
  
  
  if( dist(food1.xpos, food1.ypos, test.xpos.get(0), test.ypos.get(0)) < test.sidelen ){
    food1.reset();
    test.addLink();
  }
  
  if(test.len > highScore){
    highScore= test.len;
  }
}


void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      test.dir = "left";
    }
    if(keyCode == RIGHT){
      test.dir = "right";
    }
    if(keyCode == UP){
      test.dir = "up";
    }
    if(keyCode == DOWN){
      test.dir = "down";
    }
  }
}


void drawScoreboard(){
  // All of the scode for code and title
  
  fill(0, 0, 0);
  textSize(75); //changed text size of "Snake Game"
  text( "Snake Game", width/2, 80);
  fill(0, 0, 0);
  textSize(50); //changed text size of "By: Tati"
  text( "By: Tati", width/2, 140);
  
  
  // draw scoreboard
  stroke(0, 0, 0);
  fill(206, 217 ,229);
  rect(0, 0, 0, 0);
  fill(0, 0, 0);
  textSize(15);
  text( "Score: " + test.len, 70, 50); 
  fill(0, 0, 0);
  textSize(15);
  text( "High Score: " + highScore, 70, 70);
  //changed entire display of score board
  
}

class food{
  
  // define varibles
  float xpos, ypos;
  
  
  
  //constructor
  food(){
    xpos = random(100, width - 100);
    ypos = random(100, height - 100);
  }
  
  
  // functions
 void display(){
   
   fill(0,0,0);
   ellipse(xpos, ypos,10,10); //changed color and shape of circle
 }
 
 
 void reset(){
    xpos = random(100, width - 100);
    ypos = random(100, height - 100);
 }   
}

class snake{
  
  //define varibles
  int len;
  float sidelen;
  String dir; 
  ArrayList <Float> xpos, ypos;
  
  // constructor
  snake(){
    len = 1;
    sidelen = 17;
    dir = "right";
    xpos = new ArrayList();
    ypos = new ArrayList();
    xpos.add( random(width) );
    ypos.add( random(height) );
  }
  
  // functions
  
  
  void move(){
   for(int i = len - 1; i > 0; i = i -1 ){
    xpos.set(i, xpos.get(i - 1));
    ypos.set(i, ypos.get(i - 1));  
   } 
   if(dir == "left"){
     xpos.set(0, xpos.get(0) - sidelen);
   }
   if(dir == "right"){
     xpos.set(0, xpos.get(0) + sidelen);
   }
   
   if(dir == "up"){
     ypos.set(0, ypos.get(0) - sidelen);
  
   }
   
   if(dir == "down"){
     ypos.set(0, ypos.get(0) + sidelen);
   }
   xpos.set(0, (xpos.get(0) + width) % width);
   ypos.set(0, (ypos.get(0) + height) % height);
   
    // check if hit itself and if so cut off the tail
    if( checkHit() == true){
      len = 1;
      float xtemp = xpos.get(0);
      float ytemp = ypos.get(0);
      xpos.clear();
      ypos.clear();
      xpos.add(xtemp);
      ypos.add(ytemp);
    }
  }
  
  
  
  void display(){
    for(int i = 0; i <len; i++){
      stroke(179, 140, 198);
      fill(100, 0, 100, map(i-1, 0, len-1, 250, 50));
      rect(xpos.get(i), ypos.get(i), sidelen, sidelen);
    }  
  }
  
  
  void addLink(){
    xpos.add( xpos.get(len-1) + sidelen);
    ypos.add( ypos.get(len-1) + sidelen);
    len++;
  }
  
   boolean checkHit(){
    for(int i = 1; i < len; i++){
     if( dist(xpos.get(0), ypos.get(0), xpos.get(i), ypos.get(i)) < sidelen){
       return true;
     } 
    } 
    return false;
   } 
}
