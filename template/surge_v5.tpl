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

{{ getSurgeWireguardNodes(nodeList) }}

[Proxy Group]
Outside = select, 🇺🇲 US, 🇭🇰 HongKong, 🇸🇬 Singapore, 🇯🇵 Japan, 🇨🇳 Taiwan, DIRECT
Home = select, DEVICE:HOMEMINI, DEVICE:TV, Unraid WG, DIRECT
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
#Home
IP-CIDR,192.168.2.0/16,Home,no-resolve
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
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Extra/Telegram/TelegramSG.list,Outside,update-interval=21600

# China 中国直连
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/China.list,DIRECT,update-interval=21600

# Unbreak 后续规则修正
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Unbreak.list,DIRECT,update-interval=21600

# Global 全球加速
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Global.list,Outside,update-interval=21600

# Advertising 广告
# DOMAIN-SET,https://raw.githubusercontent.com/NobyDa/ND-AD/master/Surge/AD_Block.txt,AD,update-interval=21600
# DOMAIN-SET,https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-surge2.txt,AD,update-interval=21600
# DOMAIN-SET,https://raw.githubusercontent.com/scomper/surge-list/master/domain-set/adaway.txt,AD,update-interval=21600
# DOMAIN-SET,https://raw.githubusercontent.com/scomper/surge-list/master/domain-set/social-media-filter.txt,AD,update-interval=21600
# RULE-SET,https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Advertising/Advertising.list,AD,update-interval=21600
# DOMAIN-SET,https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Advertising/Advertising_Domain.list,AD,update-interval=21600
# RULE-SET,https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Hijacking/Hijacking.list,AD,update-interval=21600

# RULE-SET,https://anti-ad.net/surge2.txt,AD,update-interval=21600
# RULE-SET,https://raw.githubusercontent.com/NobyDa/ND-AD/master/QuantumultX/AD_Block.txt,AD,update-interval=21600
# RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Advertising.list,AD,update-interval=21600

# Privacy 隐私
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Privacy.list,AD,update-interval=21600

# Hijacking 运营商劫持或恶意网站
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Hijacking.list,AD,update-interval=21600

# Streaming 国际流媒体服务
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/HBO.list,HBO,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Live/Twitch.list,Stream,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Music/Spotify.list,Stream,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Music/SoundCloud.list,Stream,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Music/YouTube-Music.list,YouTube,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Music/Instagram.list,Stream,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/DisneyPlus.list,DisneyPlus,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/Pornhub.list,Stream,update-interval=21600,notification-text="少看点黄色"
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/YouTube.list,YouTube,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/Netflix.list,Netflix,update-interval=21600
RULE-SET,https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/release/rule/Surge/AppleTV/AppleTV.list,Stream,update-interval=21600

# > ASN China
RULE-SET,https://raw.githubusercontent.com/VirgilClyne/GetSomeFries/main/ruleset/ASN.China.list,DIRECT


