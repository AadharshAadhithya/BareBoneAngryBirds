class Catapoult{
  Body ref;
  Vec2 anchor ;
  MouseJoint mouseJoint;
  Catapoult(PVector anc){
    this.anchor = new Vec2(anc.x , anc.y);
    mouseJoint = null;
    
    
    
    
    
  
  }
  
  void bind(float x , float y , Ball ball){
  
  
  MouseJointDef md = new MouseJointDef();
  
  BodyDef bd = new BodyDef();
  bd.position.set(box2d.coordPixelsToWorld(this.anchor.x,this.anchor.y));
  
  ref = box2d.createBody(bd);
  
  
  md.bodyA = ref ;
  
  md.bodyB = ball.body;
  
  Vec2 mp = box2d.coordPixelsToWorld(x,y);
  
  md.target.set(mp);
  
  md.maxForce = 1000.0 * ball.body.m_mass;
  md.dampingRatio = 0.4;
  
  mouseJoint = (MouseJoint) box2d.world.createJoint(md);
  
  
  show();
  
  
  
  
  
  
  }
  
  void show(){
    
    if (mouseJoint != null){
        if (mouseJoint != null) {
      // We can get the two anchor points
      Vec2 v1 = new Vec2(0,0);
      mouseJoint.getAnchorA(v1);
      Vec2 v2 = new Vec2(0,0);
      mouseJoint.getAnchorB(v2);
      // Convert them to screen coordinates
      v1 = box2d.coordWorldToPixels(v1);
      v2 = box2d.coordWorldToPixels(v2);
      // And just draw a line
      stroke(0);
      strokeWeight(1);
      line(v1.x,v1.y,v2.x,v2.y);
        }
      
    
    
    }
  
  
  
  
  
  
  
  
  
  
  
  
  }
  
    void update(float x, float y) {
    if (mouseJoint != null) {
      // Always convert to world coordinates!
      Vec2 mouseWorld = box2d.coordPixelsToWorld(x,y);
      mouseJoint.setTarget(mouseWorld);
    }
  }
  
  void destroy( ){
    
    if (mouseJoint != null){
      box2d.world.destroyJoint(mouseJoint);
      mouseJoint = null;
    
    
    }
    
    ref = null;
  
  }




}
