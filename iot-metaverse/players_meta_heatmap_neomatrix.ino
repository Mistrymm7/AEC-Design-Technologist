// This #include statement was automatically added by the Particle IDE.
#include <neomatrix.h>

#include "Particle.h"


// IMPORTANT: Set pixel PIN and TYPE
#define PIXEL_PIN D5
#define PIXEL_TYPE WS2812B




Adafruit_NeoMatrix matrix = Adafruit_NeoMatrix(8,8,4,1, PIXEL_PIN,
  NEO_TILE_TOP   + NEO_TILE_LEFT   + NEO_TILE_ROWS   + NEO_TILE_PROGRESSIVE +
  NEO_MATRIX_TOP + NEO_MATRIX_LEFT + NEO_MATRIX_ROWS + NEO_MATRIX_PROGRESSIVE,
  PIXEL_TYPE);

const uint16_t colors[] = {
  matrix.Color(255, 0, 0), matrix.Color(0, 255, 0), matrix.Color(0, 0, 255) };


/* Function prototypes -------------------------------------------------------*/
int tinkerDigitalRead(String pin);
int tinkerDigitalWrite(String command);
int tinkerAnalogRead(String pin);
int tinkerAnalogWrite(String command);






int x    = matrix.width();
int pass = 0;

int matrix_unit = 8;

//int led1 = D0;
int led2 = D7;
int ButtonValue = 0;
int button = D3;
int LED_Light = D4;

int cellHistory[64];


bool lit_state = false;

bool shop_keeper_status = false;

void setup() {
    
    Serial.begin(115200);
    
      //Setup the Tinker application here

    	//Register all the Tinker functions
    //Particle.function("digitalread", tinkerDigitalRead);
    //Particle.function("digitalwrite", tinkerDigitalWrite);
    //Particle.function("analogread", tinkerAnalogRead);
    //Particle.function("analogwrite", tinkerAnalogWrite);
        	
      matrix.begin();
      //matrix.setTextWrap(false);
      
      matrix.setTextWrap(true);
      
      
      matrix.setBrightness(30);
      matrix.setTextColor(matrix.Color(80,255,0));
    
    //Sending voltage to them instead of reading from them
    //pinMode(led1, OUTPUT);
    
    
    pinMode(led2, OUTPUT);
    digitalWrite(led2, LOW);
    
    
    Particle.function("change_lit_state", changeState); 
    
    //Particle.function("current_state", currentState); 
    
    Particle.function("shopkeeperUpdate", shopkeeperUpdate); 
    //Particle.function("playersUpdate", playersUpdate_cells); 
    //Particle.function("playersUpdate_heat", playersUpdate_data); 
    Particle.function("flash_shopkeeper", flash_shopkeeper); 
    Particle.function("cellHistory_val", cellHistory_val); 
    
  
    //Initializing cell history array
    for(uint8_t i = 0; i < sizeof(cellHistory); ++i){
      cellHistory[i] = 0;
    }
    
    //Particle.variable("current_lit_state", lit_state); 
    
    //Button Integration
    pinMode(button, INPUT);
    pinMode(LED_Light, OUTPUT);

}

 //To do 
 // 1. Parse different variables
 //2. Intensity tracker
 //3. Normalize function



int shopkeeperUpdate (String mm){
    
    //uint8_t xx, uint8_t yy
   // shop_keeper_status = !shop_keeper_status;
    
    int grid_no = mm.toInt();
    
    int x_id = grid_no % matrix_unit;
    int y_id = grid_no / matrix_unit;
    
    matrix.fillScreen(0);
    matrix.drawPixel(x_id, y_id, matrix.Color(255, 0, 0));
    matrix.show();
      
   return 1;
}

