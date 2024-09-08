#  Создание target group

 resource "yandex_alb_target_group" "vm_tg" {
  name                = "target-group"
  folder_id           = var.folder_id

   target {
    subnet_id = yandex_vpc_subnet.private_subnet_vm1.id
    ip_address = yandex_compute_instance.vm[0].network_interface.0.ip_address
  }

  target {    
    subnet_id = yandex_vpc_subnet.private_subnet_vm2.id
    ip_address = yandex_compute_instance.vm[1].network_interface.0.ip_address
  }
 }

# Создание backend group

 resource "yandex_alb_backend_group" "backend_group" {
  name                = "backend-group"
  folder_id           = var.folder_id
  
 http_backend {
    name             = "backend-group"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_alb_target_group.vm_tg.id]

    load_balancing_config {
      panic_threshold = 90
    }

    healthcheck {
      timeout              = "5s"
      interval             = "5s"
      healthy_threshold    = 5
      unhealthy_threshold  = 5

      http_healthcheck {
        path = "/"
      }
    }
  }
 }

# Создание http router

resource "yandex_alb_http_router" "vm_http_router" {
  name                = "http-router"
  folder_id           = var.folder_id
}

# Создние virtual host

  resource "yandex_alb_virtual_host" "vm-virtual-host" {
    name                    = "virtual-host"
    http_router_id          = yandex_alb_http_router.vm_http_router.id
    route {
      name                  = "main-route"
      http_route {
        http_route_action {
          backend_group_id  = yandex_alb_backend_group.backend_group.id
          timeout           = "60s"
        }
      }
    }
  }

# Создание load balancer

resource "yandex_alb_load_balancer" "vm_balancer" {
  name                = "balancer"
  network_id          = yandex_vpc_network.main.id
  folder_id           = var.folder_id

  allocation_policy {
    location {
      zone_id   = var.zone
      subnet_id = yandex_vpc_subnet.public_subnet.id 
    }
  }

  listener {
    name = "balanser-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.vm_http_router.id
      }
    }
  }
}
