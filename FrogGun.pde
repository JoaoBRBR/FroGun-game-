/////////sons
import processing.sound.*;
SoundFile tiro, outAmmo, pickUp, quica, hurt, perder, nextLevel;

///imagens
PImage BG, cave, mush, frog, mira, ammo, sujo,
  barra, shoot, enemy, benemy, jenemy, jelly, boos, smash, smashA, smashB,
  life, dead, left, logo, over, zerar;

///vetores
PVector saPos, scopy, grav, vel, fvel, aim,
  mia, point, aimCopy, ammoSpawn;

///variaveis
float x=100, y=100, power=10, g=0.1, smashx=-50, smashy=-50,
  smashAx=-50, smashAy=-50, smashBx=-50, smashBy=-50, delta;
int chave=3, vida=3, fase=1, record=0,
  bixoUmQuantidade=1, bixoDoisQuantidade=0, bixoTresQuantidade=0,
  bixoQuatroQuantidade=0, bixoCincoQuantidade=0,
  estadoDoJogo=0, BC;
boolean jumpKey=true;
boolean faseKey=true;
int faseObjetivo=bixoUmQuantidade;

///constantes
float s, d, twoS, twoD, sujoSize, sujoHeight,
  hs, ss, textoA, textoB;
int bixosAmount=30;

//// classe
bixo[] bixo=new bixo[bixosAmount];
bixoA[] bixoA=new bixoA[bixosAmount];
bixoB[] bixoB=new bixoB[bixosAmount];
bixoC[] bixoC=new bixoC[bixosAmount];
boss[] boss=new boss[bixosAmount];
void setup() {
  size(displayWidth, displayHeight); //displayWidth, displayHeight
  ///iniciando classe
  for (int i=0; i<bixosAmount; i++) {
    bixo[i] = new bixo();
    bixoA[i] = new bixoA();
    bixoB[i] = new bixoB();
    bixoC[i] = new bixoC();
    boss[i] = new boss();
  }
  ///seting up constantes
  s=width/10;
  twoS=2*s;
  hs=s/2;
  ss=width/26;
  d=height/10;
  twoD=2*d;
  power=width/20;
  g=d/500;
  sujoSize=height-(height/3);
  sujoHeight=height/3;
  textoA=width/8;
  textoB=width/3;
  ////carregar sons:
  tiro = new SoundFile(this, "tiro.mp3");
  outAmmo = new SoundFile(this, "outAmmo.mp3");
  pickUp = new SoundFile(this, "pickUp.mp3");
  quica = new SoundFile(this, "quica.mp3");
  hurt = new SoundFile(this, "hurt.mp3");
  perder = new SoundFile(this, "perder.mp3");
  nextLevel = new SoundFile(this, "nextLevel.mp3");
  /// carregar imagens
  BG = loadImage("BG1.png");
  cave = loadImage("cave.png");
  mush = loadImage("mush.png");
  frog = loadImage("frogy.png");
  mira = loadImage("mira.png");
  ammo = loadImage("ammo.png");
  left = loadImage("left.png");
  sujo = loadImage("sujo.png");
  barra = loadImage("Barra.png");
  shoot = loadImage("shoot.png");
  enemy = loadImage("enemy.png");
  jenemy = loadImage("jenemy.png");
  benemy = loadImage("benemy.png");
  smash = loadImage("smash.png");
  smashA = loadImage("smash2.png");
  smashB = loadImage("smash3.png");
  life = loadImage("life.png");
  dead = loadImage("dead.png");
  logo = loadImage("logo.png");
  over = loadImage("over.png");
  zerar = loadImage("zerar.png");
  boos = loadImage("boss.png");
  jelly = loadImage("jelly.png");
  /// criar vetores
  saPos= new PVector(width/2, height/3);
  grav= new PVector(0, g);
  vel= new PVector(0, 0);
  fvel=new PVector(0, 0);
  aim= new PVector(mouseX, mouseY);
  mia= new PVector(saPos.x-aim.x, saPos.y-aim.y);
  scopy= new PVector(0, 0);
  point= new PVector(50, 50);
  aimCopy= new PVector(0, 0);
  ammoSpawn= new PVector(random(s, width-s), random(twoS, height-2*d));
}

////////////////////////////////////////////////////////////////

void draw() {
  delta=60/frameRate;
  if (estadoDoJogo==0) {
    image(BG, 0, 0, width, height);
    imageMode(CENTER);
    image(logo, width/2, height/3, height/3, height/3);
    imageMode(CORNER);
    textSize(textoA);
    fill(0);
    text("highscore:"+record, (width/2)-twoD, (height/2)+d);
    if (mousePressed) {
      BC=int(random(3));
      chave=4;
      estadoDoJogo=1;
    }
  } else if (estadoDoJogo==1) {
    if (fase>record) {
      record=fase;
    }
    ///fase setup
    fases();
    ///imagens fundo
    if (BC==0) {
      image(cave, 0, 0, width, height);
    } else if (BC==1) {
      image(BG, 0, 0, width, height);
    } else if (BC==2) {
      image(mush, 0, 0, width, height);
    }
    image(sujo, 0, sujoSize, width, sujoHeight);
    ///calculos
    vetores();
    ///desenho principal
    imageMode(CENTER);
    textSize(textoB);
    fill(100);
    text(fase, (width/2)-d, height/2);
    desenha();
    ///condicoes
    ifs();
    imageMode(CORNER);
    ///informacoes de jogo
    image(barra, 0, 0, width, d);
    image(ammo, 5, hs, s, s);
    fill(0);
    textSize(textoA);
    text(":"+chave, s+5, s+hs);
    image(left, 2*twoS, hs, s, s);
    text(":"+faseObjetivo, 2*twoS+s, s+hs);
    vidasCheck();
 ////////////////////////////////
  } else if (estadoDoJogo==2) {
    image(BG, 0, 0, width, height);
    imageMode(CENTER);
    image(over, width/2, height/3, height/3, height/3);
    imageMode(CORNER);
    textSize(textoA);
    fill(0);
    text("highscore:"+record, (width/2)-twoD, (height/2)+d);
    if (mousePressed) {
      estadoDoJogo=0;
      delay(1000);
    }
  } else if (estadoDoJogo==3) {
    image(BG, 0, 0, width, height);
    imageMode(CENTER);
    image(zerar, width/2, height/3, height/3, height/3);
    imageMode(CORNER);
    textSize(textoA);
    fill(0);
    text("highscore:"+record, (width/2)-twoD, (height/2)+d);
    if (mousePressed) {
      BC=int(random(3));
      estadoDoJogo=0;
      delay(1000);
    }
  }
}

