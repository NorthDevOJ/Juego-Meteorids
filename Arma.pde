class gun {
  float x, y;
  Colision colision;

  gun(float x, float y) {
    this.x = x;
    this.y = y;
    colision = new Colision(this.x, this.y, 5, 20);
  }

  void display() {
    colision.x = x;
    colision.y = y;
    fill(255, 204);
    rect(x, y, 5, 20);
    //colisions.showRect();
  }

  void animation() {
    y -= 20;
    display(); 
  }
}
