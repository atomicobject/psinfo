#include "ModuleLoader.h"
#include "DataLoader.h"
#include "DataStore.h"


Status_T ModuleLoader_LoadItem(UINT index)
{
  MemOpResult_T result;
  result = DataLoader_Load( DataStore_RetrieveByIndex(index) );

  return ((result == MEM_OK) ? OK : NOT_OK);
}

