
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

// A list we'll use to track fixed objects
ArrayList boundaries;

Box2DProcessing box2d;
PVector anchor;

Boundary base, leftBoundary , rightBoundary , top;
Ball ball ;

ArrayList<Ball> balls;
ArrayList<Box> boxes;

Catapoult catapoult;






void setup(){
  size(1200,360);
  smooth();
 box2d = new Box2DProcessing(this);
 box2d.createWorld();
 box2d.setGravity(0,-20);
 box2d.listenForCollisions();

 
 
  boundaries = new ArrayList();
  Boundary base = new Boundary(width/2,height-5,width,10,0);
  base.isBase = true;
  boundaries.add(base);
  boundaries.add(new Boundary(width/2,5,width,10,0));
  boundaries.add(new Boundary(width-5,height/2,10,height,0));
  boundaries.add(new Boundary(5,height/2,10,height,0));
  
  boundaries.add(new Boundary(width/2 , (float) height/2 ,(float) 200 ,(float) 10 , 0));
  
  
  boxes = new ArrayList<Box>();
  boxes.add(new Box(width/2 , 120 , 120,120) );
  
  

 
balls = new ArrayList<Ball>();

 

 
 anchor = new PVector( 150 , height-150);
 
 ball = new Ball(anchor.x , anchor.y,10);
 catapoult = new Catapoult(anchor);
 boundaries.add(new Boundary(anchor.x , anchor.y+90, 20 , height - 250 , 0) );
 
 
 

}




void draw(){
  
  //if(ball.isdragged == true){
    //  Vec2 pos = box2d.getBodyPixelCoord(ball.body);
  
  //stroke(255);
    //fill(255);
    //line(anchor.x, anchor.y , pos.x , pos.y);
  
  //}
  
  
  
  if(ball.istouching == true ){
  //Vec2 an = box2d.coordPixelsToWorld(anchor.x , anchor.y);
    
   //ball.body.setTransform(an,0);
   //ball.istouching = false;
   
   if(ball.numBounces>3){
     box2d.destroyBody(ball.body);
   
   ball = new Ball(anchor.x ,anchor.y , 10);
   
   }
  
  }
  
  catapoult.update(mouseX,mouseY);
  
  
  

  background(0);
  stroke(255);
  
line(anchor.x , anchor.y+100, anchor.x , anchor.y);
  
 

ball.show();
//for(Ball ball:balls){ ball.show();}
 // Draw the boundaries
  for (int i = 0; i < boundaries.size(); i++) {
    Boundary wall = (Boundary) boundaries.get(i);
    wall.display();
  }
  
  
  for(Box box : boxes) {box.show();}
box2d.step();
}


  void mousePressed () {
    
    
      if (ball.contains((float) mouseX,(float) mouseY)) {
    // And if so, bind the mouse location to the box with a spring
    catapoult.bind(mouseX,mouseY,ball);
  }
    
   // ball.isdragged = true;
  
  
  }
  
  void mouseReleased(){
    
    catapoult.destroy();
    
 // ball.isdragged = false;
  ball.release(anchor);
  }
  
  
  
  
 // Collision event functions!
void beginContact(Contact cp) throws Exception {
  
 
  // Get both shapes
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  
  if(o1.getClass() == Boundary.class && o2.getClass() == Ball.class){

    
    Ball b = (Ball) o2;
       
    Boundary bo = (Boundary) o1;
    if(bo.isBase == true ){
       b.numBounces ++;
    
    }
    if( b.numBounces>3){
      
          b.istouching = true;
    
    }
    

    
    
  
  
  
  }

 
  

}

// Objects stop touching each other
void endContact(Contact cp) {
}

   
    
  
  
  
  
  
