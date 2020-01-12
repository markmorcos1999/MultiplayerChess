// Server

//UPPERCASE = WHTE
//lowercase = black
// I did the moves by sending the coordinates of the move to the other server/client 
// and moving the corresponding pieces to where the mouse clicks
import processing.net.*;
String outgoingdata=""; 
String incomingdata="";
boolean pawnrespawn1 = false;
boolean ipawnrespawn1 = false;
boolean pawnrespawn2 = false;
boolean ipawnrespawn2=false;
int imouserownumber2=0;
int imousecolumnnumber2=0;
int imouserownumber=0;
int imousecolumnnumber=0;
char pawnrespawn;
int click = 0;
int undo = 0;
PImage R;
PImage B;
PImage N;
PImage Q;
PImage K;
PImage P;


PImage r;
PImage b;
PImage n;
PImage q;
PImage k;
PImage p;
ArrayList characterbeforeundos, undo1s;
int row =0, column=0, mapratio=76, mousecolumnnumber = 0, mouserownumber = 0, mousecolumnnumber2 = 0, mouserownumber2 = 0;
char characterbeforeundo;
char undo1, undo2;
char [][] board = {{'R', 'N', 'B', 'K', 'Q', 'B', 'N', 'R', 'U'}, //ROW0
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'}, //ROW1
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, //ROW2
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, //ROW3
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, //ROW4
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, //ROW5
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'}, //ROW6
  {'r', 'n', 'b', 'k', 'q', 'b', 'n', 'r'}, //ROW7
};

Server s;

