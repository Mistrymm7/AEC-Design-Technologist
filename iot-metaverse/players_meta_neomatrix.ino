// This #include statement was automatically added by the Particle IDE.
#include <neomatrix.h>

/*-------------------------------------------------------------------------
  Spark Core library to control WS2811/WS2812 based RGB
  LED devices such as Adafruit NeoPixel strips and matrices.
  Currently handles 800 KHz and 400kHz bitstream on Spark Core,
  WS2812, WS2812B and WS2811.

  Also supports Radio Shack Tri-Color Strip with TM1803 controller
  400kHz bitstream.

  PLEASE NOTE that the NeoPixels require 5V level inputs
  and the Spark Core only has 3.3V level outputs. Level shifting is
  necessary, but will require a fast device such as one of the following:

  [SN74HCT125N]
  http://www.digikey.com/product-detail/en/SN74HCT125N/296-8386-5-ND/376860

  [SN74HCT245N]
  http://www.digikey.com/product-detail/en/SN74HCT245N/296-1612-5-ND/277258

  [TXB0108PWR]
  http://www.digikey.com/product-search/en?pv7=2&k=TXB0108PWR

  If you have a Spark Shield Shield, the TXB0108PWR 3.3V to 5V level
  shifter is built in.

  Written by Phil Burgess / Paint Your Dragon for Adafruit Industries.
  Modified to work with Spark Core by Technobly.
  Modified for use with Matrices by delianides.
  Contributions by PJRC and other members of the open source community.

  Adafruit invests time and resources providing this open source code,
  please support Adafruit and open-source hardware by purchasing products
  from Adafruit!
  --------------------------------------------------------------------*/

#include "Particle.h"


// IMPORTANT: Set pixel PIN and TYPE
#define PIXEL_PIN D2
#define PIXEL_TYPE WS2812B

// MATRIX DECLARATION:
// Parameter 1 = width of EACH NEOPIXEL MATRIX (not total display)
// Parameter 2 = height of each matrix
// Parameter 3 = number of matrices arranged horizontally
// Parameter 4 = number of matrices arranged vertically
// Parameter 5 = pin number (most are valid)
// Parameter 6 = matrix layout flags, add together as needed:
//   NEO_MATRIX_TOP, NEO_MATRIX_BOTTOM, NEO_MATRIX_LEFT, NEO_MATRIX_RIGHT:
//     Position of the FIRST LED in the FIRST MATRIX; pick two, e.g.
//     NEO_MATRIX_TOP + NEO_MATRIX_LEFT for the top-left corner.
//   NEO_MATRIX_ROWS, NEO_MATRIX_COLUMNS: LEDs WITHIN EACH MATRIX are
//     arranged in horizontal rows or in vertical columns, respectively;
//     pick one or the other.
//   NEO_MATRIX_PROGRESSIVE, NEO_MATRIX_ZIGZAG: all rows/columns WITHIN
//     EACH MATRIX proceed in the same order, or alternate lines reverse
//     direction; pick one.
//   NEO_TILE_TOP, NEO_TILE_BOTTOM, NEO_TILE_LEFT, NEO_TILE_RIGHT:
//     Position of the FIRST MATRIX (tile) in the OVERALL DISPLAY; pick
//     two, e.g. NEO_TILE_TOP + NEO_TILE_LEFT for the top-left corner.
//   NEO_TILE_ROWS, NEO_TILE_COLUMNS: the matrices in the OVERALL DISPLAY
//     are arranged in horizontal rows or in vertical columns, respectively;
//     pick one or the other.
//   NEO_TILE_PROGRESSIVE, NEO_TILE_ZIGZAG: the ROWS/COLUMS OF MATRICES
//     (tiles) in the OVERALL DISPLAY proceed in the same order for every
//     line, or alternate lines reverse direction; pick one.  When using
//     zig-zag order, the orientation of the matrices in alternate rows
//     will be rotated 180 degrees (this is normal -- simplifies wiring).
//   See example below for these values in action.
// Parameter 7 = pixel type flags, add together as needed:
//   NEO_RGB     Pixels are wired for RGB bitstream (v1 pixels)
//   NEO_GRB     Pixels are wired for GRB bitstream (v2 pixels)
//   NEO_KHZ400  400 KHz bitstream (e.g. FLORA v1 pixels)
//   NEO_KHZ800  800 KHz bitstream (e.g. High Density LED strip)
//   For Spark Core developement it should probably also be WS2812B if you're
//   using adafruit neopixels.

