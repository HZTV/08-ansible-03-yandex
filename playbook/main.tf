resource "yandex_vpc_network" "clik" {
  name = var.vpc_name_ans
}

resource "yandex_vpc_subnet" "vectr" {
  name           = var.vpc_name_ans
  zone           = var.default_zone
  network_id     = yandex_vpc_network.clik.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "db" {
  family = var.family_os
}


# Блок с ansible. Создает динамический инвентори prod.yml файл. Интерполация делается в 27 стр  ${i["name"]}-01:
resource "local_file" "hosts_for" {
    depends_on = [ yandex_compute_instance.ansible-instance ]
content =  <<-EOT

  %{if length(yandex_compute_instance.ansible-instance) > 0}
  %{endif}
  %{for i in yandex_compute_instance.ansible-instance }
${i["name"]}:
  hosts:
    ${i["name"]}-01: 
      ansible_host: ${i["network_interface"][0]["nat_ip_address"]}
      ansible_user: ubuntu
  %{endfor}
  EOT
  filename = "./inventory/prod.yml"

}
