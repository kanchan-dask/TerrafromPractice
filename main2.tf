terraform {
 required_providers {
  azurerm = {
    source = "hashicorp/azurerm"
    version = "~> 3.0.2"
  }
} 
 backend "azurerm" {
                      
         resource_group_name = "RGForPractice"
         storage_account_name = "storageaccountpracticeey"       
         container_name = "containerforpractice"
         key = "terraform.tfstate"
     }
}

provider "azurerm" {
       
        features {}
        
	subscription_id="abfa7548-7cd5-4ab5-91b2-07efdced45fe"
        tenant_id = "e08f9c82-8121-443c-8594-75a2ae52a40f"
        client_id = "0af40901-2aa7-464c-81ba-62dda6f53d9e"
        client_secret = "2Pm8Q~zNh7JXWZlBK6-AhugqjSLCj9g3AV~qeaSH"
}

 locals {
      resource_group = "RGForPractice"
      location = "southindia"
}


 resource "azurerm_storage_queue" "stgQueue" {
       name = "stgaccountqueueterra"
       storage_account_name = "storageaccountpracticeey"
}

 resource "azurerm_eventgrid_event_subscription" "eventSub" {
      name = "eventSubTerra"
      scope = "/subscriptions/abfa7548-7cd5-4ab5-91b2-07efdced45fe/resourceGroups/RGForPractice/providers/Microsoft.Storage/storageAccounts/storageaccountpracticeey"
      storage_queue_endpoint {
         storage_account_id = "/subscriptions/abfa7548-7cd5-4ab5-91b2-07efdced45fe/resourceGroups/RGForPractice/providers/Microsoft.Storage/storageAccounts/storageaccountpracticeey"
         queue_name = azurerm_storage_queue.stgQueue.name
}
}


 
