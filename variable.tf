# purpose: manage variables

variable "region" {
    type = string
    default = "Central US"
}

variable "env" {
    type = string
    default = "dev"
}

variable "subscription_id" {
    type = string
    default = "e7de40cb-b6b4-4537-bd2e-271de74ff325"
}

variable "vm_admin_user" {
    type = string
    default = "azadm"
}
