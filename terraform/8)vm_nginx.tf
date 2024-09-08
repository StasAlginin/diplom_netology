# Cоздание двух VM с Nginx

resource "yandex_compute_instance" "vm" {
  count        = 2
  name         = "vm-${count.index + 1}"
  hostname     = "vm-${count.index + 1}.ru-central1.internal"
  folder_id    = var.folder_id
  zone         = ["ru-central1-a", "ru-central1-b"][count.index]

  resources {
    core_fraction = 5
    cores         = 2
    memory        = 2
  }
  
  boot_disk {
   initialize_params {
     image_id = "fd8j0uq7qcvtb65fbffl"
     size     = 10
      }
    }

  network_interface {
  subnet_id             = [yandex_vpc_subnet.private_subnet_vm1.id, yandex_vpc_subnet.private_subnet_vm2.id][count.index]
    nat                 = false
    # security_group_ids  = [yandex_vpc_security_group.web_sg.id]
  }

   metadata = {
    user-data = templatefile("ssh_nginx.yaml", {
      VM_USER = var.vm_user
      SSH_KEY = var.ssh_key
    })

    # ssh-keys  = "algininss:${file(var.ssh_key)}"
    # user-data = file("/home/algininss/diplom/terraform/nginx.yaml")
  } 

  scheduling_policy {
    preemptible = true
  }

}