int playersUpdate_cells (String mm){
    
    matrix.fillScreen(0);
    
    //Serial.println("Testing Players Data");
   
    char buffer[mm.length() + 1];

    mm.toCharArray(buffer, mm.length() + 1);
    
    /*
    Serial.println("Input String");
    Serial.println(mm);
    Serial.println("Initial buffer");
    Serial.println(buffer[1]);
    */
    
   /*
   //Test an example
   char str[80] = "This is - www.tutorialspoint.com - website";
   const char s[2] = "-";
   char *token;
   
   token = strtok(str, s);
   
       while( token != NULL ) {
          Serial.printf( " %s\n", token );
        
          token = strtok(NULL, s);
       }
    */
    
   
   const char s2[2] = ",";
   char *token2;
   
  // Add memory history for heatmap
  //cellstat[65] 
  
  
   token2 = strtok(buffer, s2);
   
       while( token2 != NULL ) {
          Serial.printf( " %s\n", token2 );
        
          token2 = strtok(NULL, s2);
          
          int grid_no = atoi(token2);
    
          int x_id = grid_no % matrix_unit;
          int y_id = grid_no / matrix_unit;
         
         // Updata counter for heat intensity
         //cell_state[s]= countter++
      
          matrix.drawPixel(x_id, y_id, matrix.Color(255, 255, 0));
          matrix.show();
          
          //normaize map function intensity (counter/ mean)
          
          // Neomatrix matrix
       }
   
   //Serial.println("Edit buffer");
   //Serial.println(buffer[1]);

      
   return 1;
}


// Player
int playersUpdate_data (String mm){
    
    matrix.fillScreen(0);
   
   char buffer[mm.length() + 1];

   mm.toCharArray(buffer, mm.length() + 1);
   // char str[80] = "abc;13:200,def;4:100,xxx;3:255,ttt;30:75,";
    
//char str[80] = "abc,13,200,def,4,100,xxx,3,255,ttt,30,75,";
    
    const char s2[2] = ",";

    
    char *token2;
    char *id;
    char *cell;
    char *intensity;
    
    
   token2 = strtok(buffer, s2);
   
   while( token2 != NULL ) {
       
      id = token2;
      Serial.printf( "ID");
      Serial.printf( " %s\n", id );
      
      cell = strtok(NULL, s2);
      Serial.printf( "Cell No");
      Serial.printf( " %s\n", cell );
      
      intensity = strtok(NULL, s2);
      Serial.printf( "Intensity");
      Serial.printf( " %s\n", intensity );
    
      token2 = strtok(NULL, s2);
      
      int grid_no = atoi(cell);
      cellHistory[grid_no] = cellHistory[grid_no] + 1; 
      

      int x_id = grid_no % matrix_unit;
      int y_id = grid_no / matrix_unit;
      
      int brightness = atoi(intensity);

      //cell_state[s]= countter++
  
      matrix.drawPixel(x_id, y_id, matrix.Color(brightness, brightness, brightness));
      matrix.show();
      
      
      //normaize map function intensity (counter/ mean)
      
      // Neomatrix matrix
   }
   
   
   
    
    
    return 1;
}

int cellHistory_val (String num){
    
    int id = num.toInt();
    
    return cellHistory[id];
    
}

/*
int playersUpdate_heatmap (String mm){
    
    //Do not call at start without playerUpdate (max Value =0)
    
    matrix.fillScreen(0);
   
   int maxVal = cellHistory[0];
   
   for (int i = 0; i < (sizeof(cellHistory)); i++) {
      if (cellHistory[i] > maxVal) {
         maxVal = cellHistory[i];
      };
      
    Serial.printf( "Max Value" );
    Serial.printf( " %s\n", maxVal );
    
   for (int i = 0; i < (sizeof(cellHistory)); i++) {
       
      int x_id = i % matrix_unit;
      int y_id = i / matrix_unit;
       
      matrix.drawPixel(x_id, y_id, matrix.Color(((cellHistory[i]*255)/max(maxVal,1)), ((cellHistory[i]*255)/max(maxVal,1)), ((cellHistory[i]*255)/max(maxVal,1))));
      matrix.show();
      
    
   }
    
   
    
   }
    
    
    return 1;
}
*/

