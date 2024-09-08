# Создание группы маршрутов

resource "yandex_vpc_gateway" "nat_gateway" {
  name                = "nat-gateway"
  folder_id           = var.folder_id
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "main_route_table" {
  name           = "main-route-table"
  folder_id      = var.folder_id
  network_id     = yandex_vpc_network.main.id
  
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}