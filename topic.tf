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
         key = "topic.tfstate"
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

 resource "azurerm_eventgrid_system_topic" "stgTopic" {
        name = "stgaccounttopicterra"
        resource_group_name = local.resource_group 
        location = local.location
        topic_type = "Microsoft.Storage.StorageAccounts"
        source_arm_resource_id = "/subscriptions/abfa7548-7cd5-4ab5-91b2-07efdced45fe/resourceGroups/RGForPractice/providers/Microsoft.Storage/storageAccounts/storageaccountpracticeey"
        }


 Output "stgTopicId" {

 value =  azurerm_eventgrid_system_topic.stgTopic.id

}


 
