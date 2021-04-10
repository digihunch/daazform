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
    default = "7f2177a8-8cec-4f8e-a7a5-6fcd808b49a8"
}

variable "vm_admin_user" {
    type = string
    default = "azadm"
}
