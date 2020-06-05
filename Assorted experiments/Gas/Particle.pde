class Particle {

  // We need to keep track of a Body and a radius
  Body body;
  float r;
  
  color col;

  Particle(float x, float y, float r_, boolean fixed) {
    r = r_;
    
    // Define a body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;

    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    body = box2d.world.createBody(bd);

    // Make the body's shape a circle
    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.0;
    fd.restitution = 1;
    
    body.createFixture(fd);
    
    col = color(0);
  }
  
  void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }
  
  void setVelocity(float multiplier) {
    float velX = body.getLinearVelocity().x * multiplier;
    float velY = body.getLinearVelocity().y * multiplier;
    Vec2 vel = new Vec2(velX, velY);
    body.setLinearVelocity(vel);
  }


  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float velX = abs(body.getLinearVelocity().x);
    float velY = abs(body.getLinearVelocity().y);
    float vel = velX + velY;
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(color(180-vel*16, 255, 255));
    noStroke();
    ellipse(0,0,r*2,r*2);
    // Let's add a line so we can see the rotation
    popMatrix();
  }


}
