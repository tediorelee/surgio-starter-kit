#!MANAGED-CONFIG {{ downloadUrl }} interval=43200 strict=true

[General]
# General
http-listen = 0.0.0.0:8888
socks5-listen = 0.0.0.0:8889
external-controller-access = password@0.0.0.0:6170

# Lateracy
internet-test-url = http://wifi.vivo.com.cn/generate_204
proxy-test-url = http://cp.cloudflare.com/generate_204
test-timeout = 3
ipv6 = true
ipv6-vif = auto
show-error-page-for-reject = true

# Advanced
loglevel = notify
exclude-simple-hostnames = true
use-default-policy-if-wifi-not-primary = false
force-http-engine-hosts = boxjs.com, boxjs.net
always-real-ip = *.lan, cable.auth.com, *.msftconnecttest.com, *.msftncsi.com, *.*.*.srv.nintendo.net, *.*.stun.playstation.net, xbox.*.*.microsoft.com, *.*.xboxlive.com, stun.*, localhost.ptlogin2.qq.com, *.logon.battlenet.com.cn, *.logon.battle.net, *.blzstatic.cn, music.163.com, *.music.163.com, *.126.net, musicapi.taihe.com, music.taihe.com, songsearch.kugou.com, trackercdn.kugou.com, *.kuwo.cn, api-jooxtt.sanook.com, api.joox.com, joox.com, y.qq.com, *.y.qq.com, streamoc.music.tc.qq.com, mobileoc.music.tc.qq.com, isure.stream.qqmusic.qq.com, dl.stream.qqmusic.qq.com, aqqmusic.tc.qq.com, amobile.music.tc.qq.com, *.xiami.com, *.music.migu.cn, music.migu.cn, proxy.golang.org, *.mcdn.bilivideo.cn, *.cmpassport.com, id6.me, open.e.189.cn, mdn.open.wo.cn, auth.wosms.cn, *.jegotrip.com.cn, *.icitymobile.mobi, *.pingan.com.cn, *.cmbchina.com, pool.ntp.org, *.pool.ntp.org, ntp.*.com, time.*.com, ntp?.*.com, time?.*.com, time.*.gov, time.*.edu.cn, *.ntp.org.cn, PDC._msDCS.*.*, DC._msDCS.*.*, GC._msDCS.*.*

# DNS
hijack-dns = *:53
dns-server = 119.29.29.29, 223.5.5.5, system
read-etc-hosts = true
doh-skip-cert-verification = true
encrypted-dns-server = https://dns.alidns.com/dns-query
encrypted-dns-follow-outbound-mode = true

# > 跳过代理
skip-proxy = localhost, *.local, passenger.t3go.cn, e.crashlytics.com, captive.apple.com, app.yinxiang.com, injections.adguard.org, local.adguard.org, cable.auth.com, yunbusiness.ccb.com, 10.0.0.0/8, 100.64.0.0/10, 127.0.0.1/32, 169.254.0.0/16, 172.16.0.0/12, 192.168.0.0/16, 224.0.0.0/4, 240.0.0.0/4, ::1/128, fc00::/7, fd00::/8, fe80::/10, ff00::/8, 2001::/32, 2001:db8::/32, 2002::/16, ::ffff:0:0:0:0/1, ::ffff:128:0:0:0/1
# Others
allow-wifi-access = false
hide-vpn-icon = true
allow-hotspot-access = true
# network-framework = true
http-api = tediorelee@0.0.0.0:2500
http-api-web-dashboard = true
all-hybrid = false
wifi-access-http-port = 1314
udp-priority = true

[Replica]
# 0 为关闭，1 为开启
# > 隐藏 Apple 请求
hide-apple-request = 0
# > 隐藏崩溃追踪器请求
hide-crash-reporter-request = 1
# > 隐藏 UDP 会话
hide-udp = 0
# > 关键词过滤器
# none（关闭关键词过滤器） / whitelist（blacklist（仅记录包含关键字的请求）） / blacklist（仅记录不包含关键字的请求） / pattern（匹配通配符的请求）
# keyword-filter-type = none
# > 关键词
# keyword-filter = (null)

[Proxy]
{{ getSurgeNodes(nodeList) }}

