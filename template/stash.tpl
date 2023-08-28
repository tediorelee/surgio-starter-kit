{%- set hkNodes = getNodeNames(nodeList, hkFilter) %}
{%- set twNodes = getNodeNames(nodeList, taiwanFilter) %}
{%- set sgNodes = getNodeNames(nodeList, singaporeFilter) %}
{%- set jpNodes = getNodeNames(nodeList, japanFilter) %}
{%- set usNodes = getNodeNames(nodeList, usFilter) %}
{%- set krNodes = getNodeNames(nodeList, koreaFilter) %}

{% set img_baseURL = 'https://raw.githubusercontent.com/Orz-3/mini/master/Color/' %}


# HTTP(S) and SOCKS5 server on the same port
mixed-port: 7890

# Set to true to allow connections to local-end server from
allow-lan: true
bind-address: '*'

mode: rule

log-level: info

# When set to false, resolver won't translate hostnames to IPv6 addresses
ipv6: false

# RESTful web API listening address
external-controller: 0.0.0.0:9090

# Outbound interface name
# interface-name: en0

{% include './snippet/stash_mitm.tpl' %}

hosts:
  'mtalk.google.com': 108.177.125.188
  # '*.clash.dev': 127.0.0.1
  # '.dev': 127.0.0.1
  # 'alpha.clash.dev': '::1'
  'apm.activecommunities.com': 10.230.17.17
  'activenetsitesdev.active.com': 10.219.128.216
  'apmstg.activecommunities.com': 10.230.17.27


profile:
  tracing: true

script:
  shortcuts: # 使用 Python 脚本编写自定义规则
    # 4483 与 9305 为 BiliBili 的 QUIC CDN
    quic: network == 'udp' and (dst_port == 443 or dst_port == 4483 or dst_port == 9305) # 可以在 rule 中引用
    udp-cn: network == 'udp' and geoip(dst_ip if dst_ip != '' else resolve_ip(host)) == 'CN' # 禁止发往 CN 的 UDP

# DNS server settings
dns:
  enable: true
  ipv6: false
  default-nameserver:
    - 114.114.114.114
    - 223.5.5.5
  fake-ip-filter:
    - '*.lan'
    - localhost.ptlogin2.qq.com
    - '+.srv.nintendo.net'
    - '+.stun.playstation.net'
    - '+.msftconnecttest.com'
    - '+.msftncsi.com'
    - '+.xboxlive.com'
    - 'msftconnecttest.com'
    - 'xbox.*.microsoft.com'
    - '*.battlenet.com.cn'
    - '*.battlenet.com'
    - '*.blzstatic.cn'
    - '*.battle.net'
  nameserver:
    - https://dns.alidns.com/dns-query
    - https://doh.pub/dns-query
    - system

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

rule-providers:
  proxy-domain-text:
    behavior: domain-text # 使用 domain 类规则集，可以使匹配更高效
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/proxy.txt
    interval: 86400

  telegram-cidr:
    behavior: ipcidr # 使用 domain 类规则集，可以使匹配更高效
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/telegramcidr.txt
    interval: 86400

  ip-cidr-text:
    behavior: ipcidr-text
    url: https://cdn.jsdelivr.net/gh/17mon/china_ip_list@master/china_ip_list.txt
    interval: 86400

rules:
- SCRIPT,quic,REJECT
- SCRIPT,udp-cn,REJECT

- RULE-SET,proxy-domain-text,Outside
- RULE-SET,telegram-cidr,Outside
- RULE-SET,ip-cidr-text,DIRECT

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

# weixin
- DOMAIN-SUFFIX,szsupport.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,extshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,szaxshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,axshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mldisas.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,szquic.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,long.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mlshort.pay.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,minorlong.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,shshort.pay.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,short.pay.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,shminorlong.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,shextshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,short.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,szlong.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,szextshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mlminorshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mllong.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,dns.weixin.qq.com.cn,DIRECT
- DOMAIN-SUFFIX,szminorlong.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mlminorlong.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,szfindershort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,shquic.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,quic.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mlfindershort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,minorshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,shdisas.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mlquic.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,szshort.pay.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,szshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mlextshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mlaxshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,findershort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,szdisas.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mlshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,szminorshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,wximg.qq.com,DIRECT
- DOMAIN-SUFFIX,wxsnsdyvip.wxs.qq.com,DIRECT
- DOMAIN-SUFFIX,support.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,weixinc2c.tc.qq.com,DIRECT
- DOMAIN-SUFFIX,weixin110.qq.com,DIRECT
- DOMAIN-SUFFIX,mlsupport.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,mp.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,open.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,wxsnsdy.wxs.qq.com,DIRECT
- DOMAIN-SUFFIX,wxsnsdythumb.wxs.qq.com,DIRECT
- DOMAIN-SUFFIX,api.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,vweixinf.tc.qq.com,DIRECT
- DOMAIN-SUFFIX,c6.y.qq.com,DIRECT
- DOMAIN-SUFFIX,weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,wxapp.tc.qq.com,DIRECT
# WeChat 港澳(ip位于深圳、香港）
- DOMAIN-SUFFIX,res.servicewechat.com,DIRECT
- DOMAIN-SUFFIX,resstatic.servicewechat.com,DIRECT
- DOMAIN-SUFFIX,hksupport.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hkextshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hkshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hkaxshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hkdisas.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hkshort6.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hkshort.pay.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hklong.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hkminorshort.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hkquic.weixin.qq.com,DIRECT
- DOMAIN-SUFFIX,hkfindershort.weixin.qq.com,DIRECT
# WeChat 新加坡(ip位于新加坡）
- DOMAIN-SUFFIX,support.wechat.com,Outside
- DOMAIN-SUFFIX,sgshort.wechat.com,Outside
- DOMAIN-SUFFIX,sgshort.pay.wechat.com,Outside
- DOMAIN-SUFFIX,sglong.wechat.com,Outside
- DOMAIN-SUFFIX,sgminorshort.wechat.com,Outside
- DOMAIN-SUFFIX,sgaxshort.wechat.com,Outside
- DOMAIN-SUFFIX,sgfindershort.wechat.com,Outside

{{ remoteSnippets.Games.main('Outside') | clash }}
{{ remoteSnippets.Microsoft.main('DIRECT') | clash }}
{{ remoteSnippets.Advertising.main('REJECT') | clash }}
{{ remoteSnippets.Privacy.main('REJECT') | clash }}
{{ remoteSnippets.Hijacking.main('REJECT') | clash }}
{{ remoteSnippets.HBO.main('HBO') | clash }}
{{ remoteSnippets.PrimeVideo.main('Stream') | clash }}
{{ remoteSnippets.Twitch.main('Stream') | clash }}
{{ remoteSnippets.Spotify.main('Stream') | clash }}
{{ remoteSnippets.SoundCloud.main('Stream') | clash }}
{{ remoteSnippets.YouTubeMusic.main('YouTube') | clash }}
{{ remoteSnippets.YouTube.main('YouTube') | clash }}
{{ remoteSnippets.DisneyPlus.main('DisneyPlus') | clash }}
{{ remoteSnippets.Pornhub.main('Stream') | clash }}
{{ remoteSnippets.Netflix.main('Netflix') | clash }}

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
