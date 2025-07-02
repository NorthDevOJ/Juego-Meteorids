class Background {

  Background() {
  }

  void Puntuacion() {
    fill(255, 204);
    textFont(fuente);
    textSize(120);
    text("Puntaje", 157, 207);
  }

  void GameOver() {
    fill(255, 0, 0);
    textFont(fuente);
    textSize(120);
    text("GAME OVER", 100, 500);
    
    
    fill(255, 204);
    textFont(fuente);
    textSize(60);
    text("Puntaje: "+punt, 100, 600);
  }

  void inicial() {
    fill(255, 204);
    textFont(fuente);
    textSize(120);
    text("METIORIDS", 121, 322);

    fill(#C7D6DF);
    rect(275, 531, 249, 124);

    fill(255, 204);
    textFont(fuente);
    textSize(58);
    text("Iniciar", 310, 597);

    fill(255, 204);
    textFont(fuente);
    textSize(10);
    text("Presiona Enter o haz clic en cuadro", 315, 619);
  }

  void principal() {
    fill(255);
    textFont(fuente);
    text("Vida del jugador = " + int(player.life), 17, 941);
    text("Vida de la base = " + int(base.life), 17, 977);
    text("Puntaje = " + punt, 17, 30);
    text("Etapa " + (etapa + 1 ), 357, 30);
    text(realAmmo + "/" + gunAmmo, 713, 974);
  }

  void stage() {
    fill(255, 204);
    textFont(fuente);
    textSize(90);
    text("Etapa actual: " + etapa , 80,290);

    fill(255, 204);
    textFont(fuente);
    textSize(49);
    text("¿Seguir Jugando?", 207, 447);

    //Continuar
    Boton(470, 530, 160, 100);
    fill(152, 200);
    rect(470, 530, 160, 100);

    fill(255, 204);
    textFont(fuente);
    textSize(28);
    text("Continuar", 487, 590);

    //Abandonar
    Boton1(180, 530, 160, 100);
    fill(152, 200);
    rect(180, 530, 160, 100);

    fill(255, 204);
    textFont(fuente);
    textSize(28);
    text("Abandonar", 192, 590);
  }
}
