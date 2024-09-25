variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS Prefix for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "Size of the virtual machines in the node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "subnet_id" {
  description = "ID of the subnet for the AKS cluster"
  type        = string
}
