{%- set hkNodes = getNodeNames(nodeList, hkFilter) %}
{%- set twNodes = getNodeNames(nodeList, taiwanFilter) %}
{%- set sgNodes = getNodeNames(nodeList, singaporeFilter) %}
{%- set jpNodes = getNodeNames(nodeList, japanFilter) %}
{%- set usNodes = getNodeNames(nodeList, usFilter) %}
{%- set krNodes = getNodeNames(nodeList, koreaFilter) %}


#Clash Config managed by TEDIORELEE, year 2022

# HTTP(S) and SOCKS5 server on the same port
mixed-port: 7890

# Set to true to allow connections to local-end server from
allow-lan: true
bind-address: '*'

mode: rule

log-level: info

# When set to false, resolver won't translate hostnames to IPv6 addresses
ipv6: true

# RESTful web API listening address
external-controller: 0.0.0.0:9090

# Outbound interface name
# interface-name: en0

hosts:
  'mtalk.google.com': 108.177.125.188
  # '*.clash.dev': 127.0.0.1
  # '.dev': 127.0.0.1
  # 'alpha.clash.dev': '::1'

profile:
  tracing: true

script:
  shortcuts: # 使用 Python 脚本编写自定义规则
    # 4483 与 9305 为 BiliBili 的 QUIC CDN
    quic: network == 'udp' and (dst_port == 443 or dst_port == 4483 or dst_port == 9305) # 可以在 rule 中引用

# DNS server settings
dns:
  enable: true
  default-nameserver:
    - 114.114.114.114
    - 8.8.8.8
  enhanced-mode: fake-ip # or fake-ip
  fake-ip-range: 198.18.0.1/16 # Fake IP addresses pool CIDR
  nameserver:
    - 114.114.114.114 # default value
    - 8.8.8.8 # default value
    - https://dns.alidns.com/dns-query

  fallback-filter:
    geoip: true
    ipcidr:
      # - 240.0.0.0/4

proxies: {{ getClashNodes(nodeList) | json }}

proxy-groups:
- type: select
  name: Outside
  icon: {{ img_baseURL }}Global.png
  proxies:
    - Proxy
    - 🇺🇲 US
    - 🇸🇬 Singapore
    - 🇯🇵 Japan
    - 🇭🇰 HongKong
    - 🇨🇳 Taiwan
    - 🇰🇷 Korea
- type: select
  name: YouTube
  icon: {{ img_baseURL }}YouTube.png
  proxies:
    - Proxy
    - 🇺🇲 US
    - 🇸🇬 Singapore
    - 🇯🇵 Japan
    - 🇭🇰 HongKong
    - 🇨🇳 Taiwan
    - 🇰🇷 Korea
- type: select
  name: Netflix
  icon: {{ img_baseURL }}Netflix.png
  proxies:
    - Proxy
    - 🇺🇲 US
    - 🇸🇬 Singapore
    - 🇯🇵 Japan
    - 🇭🇰 HongKong
    - 🇨🇳 Taiwan
- type: select
  name: HBO
  icon: {{ img_baseURL }}HBO.png
  proxies:
    - Proxy
    - 🇺🇲 US
    - 🇭🇰 HongKong
- type: select
  name: DisneyPlus
  icon: {{ img_baseURL }}DisneyPlus.png
  proxies:
    - Proxy
    - 🇸🇬 Singapore
- type: select
  name: Stream
  icon: {{ img_baseURL }}Streaming.png
  proxies:
    - Proxy
    - 🇺🇲 US
    - 🇸🇬 Singapore
    - 🇯🇵 Japan
    - 🇭🇰 HongKong
    - 🇨🇳 Taiwan
    - 🇰🇷 Korea
- type: select
  name: Final
  icon: {{ img_baseURL }}Final.png
  proxies:
    - Outside
    - DIRECT
- type: select
  name: Proxy
  proxies: {{ getClashNodeNames(nodeList) | json }}

- name: 🇺🇲 US
{% if usNodes %}
  type: url-test
  proxies: {{ getClashNodeNames(nodeList, usFilter) | json }}
  url: {{ proxyTestUrl }}
  interval: 1200
{% else %}
  type: select
  proxies: 
    - Proxy
{% endif %}

