import ddf.minim.*;

Minim minim;
AudioPlayer menuMusic;
AudioPlayer gameMusic;
AudioPlayer shotSound;
AudioPlayer gameOverMusic;
boolean gameOverPlayed = false;
int scenas = 1;
boolean controlScenas = true;
PImage inicio, instrucciones;

// Dificultad
int enemyNumber = 3;
float enemyDamage = 2;
int enemyLife = 10;
float enemyVelocity = 10;

// Enemigo
ArrayList<enemy> enemy = new ArrayList<enemy>();
boolean enemyEmpty = false;

// Base
float baseLife = 10;
boolean baseDeath = false;
base base;

// Jugador
float playerLife = 3;
boolean playerDeath = false;
player player;

// Puntación
int etapa = 0;
int punt = 0;

// Arma
ArrayList<gun> gun = new ArrayList<gun>();
int gunAmmo = 15;

// Diseño
int realAmmo;
PFont fuente;
boolean sumar = true;
boolean background;
PImage naveImage; // Variable para la imagen de la nave espacial

Background b;

// Colsiones
Colision mouse;
Colision boton;
Colision boton1;

void Mouse() {
  mouse.x = mouseX;
  mouse.y = mouseY;
  mouse.showRect();
}

void Boton(float x, float y, float width, float height) {
  boton.x = x;
  boton.y = y;
  boton.width = width;
  boton.height = height;
}

void Boton1(float x, float y, float width, float height) {
  boton1.x = x;
  boton1.y = y;
  boton1.width = width;
  boton1.height = height;
}

void setup() {
  mouse = new Colision(mouseX, mouseY, 10, 20);
  boton = new Colision();
  boton1 = new Colision();
  b = new Background();

  // Se está inicializando la librería para la música
  minim = new Minim(this);

  // Cargar imagen inicio y créditos
  inicio = loadImage("2.jpg");
  instrucciones = loadImage("3.jpg");
  
  // Cargar imagen de la nave espacial
  naveImage = loadImage("Nave.png");
  

  // Carga los sonidos
  menuMusic = minim.loadFile("menu.mp3");
  gameMusic = minim.loadFile("game.mp3");
  shotSound = minim.loadFile("shot.mp3");
  gameOverMusic = minim.loadFile("gameover.mp3");

  // Reproduce la música del menú
  menuMusic.loop();

  // Configuración del juego
  size(800, 1000);
  base = new base(baseLife);
 
  player = new player(400, 900, naveImage); // Pasar la imagen de la nave al constructor del jugador
  player.setLife(playerLife);

  for (int i = 0; i < enemyNumber; i++) {
    this.enemy.add(new enemy(enemyDamage, enemyLife, enemyVelocity));
  }

  fuente = createFont("Bauhaus 93", 20);
  frameRate(60);
}

