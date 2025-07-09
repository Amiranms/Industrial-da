#include "lib.h"
#include <iostream>


void ClassLib::Set(int value) {
    x_ = value;    
}

int ClassLib::Get() const {
    return x_;
}


std::string ClassLib::PrintSomeHumor() const {
    std::string text = "bla-bla-bla";
    std::cout<< text <<std::endl;
    return text;
}
