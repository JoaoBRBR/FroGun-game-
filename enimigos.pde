/////////////enemy
class bixo {
  float x;
  float y;
  float v;
  int estadoDeVida;
  ////construtor
  bixo() {
    v=1;//random(1, 3);
    x=random(d, width-d);
    y=random(height, height+width);
    estadoDeVida=0;
  }
  ////funcoes
  void subir() {
    if (faseKey==true) { ////fica true aqui?
      estadoDeVida=0;
    }
    if (estadoDeVida==0) {
      y-=(v*delta);
    } else if (estadoDeVida==1) {
      v=1;//random(1, 3);
      x=random(d, width-d);
      y=random(height, height+width);
      estadoDeVida=2;
    }
  }
  void toque() {
    if (mousePressed && dist(mouseX, mouseY, x, y)<s && chave>0) {
      faseObjetivo--;
      smashx=x;
      smashy=y;
      estadoDeVida=1;
    }
    if (y<d) {
      hurt.play();
      faseObjetivo--;
      estadoDeVida=1;
      vida--;
    }
  }
  void desenha() {
    if (estadoDeVida==0) {
      image(enemy, x, y, s, d);
    }
  }
  void reset() {
    v=1; //random(1, 3);
    x=random(d, width-d);
    y=random(height, height+width);
    estadoDeVida=0;
  }
}


/////////////jenemy

class bixoA {
  float x;
  float y;
  float v;
  int estadoDeVida;
  ////construtor
  bixoA() {
    v=random(-4, 4);
    x=random(d, width-d);
    y=random(height, height+width);
    estadoDeVida=0;
  }
  ////funcoes
  void subir() {
    if (faseKey==true) { ////fica true aqui?
      estadoDeVida=0;
    }
    if (estadoDeVida==0) {
      y-=(2*delta);
      x+=(v*delta);
    } else if (estadoDeVida==1) {
      v=random(-4, 4);
      x=random(d, width-d);
      y=random(height, height+width);
      estadoDeVida=2;
    }
  }
  void toque() {
    if (mousePressed && dist(mouseX, mouseY, x, y)<twoS && chave>0) {
      faseObjetivo--;
      smashBx=x;
      smashBy=y;
      estadoDeVida=1;
    }
    if (y<d) {
      hurt.play();
      faseObjetivo--;
      estadoDeVida=1;
      vida--;
    }
    if (x>width || x<0) {
      v=v*-1;
    }
  }
  void desenha() {
    if (estadoDeVida==0) {
      image(jelly, x, y, s, d);
    }
  }
  void reset() {
    v=random(-4, 4);
    x=random(d, width-d);
    y=random(height, height+width);
    estadoDeVida=0;
  }
}


/////////////Benemy

class bixoB {
  float x;
  float y;
  float v;
  int vidas;
  int estadoDeVida;
  boolean trava;
  ////construtor
  bixoB() {
    v=1.5;//random(1,1.5);
    x=random(d, width-d);
    y=random(height, height+width);
    estadoDeVida=0;
    vidas=30;
    trava=true;
  }
  ////funcoes
  void subir() {
    if (faseKey==true) {
      estadoDeVida=0;
    }
    if (estadoDeVida==0) {
      y-=(v*delta);
    } else if (estadoDeVida==1) {
      v=1.5;//random(1,1.5);
      x=random(d, width-d);
      y=random(height, height+width);
      estadoDeVida=2;
      vidas=30;//int(random(10,15));
    }
  }
  void toque() {
    if (mousePressed && trava==true) {
      trava=false;
      if (dist(mouseX, mouseY, x, y)<twoD && chave>0  && vidas<1) {
        faseObjetivo--;
        smashAx=x;
        smashAy=y;
        estadoDeVida=1;
        trava=false;
      }
      if (dist(mouseX, mouseY, x, y)<twoD && chave>0 && vidas>=1) {
        vidas--;
      }
    }else{
     trava=true; 
    }

    if (y<d) {
      hurt.play();
      faseObjetivo--;
      estadoDeVida=1;
      vida--;
    }
  }
  void desenha() {
    if (estadoDeVida==0) {
      image(benemy, x, y, twoD, twoD);
    }
  }
  void reset() {
    v=1.5;//random(1,1.5);
    x=random(d, width-d);
    y=random(height, height+width);
    estadoDeVida=0;
    vidas=30;//int(random(10,15));
  }
}



/////////////Boss

class boss {
  float x;
  float y;
  float v;
  int vidas;
  int estadoDeVida;
  boolean trava;
  ////construtor
  boss() {
    v=1;//random(0.5, 1);
    x=random(twoD, width-twoD);
    y=random(height, height+width);
    estadoDeVida=0;
    vidas=80;//int(random(20, 30));
    trava=true;
  }
  ////funcoes
  void subir() {
    if (faseKey==true) {
      estadoDeVida=0;
    }
    if (estadoDeVida==0) {
      y-=(v*delta);
    } else if (estadoDeVida==1) {
      v=1;//random(0.5, 1);
      x=random(twoD, width-twoD);
      y=random(height, height+width);
      estadoDeVida=2;
      vidas=80;//int(random(20, 30));
    }
  }
  void toque() {
    if (mousePressed && trava==true) {
      trava=false;
      if (dist(mouseX, mouseY, x, y)<2*twoS && chave>0  && vidas<1) {
        faseObjetivo--;
        smashAx=x;
        smashAy=y;
        estadoDeVida=1;
        trava=false;
      }
      if (dist(mouseX, mouseY, x, y)<2*twoS && chave>0 && vidas>=1) {
        vidas--;
      }
    }else{
     trava=true; 
    }

    if (y<d) {
      hurt.play();
      faseObjetivo--;
      estadoDeVida=1;
      vida--;
    }
  }
  void desenha() {
    if (estadoDeVida==0) {
      image(boos, x, y, 2*twoD, 2*twoD);
    }
  }
  void reset() {
    v=1;//random(0.5, 1);
    x=random(twoD, width-twoD);
    y=random(height, height+width);
    estadoDeVida=0;
    vidas=80;//int(random(20, 30));
  }
}

/////////////jely

class bixoC {
  float x;
  float y;
  float v;
  int estadoDeVida;
  ////construtor
  bixoC() {
    v=random(-7, 7);
    x=random(d, width-d);
    y=random(height, height+width);
    estadoDeVida=0;
  }
  ////funcoes
  void subir() {
    if (faseKey==true) { ////fica true aqui?
      estadoDeVida=0;
    }
    if (estadoDeVida==0) {
      y-=(3*delta);
      x+=(v*delta);
    } else if (estadoDeVida==1) {
      v=random(-7, 7);
      x=random(d, width-d);
      y=random(height, height+width);
      estadoDeVida=2;
    }
  }
  void toque() {
    if (mousePressed && dist(mouseX, mouseY, x, y)<twoS && chave>0) {
      faseObjetivo--;
      smashAx=x;
      smashAy=y;
      estadoDeVida=1;
    }
    if (y<d) {
      hurt.play();
      faseObjetivo--;
      estadoDeVida=1;
      vida--;
    }
    if (x>width || x<0) {
      v=v*-1;
    }
  }
  void desenha() {
    if (estadoDeVida==0) {
      image(jenemy, x, y, s, s);
    }
  }
  void reset() {
    v=random(-7, 7);
    x=random(d, width-d);
    y=random(height, height+width);
    estadoDeVida=0;
  }
}