void draw() {
  Mouse();
  background(51);

  // Manejo de música según el estado del juego
  if (scenas == 1 || scenas == 2 || scenas == 3) {
    if (!menuMusic.isPlaying()) {
      menuMusic.loop();
    }
    gameMusic.pause();
    gameOverMusic.pause();
  } else if (scenas == 4 || scenas == 5 || scenas == 7) {
    menuMusic.pause();
    if (!gameMusic.isPlaying()) {
      gameMusic.rewind();  // Asegúrate de reiniciar la música del juego
      gameMusic.loop();
    }
    gameOverMusic.pause();
  } else if (scenas == 6 && !gameOverPlayed) {
    menuMusic.pause();
    gameMusic.pause();
    gameOverMusic.rewind();  
    gameOverMusic.play();
    gameOverPlayed = true;
  }
  
  //Condiciones del juego
  if (baseDeath || playerDeath) {
    scenas = 6;
  }
  
  if (sumar) {
    if (etapa % 5 == 0 && etapa != 0) {
      sumar = false;
      scenas = 5;
    }
  }

  if (enemy.size() <= 0) {
    enemyEmpty = true;
  }
  
  //Escenas//
  switch(scenas) {
  case 1:
    //Principal//
    if (controlScenas) {
      background(inicio);
    }
    if (mousePressed) {
      if (mouseX > 248 && mouseX < 543 && mouseY > 391 && mouseY < 480) {
        background(51);
        scenas = 3;
      }
      if (scenas != 3) {
        if (mouseX > 250 && mouseX < 550 && mouseY > 535 && mouseY < 619) {
          scenas = 2;
          controlScenas = false;
        }
      }
    }
    break;

  case 2:
    //Instrucciones//
    background(instrucciones);
    if (mousePressed) {
      if (mouseX > 27 && mouseX < 87 && mouseY > 39 && mouseY < 99) {
        scenas = 1;
        controlScenas = true;
      }
    }
    break;

  case 3:
    //Inicial//
    b.inicial();
    Boton(275, 531, 249, 124);
    if (mousePressed) {
      if (mouse.intersect(boton)) {
        scenas = 4;
      }
    }
    break;

  case 4:
    //MidGame//
    Boton(400, 900, 40, 40);
    gameOverPlayed = false;

    fill(0,255, 500);
    textSize(40);
    text("CLICK AQUÍ PARA INICIAR O CONTINUAR" , 30, 900);

    if (mousePressed) {
      if (mouse.intersect(boton)) {
        scenas = 7;
      }
    }
    break;

  case 5:
    //Etapa// 
    b.stage();
    
    if (mousePressed) {
      if (mouse.intersect(boton)) {
        scenas = 4;

        for (int i = 0; i < gun.size(); i++) {
          this.gun.remove(0);
        }

        for (int i = 0; i < enemy.size(); i++) {
          this.enemy.remove(0);
        }
        
      }
    }

    //Se reinician todos los valores para abandonar la partida
    if (mousePressed) {
      if (mouse.intersect(boton1)) {
        scenas = 1;
        controlScenas = true;
        Reset();
      }
    }
    break;

  case 6:
    //GameOver//
    b.GameOver();
    break;

  case 7:
    //Juego//
    if (enemyEmpty) {
      //Cuando se acaben los enemigos

      for (int i = 0; i < enemyNumber; i++) {
        this.enemy.add(new enemy(enemyDamage, enemyLife, enemyVelocity));
      }
      enemyEmpty = false;
    
      if (sumar) {
        etapa++;
      }else{
        
        if(etapa % 5 == 0) etapa++;
        if(etapa % 5 == 1) sumar = true;
      }

      b.principal();
    } else {
      //Aquí inicia el juego
      realAmmo = gunAmmo - this.gun.size();

      //Background Durante el juego
      b.principal();

      //Funcionalidad Base
      base.display();

      //Funcionalidad Jugador
      player.display();
      player.moveMouse();

      //Funcionalidad Disparo del Jugador
      if (mousePressed) {
        if (this.gun.size() < gunAmmo) {
          this.gun.add(new gun(player.x, player.y));
          shotSound.rewind();
          shotSound.play();
        }
      }

      for (gun gun : this.gun) {
        gun.display();
        gun.animation();
      }

      //Funcionalidad Enemigo
      for (int i = 0; i < enemy.size(); i++) {
        enemy enemy = this.enemy.get(i);
        enemy.fall();

        //Colisión con la Base
        if (enemy.colisions.intersect(base.colision)) {
          base.colisionEnemy(i);
          break;
        }


        //Colisión con el Jugador
        if (enemy.colisions.intersect(player.colision)) {
          player.colisionEnemy(i);
          break;
        }

        //Colisión con los Disparos
        if (this.gun.size() >= 0) {
          for (int j = 0; j < gun.size(); j++) {
            gun gun = this.gun.get(j);
            if (gun.colision.intersect(enemy.colisions)) {
              enemy.colisionGun(j);
              this.enemy.remove(i);
              break;
            }

            if (gun.y <= 30) {
              this.gun.remove(j);
              break;
            }
          }
        }
      }

      if (player.life <= 0) playerDeath = true;
      if (base.life <= 0) baseDeath = true;
    }
    break;
  default:
    background(51);
    break;
  }
}


void mousePressed() {
  if (scenas == 7 && this.gun.size() < gunAmmo) {
    gun Gun = new gun(player.x, player.y);
    this.gun.add(Gun);
    shotSound.rewind();
    shotSound.play();
  }
}

void Reset() {
  gameOverPlayed = false;
  enemyEmpty = false;
  baseDeath = false;
  playerLife = 3;
  playerDeath = false;
  etapa = 0;
  punt = 0;
  sumar = true;
}

void stop() {
  // Detiene todos los sonidos cuando se cierra el sketch
  menuMusic.close();
  gameMusic.close();
  shotSound.close();
  gameOverMusic.close();
  minim.stop();
  super.stop();
}
