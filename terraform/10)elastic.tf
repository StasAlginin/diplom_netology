# Создание Elasticsearch

resource "yandex_compute_instance" "elasticsearchvm" {
  name                = "elasticsearch"
  hostname            = "elasticsearch.ru-central1.internal"
  folder_id           = var.folder_id
  zone                = "ru-central1-a"

  resources {
      core_fraction = 20
      memory        = 6
      cores         = 2
    }
    
    boot_disk {
      initialize_params {
        image_id = "fd8j0uq7qcvtb65fbffl"
        size     = 10
      }
    }
    
    network_interface {
    subnet_id           = yandex_vpc_subnet.private_subnet_elk.id
    nat                 = false
    # security_group_ids  = [yandex_vpc_security_group.elastic.id]
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

# Создание Kibana

resource "yandex_compute_instance" "kibanavm" {
  name                = "kibana"
  hostname            = "kibana.ru-central1.internal"
  folder_id           = var.folder_id
  zone                = "ru-central1-a"

  resources {
     core_fraction = 5
      memory       = 4
      cores        = 2
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
    # security_group_ids = [yandex_vpc_security_group.kibana.id]
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