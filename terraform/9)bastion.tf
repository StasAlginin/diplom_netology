# Создание bastion сервера

resource "yandex_compute_instance" "bastionvm" {
  name                = "bastion"
  hostname            = "bastion.ru-central1.internal"
  folder_id           = var.folder_id
  zone                = "ru-central1-a"
  
    resources {
      core_fraction = 5
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
    subnet_id           = yandex_vpc_subnet.public_subnet.id
    nat                 = true
    # security_group_ids  = [yandex_vpc_security_group.bastion.id]
  }
    
    metadata = {
    user-data = templatefile("ssh_config.tpl", {
      VM_USER = var.vm_user
      SSH_KEY = var.ssh_key
    })

    # ssh-keys  = "algininss:${file(var.ssh_key)}"
  }
  
    scheduling_policy {
      preemptible = true
    }
}