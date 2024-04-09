# 08-ansible-03-yandex

## Предисловие!
1) Хосты разворачиваются при помощи terraform кода.
 ## Terraform
```
В main.tf написан шаблон, по которому создается и заполнятеся файл prod.yml.
В var.tf - все переменные для terrafom кода.
В instance.tf - создаются ВМ методом for_each
```  
2) Для установки lighthouse используется bash скрипт, который лежит в ./playbook/template
   
### Задание 1.

```
- name: Install lightHouse
  hosts: lighthouse
  handlers:
    - name: Start lighthouse service
      become: true
      ansible.builtin.service:
        name: lighthouse
        state: restarted
# Подключение по SSH
  pre_tasks:
    - block:
        - name: SSH-Autorization
          ansible.posix.authorized_key:
            user: "{{ ansible_user }}"
            state: present
            key: "{{ lookup ( 'file', '/home/mng/Desktop/OPEN-KEY') }}"
# Заливаем скрипт установки lighthouse
  tasks:
    - name: copy install file
      become: true
      ansible.builtin.copy:
        src: "template/script.sh"
        dest: "/opt"
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}"
        mode: "0755"
# Запускаем скрипт установки lighthouse
    - name: execute script for install lightHouse
      become: true
      ansible.builtin.command: bash /opt/script.sh
```
Задание 3.

```
- name: Install nginx
  hosts: lighthouse
  handlers:
    - name: Start nginx service
      become: true
      ansible.builtin.service:
        name: nginx
        state: restarted
# Подключение по SSH
  pre_tasks:
    - block:
        - name: SSH-Autorization
          ansible.posix.authorized_key:
            user: "{{ ansible_user }}"
            state: present
            key: "{{ lookup ( 'file', '/home/mng/Desktop/OPEN-KEY') }}"
  tasks:
    - name: update apt
      become: true
      ansible.builtin.command: sudo apt-get update
    - name: Update apt cache and install nginx
      become: true
      ansible.builtin.apt:
        name: nginx
        state: latest
        update_cache: yes
    - name: install ligthouse config
      become: true
      ansible.builtin.template:
        src: "./template/nginx.conf.j2"
        dest: "/etc/nginx/conf.d/defult.conf"
        mode: "0644"
    - name: Flush handlers nginx  #Ждем, для того, чтобы не было при перезапуске
      ansible.builtin.meta: flush_handlers
    - name: Wait 10 sec
      ansible.builtin.pause:
        seconds: 10
      notify: Start nginx service
```

### Задание 4.
Файл prod.yml генерируется после выполнения кода terraform и имеет общий вид:

```
clickhouse:
  hosts:
    clickhouse-01: 
      ansible_host: 178.154.201.16
      ansible_user: ubuntu
  
lighthouse:
  hosts:
    lighthouse-01: 
      ansible_host: 158.160.112.31
      ansible_user: ubuntu
  
vector:
  hosts:
    vector-01: 
      ansible_host: 178.154.205.125
      ansible_user: ubuntu
```

Задание 5.
![Скриншот 09-04-2024 114439](https://github.com/HZTV/08-ansible-03-yandex/assets/149588305/b0a3d7e9-2580-4094-8e7f-c59ca88dc041)

Задание 6.
![image](https://github.com/HZTV/08-ansible-03-yandex/assets/149588305/21c6134d-d4f2-47b9-8027-2f18c95e124f)

Задание 7.
![image](https://github.com/HZTV/08-ansible-03-yandex/assets/149588305/f08aa3b4-a9c2-4243-9343-52802c78f417)

Задание 8.
![image](https://github.com/HZTV/08-ansible-03-yandex/assets/149588305/6bb1724c-c2f3-4eda-96f6-49aaa0ae50b5)









     
