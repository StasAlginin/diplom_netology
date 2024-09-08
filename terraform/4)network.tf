# Создание сети и подсетей

resource "yandex_vpc_network" "main" {
  name = "main-network"
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "private_subnet_vm1" {
  name           = "private-subnet-vm1"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.1.0/28"]
  folder_id      = var.folder_id
  network_id     = yandex_vpc_network.main.id
  route_table_id = yandex_vpc_route_table.main_route_table.id
}

resource "yandex_vpc_subnet" "private_subnet_vm2" {
  name           = "private-subnet-vm2"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["192.168.1.16/28"]
  folder_id      = var.folder_id
  network_id     = yandex_vpc_network.main.id
  route_table_id = yandex_vpc_route_table.main_route_table.id
}

resource "yandex_vpc_subnet" "private_subnet_elk" {
  name           = "private-subnet-elk"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.1.32/28"]
  folder_id      = var.folder_id
  network_id     = yandex_vpc_network.main.id
  route_table_id = yandex_vpc_route_table.main_route_table.id
}

resource "yandex_vpc_subnet" "public_subnet" {
  name           = "public-subnet"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.2.0/28"]
  folder_id      = var.folder_id
  network_id     = yandex_vpc_network.main.id
  route_table_id = yandex_vpc_route_table.main_route_table.id
}

resource "yandex_vpc_subnet" "public_subnet_zabbix_kibana" {
  name           = "public-subnet-zabbix-kibana"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.2.16/28"]
  folder_id      = var.folder_id
  network_id     = yandex_vpc_network.main.id
  route_table_id = yandex_vpc_route_table.main_route_table.id
}