# vim:fileencoding=utf-8:ft=conf:foldmethod=marker

#Autoconfig {{{
#Autoload options set from browser
config.load_autoconfig()
#AutoconfigEnd }}}

#Adblock {{{
#adblock
import sys, os
sys.path.append(os.path.join(sys.path[0], 'jblock'))
config.source("jblock/jblock/integrations/qutebrowser.py")

#Adblock toggle lines
c.content.host_blocking.enabled = False
c.content.host_blocking.lists = ['https://easylist.to/easylist/easylist.txt']
#AdblockEnd }}}

#Colors {{{
#pywal colors
import sys, os
HOME=os.path.expanduser('~')
sys.path.append(f'{HOME}/.cache/wal')
from colorspython import *

black = color0
red = color1
green = color2
yellow = color3
blue = color4
magenta = color5
cyan = color6
white = color7
gray = color8
lighter = color16

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
c.colors.downloads.stop.bg = lighter
c.colors.downloads.stop.fg = foreground
c.colors.downloads.start.bg = red
c.colors.downloads.start.fg = foreground
c.colors.hints.bg = lighter
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
c.colors.tabs.selected.even.bg = lighter
c.colors.tabs.selected.even.fg = foreground
c.colors.tabs.selected.odd.bg = lighter
c.colors.tabs.selected.odd.fg = foreground
#ColorsEnd }}}

#Bindings And Commands {{{
c.aliases['jblock-disabled-window'] = 'spawn --userscript configwithhostblocking'
c.aliases['adblock-start'] = 'adblock-update;; reload'
c.aliases['pywal'] = 'spawn --userscript updatecolors;; config-source ~/.config/qutebrowser/colorsconfig.py'
config.bind('U', 'spawn --userscript configwithoutjblock;; config-source ~/.config/qutebrowser/configwithoutjblock.py')

c.downloads.location.directory = f'{HOME}/downloads'
c.downloads.location.remember = True
config.bind(',w', 'set downloads.location.directory ~/pix/wallpapers/;; hint links download')
config.bind(',h', 'set downloads.location.directory ~/;; hint links download')
config.bind(',d', 'set downloads.location.directory ~/downloads/;; hint links download')
config.bind(',o', 'set downloads.location.directory ~/pix/other/;; hint links download')
config.bind(',v', 'set downloads.location.directory ~/videos/Other;; hint links download')
config.bind(',p', 'set downloads.location.directory ~/other/podcasts/;; download')

config.bind(',ar', 'open -t file:///home/iheb/.config/transliteration/transliteration.html')
config.bind('sh', 'spawn thumbnailfilepicker')
config.bind(',m', 'spawn --userscript view_in_mpv')
config.bind(',i', 'hint images run open -t {hint-url}')
config.bind(',g', 'spawn --userscript changetogoogle')
config.bind('C', 'tab-clone -w;; tab-close')
config.bind(',y', 'hint links yank')
config.bind(',fp', 'hint links userscript follow4chan')
config.bind('<Ctrl+h>', 'history -t')
config.bind('<Ctrl+j>', 'tab-move +')
config.bind('<Ctrl+k>', 'tab-move -')
config.bind('C', 'tab-clone -w;; tab-close')
config.bind('sh', 'spawn thumbnailfilepicker')
config.bind(',ug', 'greasemonkey-reload')
config.bind('E', 'open-editor')
config.bind('tap', 'config-cycle content.autoplay true false ;; reload')
config.bind(',D', 'hint all delete')
#Bindings And Commands End }}}

#Other Options {{{
c.fonts.downloads = '9pt DejaVu Sans'
c.fonts.prompts = '10pt DejaVu Sans'
c.fonts.tabs = '9pt DejaVu Sans'
c.fonts.default_family = 'monospace'
c.fonts.default_size = '11pt'

c.fonts.hints = '11pt DejaVu Sans Bold'
c.hints.border = '1px solid ' + foreground

c.completion.web_history.max_items = 0

c.content.cookies.store = True

c.input.insert_mode.auto_load = False
c.input.insert_mode.leave_on_load = False

c.tabs.indicator.width = 0

c.editor.command = ['kitty', '-e', 'nvim', '{}']

c.url.default_page = f'file://{HOME}/.config/homepage/index.html'
c.url.start_pages = [f'file://{HOME}/.config/homepage/index.html']

c.url.open_base_url = True
c.url.searchengines = {"DEFAULT": "https://www.google.com/search?q={}","&git":"https://github.com/search?type=Code&q={}","&rbt":"https://archive.rebeccablacktech.com/g/search/text/{}/","&wf": "https://fr.wikipedia.org/wiki/Spécial:Recherche?search={}","&we": "https://en.wikipedia.org/wiki/Special:Search?search={}","&py": "https://docs.python.org/3/search.html?q={}&check_keywords=yes&area=default"}

c.qt.args=["ignore-gpu-blacklist", "enable-gpu-rasterization", "enable-native-gpu-memory-buffers", "num-raster-threads=4"]
#Other Options End }}}
