#include "unity.h"
#include "ModuleLoader.h"
#include "mock_DataStore.h"
#include "mock_DataLoader.h"


DataStruct_T test_data;


void setUp(void) {}
void tearDown(void) {}


void test_ModuleLoader_LoadItem_should_SuccessfullyRetrieveDataAndLoad(void)
{
  DataStore_RetrieveByIndex_ExpectAndReturn(2, test_data);
  DataLoader_Load_ExpectAndReturn(test_data, MEM_OK);

  TEST_ASSERT_EQUAL(OK, ModuleLoader_LoadItem(2));
}

void test_ModuleLoader_LoadItem_should_FailLoadingData(void)
{
  DataStore_RetrieveByIndex_ExpectAndReturn(10, test_data);
  DataLoader_Load_ExpectAndReturn(test_data, MEM_ERROR);

  TEST_ASSERT_EQUAL(NOT_OK, ModuleLoader_LoadItem(10));
}
