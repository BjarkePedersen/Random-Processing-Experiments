ArrayList<Branch> tree;
Branch root;
int iterations = 11;
int q;
int f;

void setup () {
  fill(0);
  size(800, 800, P2D);
  smooth(8);
  tree = new ArrayList<Branch>();

  PVector a = new PVector(width/2, height) ;
  PVector b = new PVector(width/2, height-200);
  root = new Branch(a, b);
  tree.add(root);
}

void keyPressed() {
  tree.clear();
  PVector a = new PVector(width/2, height) ;
  PVector b = new PVector(width/2, height-200);
  root = new Branch(a, b);
  tree.add(root);

  f = 0;
  q = 0;
}


void grow() {
  {
    for (int i = tree.size()-1; i>=0; i--) {
      if (!tree.get(i).finished) {
        Branch newBranchA = tree.get(i).branchR();
        Branch newBranchB = tree.get(i).branchL();
        tree.add(newBranchA);
        tree.add(newBranchB);
        tree.get(i).finished = true;
      }
    }
  }
}
void draw() {
  background(25);

  for (Branch i : tree) {
    //i.wind(f);
    i.show();
  }

  if (f % 50 == 0) {
    if (q < iterations) {
      grow();
    }
    q++;
  }
  f++;
}