// Example with three 10x8 matrices (created using NeoPixel flex strip --
// these grids are not a ready-made product).  In this application we'd
// like to arrange the three matrices side-by-side in a wide display.
// The first matrix (tile) will be at the left, and the first pixel within
// that matrix is at the top left.  The matrices use zig-zag line ordering.
// There's only one row here, so it doesn't matter if we declare it in row
// or column order.  The matrices use 800 KHz (v2) pixels that expect GRB
// color data.

Adafruit_NeoMatrix matrix = Adafruit_NeoMatrix(8,8,4,1, PIXEL_PIN,
  NEO_TILE_TOP   + NEO_TILE_LEFT   + NEO_TILE_ROWS   + NEO_TILE_PROGRESSIVE +
  NEO_MATRIX_TOP + NEO_MATRIX_LEFT + NEO_MATRIX_ROWS + NEO_MATRIX_PROGRESSIVE,
  PIXEL_TYPE);

const uint16_t colors[] = {
  matrix.Color(255, 0, 0), matrix.Color(0, 255, 0), matrix.Color(0, 0, 255) };

int matrix_unit = 8;

int x    = matrix.width();
int pass = 0;
//int cellHistory[64];

void setup() {
  matrix.begin();
  matrix.setTextWrap(false);
  matrix.setBrightness(30);
  matrix.setTextColor(matrix.Color(80,255,0));
  Serial.begin(115200);
    
  
  /*
  for(int i = 0; i < sizeof(cellHistory); ++i){
      cellHistory[i] = 0;
      Serial.printf( "Matrix Initiation is is %d", i);
    }
  */
  
  Particle.function("shopKeepershow", shopKeepershow);
  Particle.function("playersUpdate_data", playersUpdate_data);
  //Particle.function("cellcurrentHisory", cellcurrentHisory);
  
  
}



int shopKeepershow (String xx){
    Serial.printf( "Shoopkeerper fn called");
    int grid_no = xx.toInt();
    
    int x_id = grid_no % matrix_unit;
    int y_id = grid_no / matrix_unit;
    
    matrix.fillScreen(0);
    matrix.drawPixel(x_id, y_id, matrix.Color(255, 0, 0));
    matrix.show();
    
    return 1;
}

int playersUpdate_data (String mm){
    Serial.printf( "Players Update fn called");
    
    matrix.fillScreen(0);
   
   char buffer[mm.length() + 1];

   mm.toCharArray(buffer, mm.length() + 1);

    
    const char s2[2] = ",";

    
    char *token2;
    char *id;
    char *cell;
    char *intensity;
    
    
   token2 = strtok(buffer, s2);
   
   while( token2 != NULL ) {
       
      id = token2;
      cell = strtok(NULL, s2);
      intensity = strtok(NULL, s2);

      token2 = strtok(NULL, s2);
      
      int grid_num = atoi(cell);
      //cellHistory[grid_num] = cellHistory[grid_num] + 1; 
      //Serial.printf( "Cell Hisotry of grid num is %d", grid_num);
      

      int x_id = grid_num % matrix_unit;
      int y_id = grid_num / matrix_unit;
      
      int brightness = atoi(intensity);

      matrix.drawPixel(x_id, y_id, matrix.Color(brightness, brightness, brightness));
      matrix.show();

   }
   
    return 1;
}

/*
int cellcurrentHisory (String grid){
    Serial.printf( "Cell History fn called");
    
    int gridzz = grid.toInt();
    
    return cellHistory[gridzz];
    
}
*/

void loop() {
  
  /*
  matrix.fillScreen(0);
  matrix.setCursor(x, 0);
  matrix.print(F("Howdy"));
  if(--x < -36) {
    x = matrix.width();
    if(++pass >= 3) pass = 0;
    matrix.setTextColor(colors[pass]);
  }
  matrix.show();
  delay(100);
  */
  
}
