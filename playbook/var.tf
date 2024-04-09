###cloud vars
variable "token" {
  type        = string
  default = "***"
  description = ""
}

variable "cloud_id" {
  type        = string
  default = "***"
  description = ""
}

variable "folder_id" {
  type        = string
  default = "***"
  description = ""
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = ""
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = ""
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}


variable "vpc_name_ans" {
  type        = string
  default     = "net_db"
  description = "VPC network&subnet name"
}


variable "web_default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "default_a"
}

variable "family_os" {
  type = string
  default = "ubuntu-2204-lts"
  description = "falimly os linux"
}


variable "standart_platform_id" {
  type = string
  default = "standard-v1"
  description = "choosing a platform standard"
}

# SSH key
variable "ssh_key_for_any_host" {
  type = map(string)
    default = {
        serial-port-enable = 1
        ssh-keys           = "***"
      }
} 

variable "each_vm" {
  type = list(object({  
    vm_name=string
    cpu=number
    ram=number
    disk_volume=number
    core_fraction=number
    type_storage = string
    preemptible = bool
    nat = bool
     }))
    default = [ {vm_name = "clickhouse", cpu = 4, ram = 4, disk_volume = 20, core_fraction = 20, type_storage="network-hdd", preemptible = false, nat= true },
                {vm_name = "vector", "cpu" = 4, ram = 4, disk_volume = 20, core_fraction = 20, type_storage="network-hdd", preemptible = true, nat= true },
                {vm_name = "lighthouse", "cpu" = 4, ram = 4, disk_volume = 20, core_fraction = 20, type_storage="network-hdd", preemptible = true, nat= true }
     ]
}
