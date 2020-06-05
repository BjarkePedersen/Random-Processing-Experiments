void importData() {

  String[] inputFile = loadStrings("Input File.txt");  // From input file -> find file to open 
  
  // Make sure there is something to import
  Integer num = 0;
  try {
    num = Integer.valueOf(inputFile[1]);
  } catch (Exception e) {}
  
  delay(10);
  if (num==0) {println("---No data to import---");} 
  
  else {
    num = num+2;  // Look from third line
    String[] str = loadStrings(inputFile[num]);  // Open specified file from input file
    
    // Padding for edges of imported image
    int edg = 50;
    
    println("Loading: ", inputFile[(num)]);
    // Get resolution of image, for initialization of empty int[][]
    int x = str.length;
    String[] ytemp = split(str[0], ',');
    int y = ytemp.length;
    int[][] data = new int[x][y];
    
    // Change window size according to size of impported file
    size = max(x,y)+edg;  // Set size to largest of either x or y image resolution
    scale = floor(1080/size*1.4);
    if (size<200) {size = 200;}
    if (scale>4) {scale = 4;}
    
    img = new int[size][size];
    result = new int[size][size];

    // Process string data
    for (int i=0; i<str.length; i++) {
      String[] strList = split(str[i], ',');  // Split data for each comma

      for (int f=0; f<strList.length; f++) {
        String val = strList[f];
        val = val.replace("]", "");  // Remove "[" and "]" from string
        val = val.replace("[", "");

        Float valF = Float.valueOf(val);  // Convert string to float

        data[i][f]= floor(valF);  // Add data to int[][]
      }
    }
    allowNoise = false;
    for (int i=0; i<x; i++) {
      for (int f=0; f<y; f++) {
        img[i+edg/2][f+edg/2] = data[i][f];
      }
    }
  }
}