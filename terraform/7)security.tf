# Группа безопасности для bastion

resource "yandex_vpc_security_group" "bastion" {
  name        = "bastion"
  description = "Security group for bastion-server"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22

  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]

  }

}

# Группа безопасности для web-vm

resource "yandex_vpc_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Security group for web-servers"
  network_id  = yandex_vpc_network.main.id

ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    description    = "Allow Zabbix-server"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.16/28"]
    port           = 10050
  }

  ingress {
    description    = "Allow HTTP"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    description    = "Allow HTTPS"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Группа безопасности для zabbix

resource "yandex_vpc_security_group" "zabbix" {
  name        = "zabbix"
  description = "Security group for zabbix-server"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    description    = "Allow web-zabbix"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8080
  }

  ingress {
    description    = "Allow Zabbix-agent-active"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 10051
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

}

# Группа безопасности для сервера server_elastic

resource "yandex_vpc_security_group" "elastic" {
  name        = "elastic"
  description = "Security group for elastic"
  network_id  = yandex_vpc_network.main.id
  
  ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    description    = "Allow Zabbix-server"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 10050
  }

  ingress {
    description    = "Allow Elasticsearch"
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

}

# Группа безопасности для kibana

resource "yandex_vpc_security_group" "kibana" {
  name        = "kibana-sg"
  description = "Security group for kibana"
  network_id  = yandex_vpc_network.main.id
  
  ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22

  }

  ingress {
    description    = "Allow Zabbix-server"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 10050

  }

  ingress {
    description    = "Allow kibana"
    protocol       = "TCP"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]

  }

}