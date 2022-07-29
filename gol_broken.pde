PGraphics pg;

int SIZE = 10;
int GRID_X = 100;
int GRID_Y = 100;
int SEED = 0;
float THRESH = .1;

ArrayList<Cell> cells = new ArrayList<>();

class Cell {
  int x, y;
  boolean is_dead = true;
  boolean next_gen_state = true;
  
  Cell(int x, int y) {
    this.x = x;
    this.y = y;
  }

  int surrounding () {
    // d !e f
    int index = this.x + GRID_Y * this.y;
    int next  = index + 1;
    int prev  = index - 1;
    
    // a b c
    int index_top = this.x + GRID_Y * (this.y-1);
    int next_top  = index_top + 1;
    int prev_top  = index_top - 1;
    
    // g h i
    int index_bottom = this.x + GRID_Y * (this.y+1);
    int next_bottom  = index_bottom + 1;
    int prev_bottom  = index_bottom - 1;
    
    int[] arr = {next, prev, index_top, next_top, prev_top, index_bottom, next_bottom, prev_bottom};
    return check(arr);
  }

  void live() {
    int neighbours = this.surrounding();
    
    if (neighbours < 2) {
      this.next_gen_state = true;
      return;
    }
    
    if (neighbours > 3) {
      this.next_gen_state = true;
      return;  
    }
    
    this.next_gen_state = false;
  }
  
  void next_state() {
    this.is_dead = this.next_gen_state;
  }

}

void initCells() {
  for (int i = 0; i < GRID_X;i++) {
      for (int j = 0; j < GRID_Y;j++) {
        Cell c = new Cell(j, i);
        float rand = random(1);
        
        if (rand < THRESH) c.is_dead = false;
        
        cells.add(c);
      }
  }
}

int check (int []asd) {
  int count = 0;
  for(int i = 0; i < asd.length; i++) {
      if (asd[i] < GRID_X*GRID_Y && asd[i] >= 0) {
        Cell c = cells.get(asd[i]);
        if (!c.is_dead) count++;
      }
  }
  
  
  return count;
}

void settings() {
  size(GRID_X*SIZE, GRID_Y*SIZE, P2D);

}

void setup() {
  randomSeed(SEED);
  frameRate(1);
  noStroke();
  
  // -----------
  initCells();
  
  //// tmp
  //int a = 1;
  //Cell c = cells.get(a);
  
  //c.is_dead=false;;
  
  //cells.set(a, c);
  
}

void draw() {

  background(0);
  for (Cell c: cells) {
    fill(c.is_dead?0:255);
    rect(c.x * SIZE, c.y*SIZE, SIZE, SIZE);
    c.live();
  };
  
  for (Cell c: cells) {
    c.next_state();
  }
  //for (int i = 0; i < GRID_X;i++) {
  //  for (int j = 0; j < GRID_Y;j++) {
  //      fill(random(i*j));
  //      rect(i * SIZE, j*SIZE, SIZE, SIZE);
  //  }
  //}
}