# Personal
#DOMAIN-SUFFIX,leejieun.fan,DIRECT,notification-text="Where the fuck I am"

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
ca-p12 = MIIKPAIBAzCCCgYGCSqGSIb3DQEHAaCCCfcEggnzMIIJ7zCCBF8GCSqGSIb3DQEHBqCCBFAwggRMAgEAMIIERQYJKoZIhvcNAQcBMBwGCiqGSIb3DQEMAQYwDgQIBcthTxzVEuYCAggAgIIEGEovTHbpAfsyB/z2AYPO/1iKFyyDTvUe2sFMMcA4sR3bougrCUHA3P3bSLSlcGelPjt83in5W7ttrwXCLKWO6dvICoVAOujVleoeUDobZWKpKWQrvVBVMt8paCcF7r6XgkBaANFWsat4uXgBD8ZBLgxycBa98wuDG+0rdhe/Ry6+1JsWkwUz84+gXsJW38yBc8UiJWt4c5+t+f+Pe9wr2lWW8AAZVfvPTvP0U8QQNkmO0U2B0A/0g7YTXqg0TP8V+koVJbbPI3eFdYbkRBQlkMiRufuO0RIXNcBQunTUdtnh39rc6mbwHwfoKlzCzUoXKXqAI7SPEglYI6VGhVo6BApqP2W6pTlDdwAusIH76DTxsTOlO55k5gscJ5TeqTlCpisd/tNyXC8N27sGCis8+03BtWfohs8GiB8mV+Lxu5bi8cBgxL2WoTKyL3f0PlPDaMpRmWd0IWdlRZofXJphY+glwpLzVmXMPbKsgkv2/hxk+A9n6kl1GOfMbIuqREbdWyfwZTAKIGj9J6Ih/5Q2LA0CTXuOVTggfaztoCBJs+roCRx6NXnjs5WdGYj/ESN2rIhLh266rCy1kkzvfhoqBw9ji/hCvzpW9GL07kcvcLi9qh17tPeOiw/Z6TkzxA9fJUaQHApPxblB2hf4HWmGHA6GWKEi8Reul2bBXPBRiZfGlh0+JC2pEuXRxRqd6sJAAMBkqPDaPuQo67ty3DuJfqGyUIONkHgUxeABeST6dCaqxg4T6pH7aJzbYmN3Qi7f3qka0lLRcQtpBd+/vp+piTxwc9g68C17OMoLJ2G7Um91V3wgfK0dR61ntQS7yRW5QlenLxEB8A9x7QaJeZtPvkCrddGFKc3YvYszRwbiYrVDguXMEXHVdGpM/jdEFzm/NLwNoh4A4ePjk8fEU9QJYoW/UCRY2/EOKa4OLlzjK+6b6AFiHN9vu5UJIAqYHGCXreGcarvDmh+Gdn7+2XSnS+sFXSK35CN+ATSnIUNhqUAjnE8Td4RVi7v0bNHwWFIm4cSc2oSda+BJ6tHyG61qVpXQXhYdea0j+T1wPpviApydaz4YsS/tKkp/MhQIpjQ7lMRb+RJM90KxLY180rJWtuQMJCqAhjCLqWJfl8eFUx7/cXI4clEPn05yKvkEXshcOKEYuQJ3qJAiWLUXbx55ssCrZFEiQcHHHzo4WBuBaz4DNWRNmRFtHln3auis2Y1rYuU7ij2bqIEEyL7fHI4j3E409QmNZk08hWjix9ecI0T6PcVkQ/LksBl1yeizwg8kQAjC5ejA3D3svyEeqZoBzP8vmaAtUFG0UpCZ9Dm6JtUy7JgsjiP61qSnb7aK6AjISJdmtINfCjUYpjtoHGAMIf9WWvdwRx3u2Hzvfxuzj1Vt2jMmmQKB3gUwggWIBgkqhkiG9w0BBwGgggV5BIIFdTCCBXEwggVtBgsqhkiG9w0BDAoBAqCCBO4wggTqMBwGCiqGSIb3DQEMAQMwDgQIShx2xvtlpXECAggABIIEyH2Qr5xP65tAFSd+dqKQ6L8sZMlxkVcLVejVtIxBEZeaVmkOPhJb37P8gJQdwUKaZGV+ejwc9fEA/+OoZJ6NcAh5mQ217gvK6Z6L+xVwYv3KAzPMebsAwrHv39/I58ghWKkUSo5/ByzILScPL396m6bwCHCwiOrhjE9VPgmoixHtfAj0aZDRJm71SEgWw5d8QMsUrQ/w/oIxUdpeF0rx/lEiuu5eEmShAIOPp24IgczHhbqV3f/5j7lr0bzBJyrhwi4DqZgfwTVvO+uFFW/+j8SKw1+RHlSzeIZWAPiURw6Qf1qM6CyvtkQ9AMlTfVmrHNWVwltfl6TSsqUsz2r+zPMBFIWphmHRHBIuaM0UIZ6OgNQbcRthsQlX7WLCB8MwLv9LG5sWr/RB6Q5/3SG32XdQY+u9TRCWx5QiZ8nN/laFuFbmrhCXj3S22WkGzNOAiMBWd2hbkfMRZxA3diwQLpYvji13JevOScJFTjPEWRweJqalA3fveisiYVItgzPaNSYKtqZYlsf90Zwo5ZVTiGX900//rTk2U5MsR+lM1saUxhd7GhU37hwLBLw0C/CJJlNB8thyUMAx89b2PpCSh9Rz5UhDcErHT0ucL3blqEsQ0TVtgBok+wkeQve0FRiX9HCIjpViTbAcMUpPLKt/Ub4wLTXt8R9aLktoBlDKfiDUik5U98UhTvVx8qZE5rJfV+O2SYdU6G4EdgOeLcDK1+BRMGzaLc+h9CQEpLaBZ0NpirUXjwtFFuS9GhchhgegXllEO9m84u35XUQBPkJzr8rquhbJkBVdf5CVjrGVPACwf+iq3USJqKhh3vQGJNUC2x1MmThIA40XRGQKFPd5umBRowA1+XT2PykpB4JVLU/W7p1bpKz9LBMjxZZx3Rzy1xGxXeY+MEUT+GNqvy+n9KXduevekqaNKYAMa14wSmX+ltAcRoCEZW0HZAtkIn1AQfEFJESM6Q24ZTqJUR5/Fw5buo3SWpNusguEsioCwgCfIQlvPHnaATbYR6N2iy0m5vQgeDXUR06URxPic7ule6lZOO6MyqXuXU+GjAm6uw6U3ssPE72CTEC+zJ5qbMRIqcwE0qoqdRG+viaxFN3oqlSNfkzSYG5vLNhMaPY0ZJRpFiIuDGJBTsBD7jcO/Pn2d71d+0ABglH642lZA78i/ex7LX42JLfkGcHYIWzOHQz7NGXSEPqXUMJioCTJY6Q1b3491SKmPC0PVySZN6hoFSuhacJIvNlOas7CEl41hlcP3CnE5+CE866u+wkKor+fsqX6XzpDbZvVEXnkR16fNhrEIuOtnX8lKwAfDm7VNpKYFfZfsrbiO39613bnw6JrNzeBAPqV2JeFnQOSI9J+d4K+DHvCaN84QdCwx0qJ499awmN7sz6VlQT0iVyOERqPcKpC9QOw3VhJZC1W+oIUwbbgdWTxYgj0m/vcWruhmqHptNY6zO2KGha2ntA40+UIap1UV2Z6V2V2zAHcHOLXgePKg5FyxlBovDWxprZcrUgoLtNk0/0tjLDFgjk/8Ba3iq53g0lbPovVVMohdXNyG6bZ3WILgrpSsQtk0mJ318jAjHmQCqIQnKZkHzxR1N0pnaiD9YQeEQFvP//vIHig6UB1GjjHf3jghTFsMCMGCSqGSIb3DQEJFTEWBBS0NzxTzAURjvkNCAVwrj2yJng1vzBFBgkqhkiG9w0BCRQxOB42AFMAdQByAGcAZQAgAEcAZQBuAGUAcgBhAHQAZQBkACAAQwBBACAARgBCADgAQgA5ADkARQBDMC0wITAJBgUrDgMCGgUABBSaOWQLC4R05pK4FewZqc7guhJ4PQQIdJVAt/jjdUs=

[Script]