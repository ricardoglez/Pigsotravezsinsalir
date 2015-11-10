Pigs[] puer = new Pigs[7];
Atracttor[] atr = new Atracttor[7];

//PVector mouse = new PVector(mouseX,mouseY);

void setup() {
  size(800, 600);
  for (int i = 0; i < puer.length; i++) {
    puer[i] = new Pigs(i, random( 35, 50));
    atr [i] = new Atracttor(puer[i].pLoc.x, puer[i].pLoc.y);
  }
  frameRate(8);
}
void draw() {
  background(255);
  for (int i = 0; i < puer.length; i++) {
    for (int j = 0; j < puer.length; j++) {
      if (i != j) {
        if (puer[j].checkMove()) {
          PVector force = puer[j].attract(atr[i]);
          puer[i].applyForce(force);
        } else {
          //PVector force = puer[j].vel;
          //force.mult(-1);
          puer[j].vel = new PVector(0,0);
        }
      }
    }
    PVector force = puer[i].attract(atr[i]);
    puer[i].checkEdges();
    puer[i].update();
    puer[i].display();
  }
}