//////////////////////////////////////////////////////////////////////
void vidasCheck() {
  if (vida==3) {
    image(life, width-s, hs, s, s);
    image(life, width-2*s, hs, s, s);
    image(life, width-3*s, hs, s, s);
  } else if (vida==2) {
    image(life, width-s, hs, s, s);
    image(life, width-2*s, hs, s, s);
    image(dead, width-3*s, hs, s, s);
  } else if (vida==1) {
    image(life, width-s, hs, s, s);
    image(dead, width-2*s, hs, s, s);
    image(dead, width-3*s, hs, s, s);
  } else if (vida==0) {
    image(dead, width-s, hs, s, s);
    image(dead, width-2*s, hs, s, s);
    image(dead, width-3*s, hs, s, s);
  }
}

//////////////////////////////////////////////////////////////////////

void ifs() {
  ///se vida<0
  if (vida<0) {
    perder.play();
    vida=3;
    fase=1;
    faseKey=true;
    estadoDoJogo=2;
    delay(1000);
    for (int i=0; i<bixosAmount; i++) {
      bixo[i].reset();
      bixoA[i].reset();
      bixoB[i].reset();
      bixoC[i].reset();
      boss[i].reset();
    }
  }
  ////se quicando
  if (saPos.x<=0) {
    saPos.x += 4;
    vel.x *= -1;
    quica.play();
  } else if (saPos.x>=width) {
    saPos.x -= 4;
    vel.x *= -1;
    quica.play();
  }
  //se acima da tela
  if (saPos.y<d) {
    vel.y=0;
    saPos.y=d+3;
  }
  //se tocando municao
  if (dist(saPos.x, saPos.y, ammoSpawn.x, ammoSpawn.y)<s) {
    ammoSpawn.set(random(s, width-s), random(twoD, height-2*twoD));
    chave +=3;
    pickUp.play();
  }
  //se polar e der pra pular
  if (mousePressed && chave<=0) {
    outAmmo.play();
  }
  if (mousePressed && chave>0 && jumpKey==true) {
    vel.add(mia);
    chave--;
    jumpKey=false;
    image(shoot, point.x, point.y, twoS, twoS);
    tiro.play();
  } else if (!mousePressed) {
    jumpKey=true;
  }
  //se caindo
  if (saPos.y>height) {
    hurt.play();
    vida--;
    chave=3;
    ammoSpawn.set(random(50, width-50), random(50, height-150));
    vel.set(0, 0);
    saPos.set(width/2, height/3);
  }
}

void vetores() {
  aim.x=mouseX;
  aim.y=mouseY;
  vel.add(grav);
  fvel.set(vel);
  fvel.mult(delta);
  saPos.add(fvel);
  scopy.set(saPos);
  mia.set(scopy.add(scopy.sub(aim)));
  mia.normalize();
  mia.setMag(power);
  scopy.set(saPos);
  aimCopy.set(aim);
  point.set(aimCopy.sub(scopy));
  point.setMag(width/9);
  scopy.set(saPos);
  point.add(scopy);
  vel.limit(s/5);
}

void desenha() {
  ///smashs
  image(smash, smashx, smashy, twoS, twoS);
  image(smashA, smashAx, smashAy, twoD, twoD);
  image(smashB, smashBx, smashBy, hs, hs);
  ///enimigos
  for (int i=0; i<bixoUmQuantidade; i++) {
    bixo[i].toque();
    bixo[i].subir();
    bixo[i].desenha();
  }
  for (int i=0; i<bixoDoisQuantidade; i++) {
    bixoA[i].toque();
    bixoA[i].subir();
    bixoA[i].desenha();
  }
  for (int i=0; i<bixoTresQuantidade; i++) {
    bixoB[i].toque();
    bixoB[i].subir();
    bixoB[i].desenha();
  }
  for (int i=0; i<bixoQuatroQuantidade; i++) {
    boss[i].toque();
    boss[i].subir();
    boss[i].desenha();
  }
  for (int i=0; i<bixoCincoQuantidade; i++) {
    bixoC[i].toque();
    bixoC[i].subir();
    bixoC[i].desenha();
  }
  image(frog, saPos.x, saPos.y, 1.2*s, 1.6*s);
  image(mira, aim.x, aim.y, s, s);
  image(ammo, ammoSpawn.x, ammoSpawn.y, s, s);
  strokeCap(SQUARE);
  strokeWeight(ss);
  stroke(50);
  line(saPos.x+hs, saPos.y, point.x+hs, point.y);
}
