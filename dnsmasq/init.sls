{% from "dnsmasq/map.jinja" import dnsmasq with context %}

install-dnsmasq:
  pkg.installed:
    - name: {{ dnsmasq.pkg }}

run-dnsmasq:
  service.running:
    - enable: true
    - name: {{ dnsmasq.service }}
    - require:
      - pkg: {{ dnsmasq.pkg }}
