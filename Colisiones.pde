class Colision{
   float x, y, width, height;
   
   Colision(){}
   
   Colision(float x_, float y_, float width_, float height_) {
    x = x_;
    y = y_;
    width = width_;
    height = height_;
  }
  // ^^^ Constructores ^^^
  boolean intersect(Colision another){ // Función principal para manejar colisiones
    return x < another.x + another.width && x + another.width > another.x && y < another.y + another.height && y + another.height > another.y; // Retorna true si ambos objetos colisionan
  }
  
  void showRect() { // Mostrar un rectangulo que represente la caja de colisiones de los objetos
    fill(255, 0, 0);
    rect(x, y, width, height);
  }
}
