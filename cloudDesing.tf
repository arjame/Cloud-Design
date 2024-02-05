# main.tf

provider "azurerm" {
  features = {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "IoT Core"
  location = "EU West"
}

# Azure IoT Hub
resource "azurerm_iothub" "iothub" {
  name                      = "my-iothub"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  sku                       = "S1"
  partition_count           = 4
  number_of_consumer_groups = 5
}

# Azure Cosmos DB
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "my-cosmosdb"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
}

# Azure SQL Database
resource "azurerm_sql_server" "sqlserver" {
  name                         = "my-sql-server"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "StrongP@ssw0rd!"
}

resource "azurerm_sql_database" "sqldb" {
  name                = "my-sql-database"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sqlserver.name
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 1
}

# Azure Function App
resource "azurerm_function_app" "functionapp" {
  name                      = "my-function-app"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  app_service_plan_id       = azurerm_app_service_plan.appserviceplan.id
  storage_account_name       = azurerm_storage_account.storageaccount.name
  storage_account_access_key = azurerm_storage_account.storageaccount.primary_access_key
}

# Azure Storage Account
resource "azurerm_storage_account" "storageaccount" {
  name                     = "mystorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Additional Resources...
# (Add resources like Azure Logic Apps, Azure Active Directory, etc. as needed)
