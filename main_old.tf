terraform {
 required_providers {
  azurerm = {
    source = "hashicorp/azurerm"
    version = "~> 3.0.2"
  }
}
   
 backend "storeTfState" {
         resource_group = "RGForPractice"
	 storage_account = "storageaccountpracticeey"
         container_name = "containerforpractice"
         key = "terraform.tfstate"
     }	
}

provider "azurerm" {
       
        features {}
}

 locals {
      resource_group = "RGForPractice"
      location = "centralindia"
}

 resource "azurerm_event_grid_system_topic" "stgTopic" {
        name = "stgAccountTopicTerra"
        resource_group = local.resource_group 
        location = local.location
        topic_type = "Microsoft.Storage/storageAccounts"
        source_arm_resource_id = "/subscriptions/abfa7548-7cd5-4ab5-91b2-07efdced45fe/resourceGroups/RGForPractice/providers/Microsoft.Storage/storageAccounts/storageaccountpracticeey"
        }

 resource "azurerm_storage_queue" "stgQueue" {
       name = "stgAccountQueueTerra"
       storage_account_name = "storageaccountpracticeey"
}

 resource "azurerm_event_grid_system_topic_event_subscription" "eventSub" {
      name = "eventSubTerra"
      location = local.location
      system_topic = azurerm_event_grid_system_topic.stgTopic.id
      storage_queue_endpoint {
         storage_account_id = "/subscriptions/abfa7548-7cd5-4ab5-91b2-07efdced45fe/resourceGroups/RGForPractice/providers/Microsoft.Storage/storageAccounts/storageaccountpracticeey"
         queue_name = azurerm_storage_queue.stgQueue.name
}
}


 