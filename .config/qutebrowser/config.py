config.load_autoconfig()
#######################################################
#adblock
#DO NOT CHANGE THE POSITION OF THE ADBLOCK LINES
import sys, os
sys.path.append(os.path.join(sys.path[0], 'jblock'))
config.source("jblock/jblock/integrations/qutebrowser.py")

#Adblock toggle lines
c.content.host_blocking.enabled = False
c.content.host_blocking.lists = ['https://easylist.to/easylist/easylist.txt']
#######################################################

#pywal colors
from os.path import expanduser
colorsfilepath = expanduser("~") + "/.cache/wal/colors"
f=open(colorsfilepath)
colors = [color.strip() for color in f]
f.close


background = colors[0]
foreground = colors[7]
cursor = colors[7]

black = colors[0]
red = colors[1]
green = colors[2]
yellow = colors[3]
blue = colors[4]
magenta = colors[5]
cyan = colors[6]
white = colors[7]
gray = colors[8]

c.colors.completion.category.bg = red
c.colors.completion.category.border.bottom = red
c.colors.completion.category.border.top = red
c.colors.completion.category.fg = foreground
c.colors.completion.even.bg = background
c.colors.completion.odd.bg = background
c.colors.completion.fg = foreground
c.colors.completion.item.selected.bg = red
c.colors.completion.item.selected.border.bottom = background
c.colors.completion.item.selected.border.top = background
c.colors.completion.item.selected.fg = foreground
c.colors.completion.match.fg = yellow
c.colors.completion.scrollbar.bg = background
c.colors.completion.scrollbar.fg = gray
c.colors.downloads.bar.bg = background
c.colors.downloads.error.bg = red
c.colors.downloads.error.fg = foreground
c.colors.downloads.stop.bg = red
c.colors.hints.bg = red
c.colors.hints.fg = foreground
c.colors.hints.match.fg = yellow
c.colors.keyhint.bg = background
c.colors.keyhint.fg = foreground
c.colors.keyhint.suffix.fg = yellow
c.colors.messages.error.bg = red
c.colors.messages.error.border = red
c.colors.messages.error.fg = foreground
c.colors.messages.info.bg = blue
c.colors.messages.info.border = blue
c.colors.messages.info.fg = foreground
c.colors.messages.warning.bg = red
c.colors.messages.warning.border = red
c.colors.messages.warning.fg = foreground
c.colors.prompts.bg = background
c.colors.prompts.border = '1px solid ' + background
c.colors.prompts.fg = foreground
c.colors.prompts.selected.bg = magenta
c.colors.statusbar.caret.bg = cyan
c.colors.statusbar.caret.fg = cursor
c.colors.statusbar.caret.selection.bg = cyan
c.colors.statusbar.caret.selection.fg = foreground
c.colors.statusbar.command.bg = background
c.colors.statusbar.command.fg = foreground
c.colors.statusbar.command.private.bg = background
c.colors.statusbar.command.private.fg = foreground
c.colors.statusbar.insert.bg = green
c.colors.statusbar.insert.fg = background
c.colors.statusbar.normal.bg = background
c.colors.statusbar.normal.fg = foreground
c.colors.statusbar.passthrough.bg = blue
c.colors.statusbar.passthrough.fg = foreground
c.colors.statusbar.private.bg = background
c.colors.statusbar.private.fg = foreground
c.colors.statusbar.progress.bg = foreground
c.colors.statusbar.url.error.fg = red
c.colors.statusbar.url.fg = foreground
c.colors.statusbar.url.hover.fg = blue
c.colors.statusbar.url.success.http.fg = foreground
c.colors.statusbar.url.success.https.fg = gray
c.colors.statusbar.url.warn.fg = red
c.colors.tabs.bar.bg = background
c.colors.tabs.even.bg = background
c.colors.tabs.even.fg = foreground
c.colors.tabs.indicator.error = red
c.colors.tabs.indicator.system = 'none'
c.colors.tabs.odd.bg = background
c.colors.tabs.odd.fg = foreground
c.colors.tabs.selected.even.bg = red
c.colors.tabs.selected.even.fg = foreground
c.colors.tabs.selected.odd.bg = red
c.colors.tabs.selected.odd.fg = foreground


c.aliases['jblock-disabled-window'] = 'spawn --userscript configwithhostblocking'
c.aliases['adblock-start'] = 'adblock-update;; reload'
c.aliases['pywal'] = 'spawn --userscript configwithoutjblock;; config-source ~/.config/qutebrowser/configwithoutjblock.py'
config.bind('U', 'pywal')

c.downloads.location.directory = '/home/iheb/downloads'
c.downloads.location.remember = False
config.bind(',w', 'set downloads.location.directory ~/pix/wallpapers/;; hint links download')
config.bind(',h', 'set downloads.location.directory ~/;; hint links download')
config.bind(',d', 'set downloads.location.directory ~/downloads/;; hint links download')
config.bind(',o', 'set downloads.location.directory ~/pix/other/;; hint links download')
config.bind(',d', 'set downloads.location.directory ~/downloads/;; hint links download')
config.bind(',v', 'set downloads.location.directory ~/videos/Other;; hint links download')
config.bind(',p', 'set downloads.location.directory ~/other/podcasts/;; download')

config.bind('sh', 'spawn thumbnailfilepicker')
config.bind(',m', 'spawn --userscript view_in_mpv')
config.bind('C', 'tab-clone -w;; tab-close')
config.bind(',y', 'hint links yank')
config.bind('<Ctrl+h>', 'history -t')
config.bind('C', 'tab-clone -w;; tab-close')
config.bind('sh', 'spawn thumbnailfilepicker')
config.bind(',ug', 'greasemonkey-reload')
config.bind('E', 'open-editor')
config.bind('tap', 'config-cycle content.autoplay true false ;; reload')

c.fonts.downloads = '9pt DejaVu Sans'
c.fonts.tabs = '9pt DejaVu Sans'
c.fonts.monospace = 'Terminus'
c.fonts.statusbar = '10pt monospace'

c.fonts.hints = '11pt DejaVu Sans Bold'
c.hints.border = '1px solid ' + foreground

c.qt.force_platform = 'wayland'

c.completion.web_history.max_items = 0

c.content.cookies.store = True

c.tabs.indicator.width = 0

c.editor.command = ['kitty', '-e', 'nvim', '{}']

c.url.default_page = 'file:///home/iheb/.config/homepage/index.html'
c.url.start_pages = ['file:///home/iheb/.config/homepage/index.html']

c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
c.content.headers.user_agent = 'Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0'

c.url.searchengines = {"DEFAULT": "http://127.0.0.1:8888/?q={}","&g": "https://www.google.com/search?q={}"}