[Proxy Group]
Outside = select, 🇺🇲 US, 🇭🇰 HongKong, 🇸🇬 Singapore, 🇯🇵 Japan, 🇨🇳 Taiwan, DIRECT
Stream = select, 🇺🇲 US, 🇭🇰 HongKong, 🇸🇬 Singapore, 🇯🇵 Japan, 🇨🇳 Taiwan
YouTube = select, 🇺🇲 US, 🇭🇰 HongKong, 🇸🇬 Singapore, 🇯🇵 Japan, 🇨🇳 Taiwan
Netflix = select, 🇺🇲 US, 🇭🇰 HongKong, 🇸🇬 Singapore, 🇯🇵 Japan, 🇨🇳 Taiwan
HBO = select, 🇺🇲 US, 🇭🇰 HongKong
DisneyPlus = select, 🇸🇬 Singapore
Proxy = select, {{ getSurgeNodeNames(nodeList) }}
Final = select, Outside, DIRECT
AD = select, REJECT, DIRECT
🇺🇲 US = url-test, {{ getNodeNames(nodeList, usFilter) }}, url = {{ proxyTestUrl }}, interval = 1200
🇭🇰 HongKong = url-test, {{ getNodeNames(nodeList, hkFilter) }}, url = {{ proxyTestUrl }}, interval = 1200
🇸🇬 Singapore = url-test, {{ getNodeNames(nodeList, singaporeFilter) }}, url = {{ proxyTestUrl }}, interval = 1200
🇯🇵 Japan = url-test, {{ getNodeNames(nodeList, japanFilter) }}, url = {{ proxyTestUrl }}, interval = 1200
🇨🇳 Taiwan = url-test, {{ getNodeNames(nodeList, taiwanFilter) }}, url = {{ proxyTestUrl }}, interval = 1200

[Rule]
DOMAIN-SUFFIX,ipw.cn,DIRECT
DOMAIN-SUFFIX,test-ipv6.com,DIRECT

# > Mail
DOMAIN-SUFFIX,smtp,DIRECT

# > Direct(Google|Proxy|Download|Spotify)
RULE-SET,https://raw.githubusercontent.com/bunizao/TutuBetterRules/tutu/RuleList/DOMAlN/Direct.list,DIRECT,update-interval=21600

# Anti-AD
RULE-SET,https://ruleset.isagood.day/reject.conf,REJECT
DOMAIN-SET,https://ruleset.isagood.day/reject_tinygif.conf,REJECT-TINYGIF
DOMAIN-SET,https://ruleset.isagood.day/reject_domain.conf,REJECT
RULE-SET,https://ruleset.isagood.day/reject_drop.conf,REJECT-DROP

# Telegram
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Telegram.list,🇸🇬 Singapore,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/TelegramNL/TelegramNL.list,Proxy,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/TelegramUS/TelegramUS.list,🇺🇲 US,update-interval=21600

# China 中国直连
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/ChinaDomain.list,DIRECT,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/ChinaMedia.list,DIRECT,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/ChinaIp.list,DIRECT,update-interval=21600

# Global 全球加速
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/ProxyGFWlist.list,Outside,update-interval=21600

# Advertising 广告
DOMAIN-SET,https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Advertising/Advertising_Domain.list,AD,update-interval=21600

# Hijacking 运营商劫持或恶意网站
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanEasyPrivacy.list,AD,update-interval=21600

# Streaming 国际流媒体服务
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/ProxyMedia.list,Stream,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/YouTubeMusic.list,YouTube,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/DisneyPlus.list,DisneyPlus,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/YouTube.list,YouTube,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Netflix.list,Netflix,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/release/rule/Surge/AppleTV/AppleTV.list,Stream,update-interval=21600

# > ASN China
RULE-SET,https://raw.githubusercontent.com/VirgilClyne/GetSomeFries/main/ruleset/ASN.China.list,DIRECT

# Rulesets
RULE-SET,SYSTEM,DIRECT

# Surge 的自动 REJECT 保护丢包，防止应用循环请求
IP-CIDR,0.0.0.0/32,REJECT,no-resolve

# LAN
RULE-SET,LAN,DIRECT

# GeoIP CN
GEOIP,CN,DIRECT

# Final
FINAL,Final,dns-failed

[Host]

[URL Rewrite]

[MITM]
skip-server-cert-verify = true
hostname = api.vc.bilibili.com, i.meituan.com, music.163.com, api.m.jd.com, www.google.cn, api.abema.io yunbusiness.ccb.com
hostname-disabled = i.meituan.co
ca-passphrase = FB8B99EC
ca-p12 =

[Script]