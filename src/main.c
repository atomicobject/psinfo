#include "ModuleLoader.h"
#include <stdio.h>


const char* ok_str     = "OK";
const char* not_ok_str = "NOT_OK";


int main(void)
{
  switch (ModuleLoader_LoadItem( 0 ))
  {
    case OK:
      printf("%s\n", ok_str);
      break;
    
    case NOT_OK:
      printf("%s\n", not_ok_str);    
      break;
  }
}

