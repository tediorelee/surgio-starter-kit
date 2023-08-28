# https://github.com/crossutility/Quantumult-X/blob/master/sample.conf

{% set img_baseURL = 'https://raw.githubusercontent.com/Orz-3/mini/master/Color/' %}

[general]
server_check_url=http://cp.cloudflare.com/generate_204
;running_mode_trigger=filter, filter, XXXXLLLLLXXXX_5G:all_direct, XXXXLLLLLXXXX: all_direct
resource_parser_url= https://cdn.jsdelivr.net/gh/KOP-XIAO/QuantumultX@master/Scripts/resource-parser.js

# DNS 排除列表
# dns_exclusion_list 包含了禁用占位符 IP (240.*) 的域，不在 dns_exclusion_list 中的域都启用了占位符 IP，并打开了 resolve-on-remote 设置。
;dns_exclusion_list = *.cmpassport.com, *.jegotrip.com.cn, *.icitymobile.mobi, id6.me, *.icitymobile.mobi, *.pingan.com.cn, *.cmbchina.com, *.localnetwork.uop, mfs.ykimg.com*.ttf

[dns]
server=223.5.5.5
server=114.114.114.114
server=119.29.29.29


[server_remote]
{% if customParams.tediorelee_sub %}
  {{ getDownloadUrl('Tediorelee_subscribe.conf') }}, tag=Flower, img-url={{ img_baseURL }}Flower.png, enabled=true
{% endif %}

{% if customParams.tuc %}
  {{ getDownloadUrl('Tuc_subscribe.conf') }}, tag=Maying_TUC, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/MAYING.png, enabled=true
{% endif %}

{% if customParams.gyh %}
  {{ getDownloadUrl('mayingLX_subscribe.conf') }}, tag=Maying_LX, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/MAYING.png, enabled=true
{{ getDownloadUrl('CNIX_subscribe.conf') }}, tag=CNIX, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/ssrcloud.png, enabled=true
{% endif %}

{% if customParams.jackma %}
  {{ getDownloadUrl('mayingLX_subscribe.conf') }}, tag=Maying_LX, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/MAYING.png, enabled=true
{% endif %}

{% if customParams.feiji %}
  {{ getDownloadUrl('MaYiHan_subscribe.conf') }}, tag=Imm, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/Global.png, enabled=true
{% endif %}


[server_local]

[policy]
static=Outside, 🇺🇲 US, 🇸🇬 Singapore, 🇯🇵 Japan, 🇭🇰 HongKong, 🇨🇳 Taiwan, proxy, direct, img-url={{ img_baseURL }}Global.png
static=Stream, proxy, 🇺🇲 US, 🇸🇬 Singapore, 🇯🇵 Japan, 🇭🇰 HongKong, 🇨🇳 Taiwan, img-url={{ img_baseURL }}Streaming.png
static=YouTube, proxy, 🇺🇲 US, 🇸🇬 Singapore, 🇯🇵 Japan, 🇭🇰 HongKong, 🇨🇳 Taiwan, img-url={{ img_baseURL }}YouTube.png
static=Netflix, proxy, 🇺🇲 US, 🇸🇬 Singapore, 🇯🇵 Japan, 🇭🇰 HongKong, 🇨🇳 Taiwan, img-url={{ img_baseURL }}Netflix.png
static=HBO, proxy, 🇺🇲 US, 🇸🇬 Singapore, 🇯🇵 Japan, 🇭🇰 HongKong, 🇨🇳 Taiwan, img-url={{ img_baseURL }}HBO.png
static=DisneyPlus, proxy, 🇺🇲 US, 🇸🇬 Singapore, 🇯🇵 Japan, 🇭🇰 HongKong, 🇨🇳 Taiwan, img-url={{ img_baseURL }}DisneyPlus.png
static=Emby, proxy, 🇺🇲 US, 🇸🇬 Singapore, 🇯🇵 Japan, 🇭🇰 HongKong, 🇨🇳 Taiwan, img-url={{ img_baseURL }}Emby.png
static=Final, proxy, direct, 🇺🇲 US, 🇸🇬 Singapore, 🇯🇵 Japan, 🇭🇰 HongKong, 🇨🇳 Taiwan, img-url={{ img_baseURL }}Final.png
round-robin=🇺🇲 US, {{ getNodeNames(nodeList, usFilter) }}, img-url={{ img_baseURL }}US.png
round-robin=🇸🇬 Singapore, {{ getNodeNames(nodeList, singaporeFilter) }}, img-url={{ img_baseURL }}SG.png
round-robin=🇯🇵 Japan, {{ getNodeNames(nodeList, japanFilter) }}, img-url={{ img_baseURL }}JP.png
round-robin=🇭🇰 HongKong, {{ getNodeNames(nodeList, hkFilter) }}, img-url={{ img_baseURL }}HK.png
round-robin=🇨🇳 Taiwan, {{ getNodeNames(nodeList, taiwanFilter) }}, img-url={{ img_baseURL }}TW.png
static=Apple, direct, 🇺🇲 US, 🇸🇬 Singapore, 🇯🇵 Japan, 🇭🇰 HongKong, 🇨🇳 Taiwan, img-url={{ img_baseURL }}Apple.png
static=Apple CDN, direct, Apple, img-url={{ img_baseURL }}Apple.png

[filter_remote]
{% include './snippet/qx_filter_remote.tpl' %}

[filter_local]
{% include './snippet/qx_filter_local.tpl' %}

[rewrite_remote]
{% include './snippet/qx_rewrite_remote.tpl' %}

[rewrite_local]
(.*video_id=\w{32})(.*watermark=)(.*) url 302 $1
(?<=(carrier|sys)_region=)CN url 307 US
(?<=version_code=)\d{1,}.\d{1}\.\d{1} url 307 8.0.0

[task_local]
# 按需求自己选择和修改时间定时脚本
{# {% if customParams.tediorelee %}

    {% include './snippet/qx_task_local.tpl' %}

{% endif %} #}

event-interaction https://raw.githubusercontent.com/KOP-XIAO/QuantumultX/master/Scripts/nf_ytb_ui-check.js, tag=YouTube/Netflix 解锁查询, img-url=checkmark.seal.system, enabled=true

[mitm]
passphrase = 56E32DE3
p12 = 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
;hostname = *.googlevideo.com
