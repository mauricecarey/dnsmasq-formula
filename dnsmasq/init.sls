{% from "dnsmasq/map.jinja" import dnsmasq with context %}

dnsmasq-config-dir:
  file.directory:
    - name: {{ dnsmasq.config_dir }}
    - mode: 755
    - makedirs: True

{{ dnsmasq.config_dir }}/default:
  file.managed:
    - source: salt://dnsmasq/files/default
    - template: jinja
    - require:
      - file: dnsmasq-config-dir
    - defaults:
        config_dir: {{ dnsmasq.config_dir }}

{{ dnsmasq.config_file }}:
  file.managed:
    - source: salt://dnsmasq/files/dnsmasq.conf
    - mode: 644
    - require:
      - pkg: dnsmasq
    - defaults:
        config_dir: {{ dnsmasq.config_dir }}

dnsmasq:
  pkg.installed:
    - name: {{ dnsmasq.pkg }}
  service.running:
    - enable: true
    - name: {{ dnsmasq.service }}
    - require:
      - pkg: {{ dnsmasq.pkg }}
