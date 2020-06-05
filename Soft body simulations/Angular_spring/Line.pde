// TO DO:
// Boundary collision
// Seperate compression and expansion dampening

// Angular resistance / dampening

float ropeElmLen = 100;

public class Line {
  Vert v1, v2;
  float restLen, dist, v1proj, v2proj;
  PVector v1dir, v2dir, v1LocVel, v2LocVel, v1damp, v2damp;
  float push = .999;  // Resistance to expanding
  float pull = .999;  // Resistance to pulling
  float damp = .99;  // Compression / expansion dampening

  public Line(Vert v1, Vert v2) {
    this.v1 = v1;
    this.v2 = v2;
    
    //restLen = v1.loc.dist(v2.loc);
    restLen = ropeElmLen;

    // Divide by time scale
    damp /= tScale;    
    push /= tScale;
    pull /= tScale;
  }

  void calcForces() {
    // Heading of contraction / expansion vector
    v1dir = new PVector(v2.loc.x - v1.loc.x, v2.loc.y - v1.loc.y);
    v2dir = new PVector(v1.loc.x - v2.loc.x, v1.loc.y - v2.loc.y);

    // Normalize to length = 1
    v1dir.normalize();
    v2dir.normalize();


    // Multiply heading by difference between distance and rest length
    // to get magnitude of force
    dist = v1.loc.dist(v2.loc);
    v1dir.mult(dist-restLen);
    v2dir.mult(dist-restLen);

    v1damp = new PVector(v1dir.x, v1dir.y);
    v2damp = new PVector(v2dir.x, v2dir.y);
    
    // Convert vertex velocities to local space
    v1LocVel = new PVector(v1.vel.x - v2.vel.x, v1.vel.y - v2.vel.y);
    v2LocVel = new PVector(v2.vel.x - v1.vel.x, v2.vel.y - v1.vel.y);

    // Project velocity vector onto direction vector 
    // to isolate compression / expansion velocity
    v1proj = v1LocVel.dot(v1damp) / pow(mag(v1damp.x, v1damp.y), 2);
    v2proj = v2LocVel.dot(v2damp) / pow(mag(v2damp.x, v2damp.y), 2);
    v1damp.mult(v1proj);
    v2damp.mult(v2proj);
    
    
    // Tighten up first connection
    if (v2 == verts[1]) {v2dir.mult(10);}
    
    
    if (dist > restLen) {
      // Push / pull stiffness
      v1dir.mult(pull);
      v2dir.mult(pull);

      // Dampening (multiply braking vector with dampening constant)
      v1dir.sub(v1damp.mult(damp));
      v2dir.sub(v2damp.mult(damp));
      
    } else if (dist < restLen) {
      v1dir.mult(push);
      v2dir.mult(push);

      // Dampening
      v1dir.sub(v1damp.mult(damp));
      v2dir.sub(v2damp.mult(damp));
    }

    // Divide by mass
    v1dir.div(v1.mass);
    v2dir.div(v2.mass);

    // Multiply by time scale
    v1dir.mult(tScale);
    v2dir.mult(tScale);
    
    // Apply forces (geez finally)
    v1.applyForce(v1dir);
    v2.applyForce(v2dir);
  }

  void show() {
    line(v1.loc.x, v1.loc.y, v2.loc.x, v2.loc.y);    
  }
}
