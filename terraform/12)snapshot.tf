# Создание Snapshot

resource "yandex_compute_snapshot_schedule" "snapshots" {
  name                = "snapshots"

  schedule_policy {
    expression = "0 0 ? * *"
  }

  snapshot_count = 2

  snapshot_spec {
    description = "snapshots"  
  }

  disk_ids = [yandex_compute_instance.vm[0].boot_disk.0.disk_id, yandex_compute_instance.vm[1].boot_disk.0.disk_id, yandex_compute_instance.elasticsearchvm.boot_disk.0.disk_id, yandex_compute_instance.kibanavm.boot_disk.0.disk_id, yandex_compute_instance.zabbixvm.boot_disk.0.disk_id, yandex_compute_instance.bastionvm.boot_disk.0.disk_id]
}