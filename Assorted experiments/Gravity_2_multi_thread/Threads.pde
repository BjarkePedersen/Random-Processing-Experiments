void controlThread() {
  while (true) {
    if (t1 == 1 && t2 == 1 && step == 0) { 
      step = -1; 
      t1 = 0; 
      t2 = 0;
      step = 1;
    }
    if (t1 == 1 && t2 == 1 && step == 1) { 
      step = -1;  
      t1 = 0; 
      t2 = 0;
      step = 0;
    }
  }
}
void thread1() {
  while (true) {

    if (step == 0) {
      if (t1 == 0) {
        for (int i=0; i<ps.length/2; i++) { 
          P p = ps[i];
          p.forces();
        }
        t1 += 1;
      }
    }

    if (step == 1) {
      if (t1 == 0) {
        for (int i=0; i<ps.length/2; i++) { 
          P p = ps[i];
          p.move();
        }
        t1 += 1;
      }
    }
  }
}

void thread2() {
  while (true) {

    if (step == 0) {
      if (t2 == 0) {
        for (int i=ps.length/2; i<ps.length; i++) { 
          P p = ps[i];
          p.forces();
        }
        t2 += 1;
      }
    }

    if (step == 1) {
      if (t2 == 0) {
        for (int i=ps.length/2; i<ps.length; i++) { 
          P p = ps[i];
          p.move();
        }
        t2 += 1;
      }
    }
  }
}