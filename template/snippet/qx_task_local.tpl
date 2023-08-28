# 机场流量 (By Peng-YM)
0 9 * * * flow.js, tag=机场流量, img-url=https://raw.githubusercontent.com/Orz-3/task/master/airport.png, enabled=true

# 美团
#打开 APP , 然后手动签到 1 次, (`首页` > `红包签到`)
10 0 * * * https://raw.githubusercontent.com/chavyleung/scripts/master/meituan/meituan.js, tag=美团, img-url=https://raw.githubusercontent.com/Orz-3/task/master/meituan.png,enabled=true

# NGA刮墙 (by chouchoui)
# 杀掉NGA后台并重新打开NGA，提示Cookie获取成功
10 0 * * * https://raw.githubusercontent.com/chouchoui/QuanX/master/Scripts/nga/nga.js, tag=NGA刮墙, enabled=true, img-url=https://raw.githubusercontent.com/Orz-3/task/master/nga.png

# 网易云音乐
#1. 先登录: <https://music.163.com/m/login>
#2. 再访问: <https://music.163.com/#/user/level>
#3. 提示: `获取会话: 成功!`
10 0 * * * https://raw.githubusercontent.com/chavyleung/scripts/master/neteasemusic/quanx/neteasemusic.js, tag=网易云音乐, img-url=https://raw.githubusercontent.com/Orz-3/task/master/Netease.png,enabled=true

# 京东
#浏览器登录 https://bean.m.jd.com 点击签到并且出现签到日历
1,3 0 * * * https://raw.githubusercontent.com/NobyDa/Script/master/JD-DailyBonus/JD_DailyBonus.js, tag=京东, img-url=https://raw.githubusercontent.com/Orz-3/task/master/jd.png,enabled=true


