class Ball{

float radius;
Body body;
 BodyDef bd;
 boolean istouching;
 int numBounces; //,isdragged;



Ball(float x , float y , float r){
 
  istouching = false;
  //isdragged = false;
  numBounces = 0;
  
  
  this.radius = r;
  
  bd= new BodyDef();
  bd.type = BodyType.DYNAMIC;
   bd.position.set(box2d.coordPixelsToWorld(x,y));
  
   body = box2d.createBody(bd);
   body.setUserData(this);
   
  
  CircleShape cr = new CircleShape();
  cr.m_radius = box2d.scalarPixelsToWorld(radius);
  
  
   FixtureDef fd = new FixtureDef();
   
   fd.shape =cr;
   fd.friction = 0.5;
   fd.restitution = 0.8;
   fd.density = 0.4;
   
   
   body.createFixture(fd);
   body.setLinearVelocity(new Vec2(0, 0));
    body.setAngularVelocity( 0);







}

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }



 void show(){
   
 // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(255);
    stroke(0);
    circle(0, 0,2* radius);
    popMatrix();
 
 }


void release(PVector anchor){
  
  Vec2 anc = new Vec2(anchor.x , anchor.y);
  Vec2 pos = box2d.getBodyPixelCoord(body);
  
  Vec2 force = pos.sub(anc);
  float mag = force.normalize();
  force.mulLocal(-4*mag);
  
  body.applyForce(box2d.coordWorldToPixels(force),body.getWorldCenter());
  
stroke(255);
    fill(255);
    line(anchor.x, anchor.y , pos.x , pos.y);



}





}
