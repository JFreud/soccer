 Ball ball;
 ArrayList<Player> teamLeft;
 ArrayList<Player> teamRight;
 ArrayList<Player> allPlayers;
 int scoreLeft, scoreRight;
 int hasBall; //Which team has the ball, relates with player actions
 int time;
 int timeStart;
 int duration;
 int switcher;
 PImage spritesLeft[];
 PImage spritesRight[];
 PImage spritesBall[];
 
 
 boolean leftUp, leftDown, leftLeft, leftRight;
 boolean rightUp, rightDown, rightLeft, rightRight;
 boolean rightAction, leftAction;
 
 void setup() {
   size(1200, 700);
   background(0, 125, 0);
   spritesLeft = new PImage[16];
   spritesRight = new PImage[16];
   spritesBall = new PImage[2];
   spritesLeft[0] = loadImage("sprites/left/back1.png");
   spritesLeft[1] = loadImage("sprites/left/back2.png");
   spritesLeft[2] = loadImage("sprites/left/downleft1.png");
   spritesLeft[3] = loadImage("sprites/left/downleft2.png");
   spritesLeft[4] = loadImage("sprites/left/downright1.png");
   spritesLeft[5] = loadImage("sprites/left/downright2.png");
   spritesLeft[6] = loadImage("sprites/left/front1.png");
   spritesLeft[7] = loadImage("sprites/left/front2.png");
   spritesLeft[8] = loadImage("sprites/left/left1.png");
   spritesLeft[9] = loadImage("sprites/left/left2.png");
   spritesLeft[10] = loadImage("sprites/left/right1.png");
   spritesLeft[11] = loadImage("sprites/left/right2.png");
   spritesLeft[12] = loadImage("sprites/left/topleft1.png");
   spritesLeft[13] = loadImage("sprites/left/topleft2.png");
   spritesLeft[14] = loadImage("sprites/left/topright1.png");
   spritesLeft[15] = loadImage("sprites/left/topright2.png");
   spritesRight[0] = loadImage("sprites/right/back1.png");
   spritesRight[1] = loadImage("sprites/right/back2.png");
   spritesRight[2] = loadImage("sprites/right/downleft1.png");
   spritesRight[3] = loadImage("sprites/right/downleft2.png");
   spritesRight[4] = loadImage("sprites/right/downright1.png");
   spritesRight[5] = loadImage("sprites/right/downright2.png");
   spritesRight[6] = loadImage("sprites/right/front1.png");
   spritesRight[7] = loadImage("sprites/right/front2.png");
   spritesRight[8] = loadImage("sprites/right/left1.png");
   spritesRight[9] = loadImage("sprites/right/left2.png");
   spritesRight[10] = loadImage("sprites/right/right1.png");
   spritesRight[11] = loadImage("sprites/right/right2.png");
   spritesRight[12] = loadImage("sprites/right/topleft1.png");
   spritesRight[13] = loadImage("sprites/right/topleft2.png");
   spritesRight[14] = loadImage("sprites/right/topright1.png");
   spritesRight[15] = loadImage("sprites/right/topright2.png");
   spritesBall[0] = loadImage("ball1.png");
   spritesBall[1] = loadImage("ball2.png");
   scoreLeft = 0;
   scoreRight = 0;
   drawfield();
   time = 180;
   timeStart = millis();
   duration = 180;
   noCursor();
   hasBall = 0;
   teamLeft = new ArrayList<Player>();
   teamLeft.add(new Player(0, 80, 80, 80));
   //fill team left
   teamRight = new ArrayList<Player>();
   teamRight.add(new Player(1, 80, 80, 80));
   //fill team right
   allPlayers = new ArrayList<Player>();
   allPlayers.addAll(teamLeft);
   allPlayers.addAll(teamRight);
   ball = new Ball(allPlayers);
 }

 void resetPlayerPositions(){
     ball.pos.x = width/2;
     ball.pos.y = height/2;
     ball.acc.x = 0;
     ball.acc.y = 0;
     for(int i = 0; i < teamLeft.size(); i++) {
       teamLeft.get(i).pos.x = width/4;
       teamLeft.get(i).pos.y = height/2;
       teamLeft.get(i).dir = 90;
     }
     for(int i = 0; i < teamRight.size(); i++) {
       teamRight.get(i).pos.x = width*3/4;
       teamRight.get(i).pos.y = height/2;
       teamRight.get(i).dir = 270;
     }
 }
 
 void drawfield() {
   //score
   textSize(30);
   fill(255, 0, 0);
   text(scoreLeft, width/4, 40);
   fill(0, 0, 255);
   text(scoreRight, width*3/4, 40);
   //ring in middle
   fill(255);
   ellipse(width/2, height/2, 200, 200);
   fill(0, 125, 0);
   ellipse(width/2, height/2, 180, 180);
   //line down middle
   strokeWeight(10);
   stroke(255);
   line(width/2, 0, width/2, height);
   strokeWeight(5);
   //goalie boxes
   arc(165, height/2, 150, 150, PI*3/2, PI*5/2);
   rect(0, height/2 - 200, 165, 400);
   rect(0, height/2 - 80, 55, 160); //Left Goal Box
   arc(width-165, height/2, 150, 150, PI/2, PI*3/2);
   rect(width - 165, height/2 - 200, 165, 400);
   rect(width - 55, height/2 - 80, 55, 160); //Right Goal Box
   strokeWeight(4);
   stroke(0);
   //time on top
   fill(0);
   text(time, width/2 - 20, 30);
   strokeWeight(1);
 }
 
 void draw() {
   gameState();
   if (time <= 0) {
     endGame();
   }
 }
 
 void whoHasBall(){
   for (int i = 0; i < teamLeft.size(); i++){
     if (teamLeft.get(i).gotBall){
       hasBall = 0;
       return;  
     }
   }
   for (int i = 0; i < teamRight.size(); i++){
     if (teamRight.get(i).gotBall){
       hasBall = 1;
       return;  
     }
   }
 }
 
 
 void endGame() {
   background(0);
   textSize(40);
   text("Game Ended", width/2 - 100, height/2);
   text("Score: \n" + scoreLeft + " - " + scoreRight, width/2 - 90, height/2 + 30);
   noLoop();
 }
 
 
 void gameState() {
   background(0, 125, 0);
   time = duration - (millis() - timeStart)/1000;
   whoHasBall();
   drawfield();
   ball.display();
   for (int i = 0; i < allPlayers.size(); i++) {
     allPlayers.get(i).display();
   }
   if (ball.inGoal() == 1){
     scoreRight++;
     fill(255, 0, 0);
     text("Blue Team has scored!", width/2 - 10, 20);
     delay(1000);
     resetPlayerPositions();
   }
   else if (ball.inGoal() == 0){
     scoreLeft++;
     fill(0, 0, 255);
     text("Red Team has scored!", width/2 - 10, 20);
     delay(1000);
     resetPlayerPositions();
   }
 }
 
