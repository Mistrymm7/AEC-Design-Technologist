int led2 = D7;
int ButtonValue = 0;
int button = D3;
int LED_Light = D4;


bool lit_state = false;

bool shop_keeper_status = false;


void setup() {
   
   Serial.begin(115200);  
   pinMode(led2, OUTPUT);
   digitalWrite(led2, LOW);
   pinMode(button, INPUT);
   pinMode(LED_Light, OUTPUT);
   
  
    
    
   Particle.function("change_lit_state", changeState); 
    
    //Particle.function("current_state", currentState); 
    
   // Particle.function("shopkeeperUpdate", shopkeeperUpdate); 
    
    Particle.function("flash_shopkeeper", flash_shopkeeper); 
 

}


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
    
    ButtonValue = digitalRead(button);
   
    if(ButtonValue != 0){
        lit_state = !lit_state;
        
        digitalWrite(led2, lit_state);
        digitalWrite(LED_Light, lit_state);
    }
    
    
   
  

}
