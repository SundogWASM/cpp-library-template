#include <greeter/greeter.h>   //包含头文件mylib.h
#include <iostream>

using namespace greeter;
int main(void)
{
  Greeter greeter("Tests");
  std::cout<< greeter.greet(LanguageCode::EN) << std::endl;

  return 0;
}
