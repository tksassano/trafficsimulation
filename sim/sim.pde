void setup(){
  
}


int numRows = 16;
int numCols = 10;


int[][] array = new int[numRows][numCols];

// populate the map with zeros and ones
for (int i = 0; i < numRows; i++) {
  for (int j = 0; j < numCols; j++) {
    // randomly assign a value of 0 or 1 to each cell
    array[0][j]= 1;
    array[3][j] = 1;
    array[6][j] = 1;
    array[9][j] = 1;
    array[12][j] = 1;
    array[15][j] = 1;
    array[i][1] =1;
    array[i][4] =1;
    array[i][9] =1;
    
  }
}

for (int i = 0; i < array.length; i++) {
  for (int j = 0; j < array[i].length; j++) {
    print(array[i][j]);
    if(j%numRows ==0){
      println();
    }
  }
}
