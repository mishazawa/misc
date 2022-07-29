int SIZE = 10;
int GRID_X = 100;
int GRID_Y = 100;
int SEED = 10;
float THRESH = .5;


int[] field = new int[GRID_X*GRID_Y];

void initCells() {
  for (int i = 0; i < field.length; i++) {
    if (random(1) < THRESH) field[i] = 1;
  }
}

int check_valid_cell (int x, int y) {
  if (x < 0 || x > GRID_X) return -1; 
  if (y < 0 || y > GRID_Y) return -1; 
  return x + GRID_X * y;
}

int[] indicies (int index) {
      int x = index % GRID_X;
      int y = index / GRID_X;
      
      int next         = check_valid_cell(x+1, y);
      int prev         = check_valid_cell(x-1, y);
      int top          = check_valid_cell(x, y-1);
      int bottom       = check_valid_cell(x, y+1);
      int next_top     = check_valid_cell(x+1, y-1);
      int prev_top     = check_valid_cell(x-1, y-1);
      int next_bottom  = check_valid_cell(x+1, y+1);
      int prev_bottom  = check_valid_cell(x-1, y+1);

      int[] arr_indx = {next, prev, top, next_top, prev_top, bottom, next_bottom, prev_bottom};
      
      return arr_indx;
}

void next_gen () {
    int[] newgen = new int[GRID_X*GRID_Y];
    for (int i = 0; i < field.length; i++) {
        int count = 0;
        
        for (int j: indicies(i)) {
          if (j != -1 && j < field.length) count += field[j];
        }
        
        int val = 0;
        
        if (field[i] == 1) {
          if (count == 2 || count == 3) val = 1;
        } else {
          if (count == 3) val = 1;        
        }
        
        newgen[i] = val;
    }
    
    
    field = newgen;
}

void settings() {
  size(GRID_X*SIZE, GRID_Y*SIZE, P2D);

}

void setup() {
  //randomSeed(SEED);
  frameRate(15);
  noStroke();
  initCells(); 
}

void draw() {
  background(0);
  for (int i = 0; i < field.length; i++) {
    if (field[i]==1) {
      fill(255);
      int x = i % GRID_X;
      int y = i / GRID_X;
      rect(x * SIZE, y*SIZE, SIZE, SIZE);
    }
  }
  
  next_gen();
   

  //for (int i = 0; i < GRID_X;i++) {
  //  for (int j = 0; j < GRID_Y;j++) {
  //      fill(random(i*j));
  //      rect(i * SIZE, j*SIZE, SIZE, SIZE);
  //  }
  //}
}
