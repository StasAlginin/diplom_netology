# Создание Zabbix

resource "yandex_compute_instance" "zabbixvm" {
  name                = "zabbix"
  hostname            = "zabbix.ru-central1.internal"
  folder_id           = var.folder_id
  zone                = "ru-central1-a"

  resources {
      core_fraction = 20
      memory        = 2
      cores         = 2
  }
    
    boot_disk {
      initialize_params {
        image_id = "fd8j0uq7qcvtb65fbffl"
        size     = 10
      }
    }

    network_interface {
    subnet_id          = yandex_vpc_subnet.public_subnet_zabbix_kibana.id
    nat                = true  
    security_group_ids = [yandex_vpc_security_group.zabbix.id]
  }
    
    metadata = {
    user-data = templatefile("ssh_nginx.yaml", {
      VM_USER = var.vm_user
      SSH_KEY = var.ssh_key
    })
  }
  
    scheduling_policy {
      preemptible = true
    }
}

