variable "token" {
  description = "token"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "cloud"
  type        = string
  sensitive   = true
}

variable "folder_id" {
  description = "folder"
  type        = string
  sensitive   = true
}

variable "ssh_key" {
  description = "ssh"
  type        = string
  default = "/home/algininss/.ssh/id_rsa.pub"
}

variable "zone" {
  description = "zone"
  type        = string
  default = "ru-central1-a"
}

variable "vm_user" {
  type        = string
}