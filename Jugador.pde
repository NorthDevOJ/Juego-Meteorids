class player {
  float x;
  float y;
  float life;
  Colision colision;
  PImage naveImage; // Variable para almacenar la imagen de la nave

  player(float x, float y, PImage naveImage) {
    this.x = x;
    this.y = y;
    this.naveImage = naveImage; // Asigna la imagen de la nave
    colision = new Colision(x, y, 40, 40);
  }

  void setLife(float life) {
    this.life = life;
  }

  void display() {
    colision.x = x - 20;
    colision.y = y - 20;
    
    image(naveImage, x - naveImage.width / 2, y - naveImage.height / 2);
    // colision.showRect(); // Para mostrar el rectángulo de colisión (opcional)
  }

  void moveMouse() {
    x = mouseX;
    y = mouseY;
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