PImage BOARD;
void setup() {
  R = loadImage("whiterook.png");
  B = loadImage("whitebishop.png");
  N = loadImage("whiteknight.png");
  Q = loadImage("whitequeen.png");
  K = loadImage("whiteking.png");
  P = loadImage("whitepawn.png");


  r = loadImage("blackrook.png");
  b = loadImage("blackbishop.png");
  n = loadImage("blackknight.png");
  q = loadImage("blackqueen.png");
  k = loadImage("blackking.png");
  p = loadImage("blackpawn.png");


  BOARD = loadImage("board.png");
  size(600, 600);
  s = new Server(this, 1234);
}
void draw() {

  image(BOARD, 0, 0);
  row=0;
  column=0;
  while (row<=7) {
    if (board[row][column]=='P') {
      image(P, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='R') {
      image(R, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='N') {
      image(N, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='B') {
      image(B, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='K') {
      image(K, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='Q') {
      image(Q, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='p') {
      image(p, column*mapratio, row*mapratio);
    }
    //
    if (board[row][column]=='r') {
      image(r, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='n') {
      image(n, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='b') {
      image(b, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='k') {
      image(k, column*mapratio, row*mapratio);
    }
    if (board[row][column]=='q') {
      image(q, column*mapratio, row*mapratio);
    }
    if (pawnrespawn1) {
      fill(0, 255, 0);
      rect(150, 225, 300, 75);
      image(r, 155, 230);
      image(n, 230, 230);
      image(b, 305, 230);
      image(q, 380, 230);
    }
    if (pawnrespawn2) {
      fill(0, 255, 0);
      rect(150, 225, 300, 75);
      image(R, 155, 230);
      image(N, 230, 230);
      image(B, 305, 230);
      image(Q, 380, 230);
    }
    column++;
    if (column==8) {
      column=0;
      row++;
    }
  }
  //  if (mousePressed && mouseX>=601&&mouseY<=100&&frameCount%4==0) {
  //    undo = 1;
  //  }
  Client c = s.available();
  if (c!=null) {
    incomingdata=c.readString();
    println(incomingdata);
    String[] coordinates=incomingdata.split(",");
    pawnrespawn = coordinates[0].charAt(0);
    imouserownumber2=int(coordinates[1]);
    imousecolumnnumber2=int(coordinates[2]);
    imouserownumber=int(coordinates[3]);
    imousecolumnnumber=int(coordinates[4]);
    //    if (board[imouserownumber][imousecolumnnumber]!=' ') {
    if (board[imouserownumber2][imousecolumnnumber2] != board[imouserownumber][imousecolumnnumber]
      ) {
      characterbeforeundo=board[imouserownumber2][imousecolumnnumber2];
      //      characterbeforeundos[0]=characterbeforeundo;
      board[imouserownumber2][imousecolumnnumber2] = board[imouserownumber][imousecolumnnumber];
      board[imouserownumber][imousecolumnnumber] = ' ';
      if (pawnrespawn=='s') {
        ipawnrespawn1= true;
        println(pawnrespawn);
      }
      if (pawnrespawn=='d') {
        ipawnrespawn2= true;
        println(pawnrespawn);
      }
      //        if (undo==1) {
      //          board[imouserownumber][imousecolumnnumber] =board[imouserownumber2][imousecolumnnumber2];
      //         board[imouserownumber2][imousecolumnnumber2]=characterbeforeundo;
      //         undo=0;
      //       }
      //     } else {
      //        board[imouserownumber2][imousecolumnnumber2] = board[imouserownumber][imousecolumnnumber];
      //      }
      if (ipawnrespawn1) {
        if (imousecolumnnumber==2&&imouserownumber==3) {
          board[imouserownumber2][imousecolumnnumber2]='r';
        }
        if (imousecolumnnumber==3&&imouserownumber==3) {
          board[imouserownumber2][imousecolumnnumber2]='n';
        }
        if (imousecolumnnumber==4&&imouserownumber==3) {
          board[imouserownumber2][imousecolumnnumber2]='b';
        }
        if (imousecolumnnumber==5&&imouserownumber==3) {
          board[imouserownumber2][imousecolumnnumber2]='q';
        }
        click=0;
        ipawnrespawn1=false;
      }
      if (ipawnrespawn2) {
        if (imousecolumnnumber==2&&imouserownumber==3) {
          board[imouserownumber2][imousecolumnnumber2]='R';
        }
        if (imousecolumnnumber==3&&imouserownumber==3) {
          board[imouserownumber2][imousecolumnnumber2]='N';
        }
        if (imousecolumnnumber==4&&imouserownumber==3) {
          board[imouserownumber2][imousecolumnnumber2]='B';
        }
        if (imousecolumnnumber==5&&imouserownumber==3) {
          board[imouserownumber2][imousecolumnnumber2]='Q';
        }
        click=0;
        ipawnrespawn2=false;
        println(imousecolumnnumber, imouserownumber);
      }
    }
    //    }
  }
}
void mousePressed() {
  if (click%2==0) {
    mousecolumnnumber=mouseX/75;
    mouserownumber=mouseY/75; 
    if (pawnrespawn1) {
      if (mousecolumnnumber==2&&mouserownumber==3) {
        board[mouserownumber2][mousecolumnnumber2]='r';
      }
      if (mousecolumnnumber==3&&mouserownumber==3) {
        board[mouserownumber2][mousecolumnnumber2]='n';
      }
      if (mousecolumnnumber==4&&mouserownumber==3) {
        board[mouserownumber2][mousecolumnnumber2]='b';
      }
      if (mousecolumnnumber==5&&mouserownumber==3) {
        board[mouserownumber2][mousecolumnnumber2]='q';
      }
      //      mouserownumber=0;
      //      mousecolumnnumber=0;
      outgoingdata='s'+","+mouserownumber2+","+mousecolumnnumber2+","+mouserownumber+","+mousecolumnnumber+",";
      s.write(outgoingdata);
      click=1;
      pawnrespawn1=false;
    }
    if (pawnrespawn2) {
      if (mousecolumnnumber==2&&mouserownumber==3) {
        board[mouserownumber2][mousecolumnnumber2]='R';
      }
      if (mousecolumnnumber==3&&mouserownumber==3) {
        board[mouserownumber2][mousecolumnnumber2]='N';
      }
      if (mousecolumnnumber==4&&mouserownumber==3) {
        board[mouserownumber2][mousecolumnnumber2]='B';
      }
      if (mousecolumnnumber==5&&mouserownumber==3) {
        board[mouserownumber2][mousecolumnnumber2]='Q';
      }
      click=1;
      outgoingdata='d'+","+mouserownumber2+","+mousecolumnnumber2+","+mouserownumber+","+mousecolumnnumber+",";
      s.write(outgoingdata);
      pawnrespawn2=false;
    }
  } else {
    mousecolumnnumber2=mouseX/75;
    mouserownumber2=mouseY/75;
    if (board[mouserownumber][mousecolumnnumber]!=' '||board[mouserownumber][mousecolumnnumber]!='U') {
      if (board[mouserownumber2][mousecolumnnumber2] != board[mouserownumber][mousecolumnnumber]
        ) {
        if (board[mouserownumber][mousecolumnnumber] !='U') {
          undo2=board[mouserownumber2][mousecolumnnumber2];
          characterbeforeundo=board[mouserownumber2][mousecolumnnumber2];
          undo1=board[mouserownumber][mousecolumnnumber];                    /// HHHERRREEEEEEE
        }
        board[mouserownumber2][mousecolumnnumber2] = board[mouserownumber][mousecolumnnumber];
        board[mouserownumber][mousecolumnnumber] = ' ';
        //        println(characterbeforeundo);
        if (board[7][0]=='P'||board[7][1]=='P'||board[7][2]=='P'||board[7][3]=='P'||board[7][4]=='P'||board[7][5]=='P'||board[7][6]=='P'
          ||board[7][7]=='P') {
          pawnrespawn2= true;
        }
        if (board[0][0]=='p'||board[0][1]=='p'||board[0][2]=='p'||board[0][3]=='p'||board[0][4]=='p'||board[0][5]=='p'||board[0][6]=='p'
          ||board[0][7]=='p') {
          pawnrespawn1= true;
        }
      } else {
        board[mouserownumber2][mousecolumnnumber2] = board[mouserownumber][mousecolumnnumber];
      }
    }
    outgoingdata=board[mouserownumber][mousecolumnnumber]+","+mouserownumber2+","+mousecolumnnumber2+","+mouserownumber+","+mousecolumnnumber+",";
    s.write(outgoingdata);
  }
  if (board[mouserownumber][mousecolumnnumber]=='U') {     //here
    undo=2;
  }
  //  println(undo);
  if (undo==2) {
    //    undo1 = undo2;
    board[mouserownumber2][mousecolumnnumber2]=characterbeforeundo;
    board[mouserownumber][mousecolumnnumber] =undo2;
    println(mouserownumber, mousecolumnnumber+"here");
    //    println(board[mouserownumber2][mousecolumnnumber2]);
    //    println(board[mouserownumber2][mousecolumnnumber2]);
    //    println(characterbeforeundo+"here");
    undo=0;
  }
  click++;
  //  characterbeforeundo=' ';
}