int flash_shopkeeper (String xx){
    
    digitalWrite(LED_Light, HIGH);
    delay(500);   
    digitalWrite(LED_Light, LOW);
    delay(500);  
    digitalWrite(LED_Light, HIGH);
    delay(500);  
    digitalWrite(LED_Light, LOW);
    delay(500);  
    digitalWrite(LED_Light, HIGH);
    delay(500);  
    digitalWrite(LED_Light, LOW);
    delay(500);  
    digitalWrite(LED_Light, HIGH);
    delay(500);  
    digitalWrite(LED_Light, LOW);
    delay(500);  
    
    return 1;
}


bool changeState (String state){
    
    lit_state = !lit_state;
    
    digitalWrite(led2, lit_state);
    digitalWrite(LED_Light, lit_state);
    
    return lit_state;
}

bool currentState (String state){
   
    return lit_state;
}


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
  delay(500);
  */
  
  // Render one particular pixel
  
  /*
  if(lit_state){
      
      matrix.fillScreen(0);
      matrix.drawPixel(3, 3, matrix.Color(255, 0, 0));
      matrix.show();
      
  }else{
      matrix.fillScreen(0);
      matrix.drawPixel(3, 3, matrix.Color(0, 0, 0));
      matrix.show();
  }
  */
    
   // Blink Lights
   /*
   digitalWrite(led2, HIGH);
   delay(1000);
   digitalWrite(led2, LOW);
   delay(1000);
   */
   
   ButtonValue = digitalRead(button);
   
    if(ButtonValue != 0){
        lit_state = !lit_state;
        
        digitalWrite(led2, lit_state);
        digitalWrite(LED_Light, lit_state);
    }
   
   /*
   if(ButtonValue != 0){
       digitalWrite(LED_Light, HIGH);
       
   }else{
       digitalWrite(LED_Light, LOW);
   }
   */

}






int tinkerDigitalRead(String pin)
{
	//convert ascii to integer
	int pinNumber = pin.charAt(1) - '0';
	//Sanity check to see if the pin numbers are within limits
	if (pinNumber< 0 || pinNumber >7) return -1;

	if(pin.startsWith("D"))
	{
		pinMode(pinNumber, INPUT_PULLDOWN);
		return digitalRead(pinNumber);
	}
	else if (pin.startsWith("A"))
	{
		pinMode(pinNumber+10, INPUT_PULLDOWN);
		return digitalRead(pinNumber+10);
	}
	return -2;
}

int tinkerDigitalWrite(String command)
{
	bool value = 0;
	//convert ascii to integer
	int pinNumber = command.charAt(1) - '0';
	//Sanity check to see if the pin numbers are within limits
	if (pinNumber< 0 || pinNumber >7) return -1;

	if(command.substring(3,7) == "HIGH") value = 1;
	else if(command.substring(3,6) == "LOW") value = 0;
	else return -2;

	if(command.startsWith("D"))
	{
		pinMode(pinNumber, OUTPUT);
		digitalWrite(pinNumber, value);
		return 1;
	}
	else if(command.startsWith("A"))
	{
		pinMode(pinNumber+10, OUTPUT);
		digitalWrite(pinNumber+10, value);
		return 1;
	}
	else return -3;
}

int tinkerAnalogRead(String pin)
{
	//convert ascii to integer
	int pinNumber = pin.charAt(1) - '0';
	//Sanity check to see if the pin numbers are within limits
	if (pinNumber< 0 || pinNumber >7) return -1;

	if(pin.startsWith("D"))
	{
		return -3;
	}
	else if (pin.startsWith("A"))
	{
		return analogRead(pinNumber+10);
	}
	return -2;
}

int tinkerAnalogWrite(String command)
{
	//convert ascii to integer
	int pinNumber = command.charAt(1) - '0';
	//Sanity check to see if the pin numbers are within limits
	if (pinNumber< 0 || pinNumber >7) return -1;

	String value = command.substring(3);

	if(command.startsWith("D"))
	{
		pinMode(pinNumber, OUTPUT);
		analogWrite(pinNumber, value.toInt());
		return 1;
	}
	else if(command.startsWith("A"))
	{
		pinMode(pinNumber+10, OUTPUT);
		analogWrite(pinNumber+10, value.toInt());
		return 1;
	}
	else return -2;
}


