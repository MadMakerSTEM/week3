#include <Esplora.h>

void setup()
{
  Keyboard.begin();
}

void loop()
{
  if (/* SOME CONDITION */) {
    // PRESS A KEY TO TURN ONE WAY
  }
  else if (/* SOME OTHER CONDITION */) {
    // PRESS A DIFFERENT KEY TO TURN THE OTHER WAY
  }
  else {
    //Keyboard.release(FIRST_KEY);
    //Keyboard.release(SECOND_KEY);
  }
  if(/* ANOTHER CONDITION */) {
    // PRESS THE THRUSTER KEY
  }
  else {
    // RELEASE THE THRUSTER KEY
  }
  delay(15);
}

