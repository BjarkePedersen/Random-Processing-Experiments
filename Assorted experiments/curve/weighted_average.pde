
PVector getWeightedAveragePosition(PVector p1, PVector p2, float t) {
  return new PVector(p1.x * t + p2.x * ( 1 - t ), p1.y * t + p2.y * ( 1 - t) );
}