void keyPressed() {
  //left player
  if (key == 'w') { leftUp = true; }
  if (key == 'a') { leftLeft = true; }
  if (key == 's') { leftDown = true; }
  if (key == 'd') { leftRight = true; }
  
  //right player
  if (key == CODED) { 
    if (keyCode == UP) {
      rightUp = true; 
    }
  }
  if (key == CODED) { 
    if (keyCode == DOWN) {
      rightDown = true; 
    }
  }
  if (key == CODED) { 
    if (keyCode == LEFT) {
      rightLeft = true; 
    }
  }
  if (key == CODED) { 
    if (keyCode == RIGHT) {
      rightRight = true; 
    }
  }
  if (key == ',') {
    rightAction = true;
  }
  if (key == CODED) {
    if (keyCode == CONTROL){
      leftAction = true;
    }
  }
}

void keyReleased() {
  //left player
  if (key == 'w') { leftUp = false; }
  if (key == 'a') { leftLeft = false; }
  if (key == 's') { leftDown = false; }
  if (key == 'd') { leftRight = false; }
  
  //right player
  if (key == CODED) { 
    if (keyCode == UP) {
      rightUp = false; 
    }
  }
  if (key == CODED) { 
    if (keyCode == DOWN) {
      rightDown = false; 
    }
  }
  if (key == CODED) { 
    if (keyCode == LEFT) {
      rightLeft = false; 
    }
  }
  if (key == CODED) { 
    if (keyCode == RIGHT) {
      rightRight = false; 
    }
  }
  if (key == ',') {
    rightAction = false;
  }
  if (key == CODED) {
    if (keyCode == CONTROL){
      leftAction = false;
    }
  }
}
