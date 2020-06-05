import java.util.Collections;

Network AI1, AI2; 

float weightMutationScale = 10;
int weightMutationCount = 30;

float biasMutationScale = 10;
int biasMutationCount = 30;

void initializeAI() {

  {
    float[] input = new float[GW*GH*2];
    //float[] l1 = new float[(GW*GH+7)/2];
    float[] l1 = new float[GH*GH];
    float[] l2 = new float[GH*GH];
    float[] l3 = new float[8*8];
    //float[] l4 = new float[floor(GW*GH * 0.4)];
    float[] output = new float[7];

    ArrayList<float[]> network = new ArrayList<float[]>();
    network.add(input);
    network.add(l1);
    network.add(l2);
    //network.add(l3);
    ////network.add(l4);
    network.add(output);
    AI1 = new Network(network, p1);
    AI2 = new Network(network, p2);
  }
}
public class Network {
  float[][] neurons;
  float[][] bias;
  float[][][] weights;
  float[][][] connections;
  int weightsCountSum;
  int[] weightsCount;
  Player player;

  public Network(ArrayList<float[]> count, Player player) {
    this.player = player;
    neurons = new float[count.size()][];
    bias = new float[count.size()][];
    weights = new float[count.size()][][];
    connections = new float[count.size()][][];
    for (int i=0; i<count.size(); i++) {
      neurons[i] = new float[count.get(i).length];
      bias[i] = new float[count.get(i).length];
      weights[i] = new float[count.get(i).length][];
      connections[i] = new float[count.get(i).length][];

      for (int j=0; j<weights[i].length; j++) {
        weights[i][j] = i > 0 ?
          new float[weights[i-1].length] :
          new float[0];
        connections[i][j] = i > 0 ?
          new float[connections[i-1].length] :
          new float[0];
      }
    }

    weightsCountSum = 0;
    weightsCount = new int[weights.length];
    for (int i=0; i<weights.length; i++) {
      for (int j=0; j<weights[i].length; j++) {
        for (int k=0; k<weights[i][j].length; k++) {
          weightsCountSum ++;
          weightsCount[i] ++;
          //if (weights[i][j].length > 0) weights[i][j][k] = random(-1, 1);
          if (weights[i][j].length > 0) weights[i][j][k] = 0;
        }
        //bias[i][j] = random(-1, 1);
        bias[i][j] = 0;
      }
    }
  }

  void mutate() {
    for (int i=0; i<weightMutationCount; i++) {
      float j = random(0, weightsCountSum);
      int layer = 1;
      int j2 = 0;
      // Distribute with respect to amount of weights in each layer, to get equal distribution of mutations.
      for (int x=1; x<weightsCount.length; x++) {
        j2 += weightsCount[x];
        if (j > j2) layer = x+1;
      }
      int k = floor(random(0, weights[layer].length));
      int l = floor(random(0, weights[layer][k].length));
      weights[layer][k][l] += random(-1, 1) * weightMutationScale;
    }

    for (int i=0; i<biasMutationCount; i++) {
      int j = floor(random(1, bias.length));
      int k = floor(random(0, bias[j].length));
      bias[j][k] += random(-1, 1) * biasMutationScale;
    }
  }

  void think() {
    getInput();

    for (int i=1; i<neurons.length; i++) {
      for (int j=0; j<neurons[i].length; j++) {
        neurons[i][j]=0;
        for (int k=0; k<weights[i][j].length; k++) {
          connections[i][j][k] = neurons[i-1][k] * weights[i][j][k];
          neurons[i][j] += connections[i][j][k] / 1000;
        }
        neurons[i][j] += bias[i][j] / 1000;
        // Activation
        float val = neurons[i][j];
        if (val > 10) neurons[i][j] = 10;
        if (val < -10) neurons[i][j] = -10;
        //val = (1-pow(2.718, -val)) / (1+pow(2.718, -val));
        val = 1 / (1+pow(2.718, -val));
      }
    }
  }

  void getInput() {
    int c = 0;
    int x = 0;
    int y = 0;
    for (int i=0; i<GH; i++) {
      for (int j=0; j<GW; j++) {
        x = GW - j -1;
        y = i;
        //neurons[0][c] = !drawGrid[x][y] ? 0 : player.grid[x][y] ? 1 : -1;
        neurons[0][c] = !drawGrid[x][y] ? 0 : 1;
        c++;
      }
    }
    c = 0;
    x = 0;
    y = 0;
    for (int i=0; i<GH; i++) {
      for (int j=0; j<GW; j++) {
        x = GW - j -1;
        y = i;
        neurons[0][c+GW*GH] = !drawGrid[x][y] ? 0 : 1;
        c++;
      }
    }
  }

  float[] getOutput() {
    int i = neurons.length-1;
    float[] out = new float[neurons[i].length];
    for (int j=0; j<neurons[i].length; j++) {
      out[j] = neurons[i][j];
    }
    return out;
  }
}

int getChoice(float[] list) {
  int index = 0;
  float min = -9999;

  for (int i=0; i<list.length; i++) {
    if (list[i] > min) {
      index = i;
      min = list[i];
    }
  }
  return index;
}
