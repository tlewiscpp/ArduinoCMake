//
// Created by pinguinsan on 10/26/17.
//
#include <Arduino.h>

void setup() {
    Serial.begin(115200L);
}

void loop() {
    Serial.println("Hello");
    delay(500);
}

#ifdef CMAKE_BUILD
#   include "main.cpp"
#endif