- name: 🇸🇬 Singapore
{% if sgNodes %}
  type: url-test
  proxies: {{ getClashNodeNames(nodeList, singaporeFilter) | json }}
  url: {{ proxyTestUrl }}
  interval: 1200
{% else %}
  type: select
  proxies: 
    - Proxy
{% endif %}

- name: 🇯🇵 Japan
{% if jpNodes %}
  type: url-test
  proxies: {{ getClashNodeNames(nodeList, japanFilter) | json }}
  url: {{ proxyTestUrl }}
  interval: 1200
{% else %}
  type: select
  proxies: 
    - Proxy
{% endif %}

- name: 🇭🇰 HongKong
{% if hkNodes %}
  type: url-test
  proxies: {{ getClashNodeNames(nodeList, hkFilter) | json }}
  url: {{ proxyTestUrl }}
  interval: 1200
{% else %}
  type: select
  proxies: 
    - Proxy
{% endif %}

- name: 🇨🇳 Taiwan
{% if twNodes %}
  type: url-test
  proxies: {{ getClashNodeNames(nodeList, taiwanFilter) | json }}
  url: {{ proxyTestUrl }}
  interval: 1200
{% else %}
  type: select
  proxies: 
    - Proxy
{% endif %}

- name: 🇰🇷 Korea
{% if krNodes %}
  type: url-test
  proxies: {{ getClashNodeNames(nodeList, koreaFilter) | json }}
  url: {{ proxyTestUrl }}
  interval: 1200
{% else %}
  type: select
  proxies: 
    - Proxy
{% endif %}


rules:
- SCRIPT,quic,REJECT

# Goole CN
- DOMAIN-SUFFIX,services.googleapis.cn,Outside

# YouDao
- DOMAIN-SUFFIX,youdao.com,DIRECT
- DOMAIN-KEYWORD,youdao,DIRECT

# Github
- DOMAIN-KEYWORD,github,Outside
- DOMAIN-SUFFIX,github.com,Outside

# Lark
- DOMAIN-KEYWORD,lark,DIRECT
- DOMAIN-KEYWORD,larksuite,DIRECT
- DOMAIN-SUFFIX,larksuite.com,DIRECT

# Axure
- DOMAIN-KEYWORD,axure,Outside
- DOMAIN-SUFFIX,axure.com,Outside

- PROCESS-NAME,Teams.exe,DIRECT

{{ remoteSnippets.TelegramSG.main('🇸🇬 Singapore') | clash }}
{{ remoteSnippets.TelegramNL.main('Proxy') | clash }}
{{ remoteSnippets.TelegramUS.main('🇺🇲 US') | clash }}
{{ remoteSnippets.Games.main('Outside') | clash }}
{{ remoteSnippets.Microsoft.main('DIRECT') | clash }}
{{ remoteSnippets.Global.main('Outside') | clash }}
{{ remoteSnippets.Hijacking.main('REJECT') | clash }}
{{ remoteSnippets.Twitch.main('Stream') | clash }}
{{ remoteSnippets.Spotify.main('Stream') | clash }}
{{ remoteSnippets.YouTubeMusic.main('YouTube') | clash }}
{{ remoteSnippets.YouTube.main('YouTube') | clash }}
{{ remoteSnippets.DisneyPlus.main('DisneyPlus') | clash }}
{{ remoteSnippets.Pornhub.main('Stream') | clash }}
{{ remoteSnippets.Netflix.main('Netflix') | clash }}
{{ remoteSnippets.China.main('DIRECT') | clash }}

# LAN
- DOMAIN-SUFFIX,local,DIRECT
- IP-CIDR,127.0.0.0/8,DIRECT
- IP-CIDR,172.16.0.0/12,DIRECT
- IP-CIDR,192.168.0.0/16,DIRECT
- IP-CIDR,10.0.0.0/8,DIRECT
- IP-CIDR,17.0.0.0/8,DIRECT
- IP-CIDR,100.64.0.0/10,DIRECT


# Final
- GEOIP,CN,DIRECT
- MATCH,Final
