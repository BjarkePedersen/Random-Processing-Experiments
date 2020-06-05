boolean startUp = true;
boolean beginApp = true;
int countdown = 180;

int playerCount = 2;

Player winner;

void main() {
    for (Player p : players) {
      p.move();
    }
    
    ball1.move();
}
