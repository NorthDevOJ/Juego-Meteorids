class base {
  float life;
  Colision colision;

  base(float baseLife) {
    life = baseLife;
    colision = new Colision(0, 700, 800, 10);
  }

  void display() {
    fill(255, 204);
    rect(0, 700, 800, 10);
  }

  void colisionEnemy(int i) {
    if (punt > 0) { 
      punt -= 100;
      if (punt < 0) {
        punt = 0; 
      }
    }
    life -= enemyDamage;
    enemy.remove(i);
  }
}
