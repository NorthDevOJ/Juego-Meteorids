class enemy {
  float xi = random(800 - 40);
  float yi = random(-250, 0);
  float x = xi;
  float y = yi;
  float damage;
  int life;
  float velocity;
  int shapeType; // Tipo de forma aleatoria
  color enemyColor; // Color aleatorio del enemigo
  Colision colisions;

  enemy(float enemyDamage, int enemyLife, float enemyVelocity) {
    damage = enemyDamage;
    life = enemyLife;
    velocity = random(enemyVelocity);
    shapeType = int(random(3)); // Asigna un valor aleatorio entre 0 y 2 para el tipo de forma
    enemyColor = color(random(255), random(255), random(255)); // Color aleatorio
    colisions = new Colision(x, y, 40, 40);
  }

  void display() {
    colisions.x = x;
    colisions.y = y;
    fill(enemyColor);
    switch (shapeType) {
    case 0:
      rect(x, y, 40, 40); 
      break;
    case 1:
      ellipse(x + 20, y + 20, 40, 40); 
      break;
    case 2:
      triangle(x, y + 40, x + 20, y, x + 40, y + 40); 
      break;
    }
    //colisions.showRect();
  }

  void fall() {
    y += random(3, velocity);
    display();
  }

  void colisionGun(int j) {
    punt += 100;
    gun.remove(j);
  }
}
