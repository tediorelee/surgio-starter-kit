'use strict'
// export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7890
const {
  utils
} = require('surgio')
const {
  categories
} = require('surgio')

/**
 * 使用文档：https://surgio.royli.dev/
 */
module.exports = {
  /**
   * 远程片段
   * 文档：https://surgio.royli.dev/guide/custom-config.html#remotesnippets
   */
  remoteSnippets: [{
    url: 'https://raw.githubusercontent.com/LM-Firefly/Rules/master/Microsoft.list',
    name: 'Microsoft',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/China.list',
    name: 'China',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Unbreak.list',
    name: 'Unbreak',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Global.list',
    name: 'Global',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Advertising.list',
    name: 'Advertising',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Privacy.list',
    name: 'Privacy',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Hijacking.list',
    name: 'Hijacking',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/HBO.list',
    name: 'HBO',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Live/Twitch.list',
    name: 'Twitch',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Music/Spotify.list',
    name: 'Spotify',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Music/SoundCloud.list',
    name: 'SoundCloud',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Music/YouTube-Music.list',
    name: 'YouTubeMusic',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/DisneyPlus.list',
    name: 'DisneyPlus',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/Pornhub.list',
    name: 'Pornhub',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/YouTube.list',
    name: 'YouTube',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/Netflix.list',
    name: 'Netflix',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Extra/Telegram/TelegramSG.list',
    name: 'TelegramSG',
  },
  {
    url: 'https://raw.githubusercontent.com/Tartarus2014/For-own-use/master/Ruleset/Clash/Game.list',
    name: 'Games',
  },
  {
    url: 'https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/StreamingMedia/Video/Prime-Video.list',
    name: 'PrimeVideo',
  },
  ],
  /**
    * 自定义过滤器
    */
  customFilters: {
    EmbyFilter: (nodeConfig) => nodeConfig.nodeName.includes('0.3x'),
    mayingExtraNodeFilter: utils.discardKeywords(['应急续费节点']),
  },
  artifacts: [
    /**
     * Surge
     */
    {
      name: 'Surge5.conf', // 新版 Surge
      template: 'surge_v5',
      provider: 'example',
      categories: [categories.SURGE],
    },

    /**
     * Clash
     */
    {
      name: 'Clash.yaml',
      template: 'auto_clash',
      provider: 'example',
      categories: [categories.CLASH],
    },

    /**
     * Quantumult X
     */
    {
      name: 'QX.conf',
      template: 'quantumultx',
      provider: 'example',
      categories: [categories.QUANTUMULT_X],
    },
    {
      name: 'QX_subscribe.conf',
      template: 'quantumultx_subscribe',
      provider: 'example',
      categories: [categories.QUANTUMULT_X_SERVER],
    },
  ],

  urlBase: 'https://xxxxx.netlify.app/get-artifact/',

  surgeConfig: {
    v2ray: 'native',
  },
  analytics: true,

  gateway: {
    auth: true,
    accessToken: 'token',
    viewerToken: 'token',
  },
}
