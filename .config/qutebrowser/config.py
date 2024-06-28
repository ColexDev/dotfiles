
## Dark mode
config.load_autoconfig()
# config.set("colors.webpage.darkmode.enabled", True)

## I don't even think this works anymore, its supposed to help block youtube ads
from qutebrowser.api import interceptor
def filter_yt(info: interceptor.Request):
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()

interceptor.register(filter_yt)
## Background color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.bg = 'white'

## Foreground color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.fg = 'black'

## Background color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.bg = '#000000'

## Background color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.bg = '#000000'

## Automatically start playing `<video>` elements.
## Type: Bool
c.content.autoplay = False

## Where to show the downloaded files.
## Type: VerticalPosition
## Valid values:
##   - top
##   - bottom
c.downloads.position = 'bottom'

## Duration (in milliseconds) to wait before removing finished downloads.
## If set to -1, downloads are never removed.
# Type: Int
c.downloads.remove_finished = 5000

## Default font families to use. Whenever "default_family" is used in a
## font setting, it's replaced with the fonts listed here. If set to an
## empty value, a system-specific monospace default is used.
## Type: List of Font, or Font
c.fonts.default_family = 'Source Code Pro'

## Default font size to use. Whenever "default_size" is used in a font
## setting, it's replaced with the size listed here. Valid values are
## either a float value with a "pt" suffix, or an integer value with a
## "px" suffix.
## Type: String
c.fonts.default_size = '10pt'

## Rounding radius (in pixels) for the edges of hints.
## Type: Int
c.hints.radius = 0

## Make characters in hint strings uppercase.
## Type: Bool
c.hints.uppercase = True


c.editor.command = ["alacritty", "-e", "nvim", "{file}"]

## Time (in milliseconds) from pressing a key to seeing the keyhint
## dialog.
## Type: Int
c.keyhint.delay = 0

## Rounding radius (in pixels) for the edges of the keyhint dialog.
## Type: Int
c.keyhint.radius = 0

## When/how to show the scrollbar.
## Type: String
## Valid values:
##   - always: Always show the scrollbar.
##   - never: Never show the scrollbar.
##   - when-searching: Show the scrollbar when searching for text in the webpage. With the QtWebKit backend, this is equal to `never`.
##   - overlay: Show an overlay scrollbar. On macOS, this is unavailable and equal to `when-searching`; with the QtWebKit backend, this is equal to `never`. Enabling/disabling overlay scrollbars requires a restart.
c.scrolling.bar = 'never'

## Enable smooth scrolling for web pages. Note smooth scrolling does not
## work with the `:scroll-px` command.
## Type: Bool
c.scrolling.smooth = False

## When to show the statusbar.
## Type: String
## Valid values:
##   - always: Always show the statusbar.
##   - never: Always hide the statusbar.
##   - in-mode: Show the statusbar when in modes other than normal mode.
c.statusbar.show = 'always'

## List of widgets displayed in the statusbar.
## Type: List of String
## Valid values:
##   - url: Current page URL.
##   - scroll: Percentage of the current page position like `10%`.
##   - scroll_raw: Raw percentage of the current page position like `10`.
##   - history: Display an arrow when possible to go back/forward in history.
##   - tabs: Current active tab, e.g. `2`.
##   - keypress: Display pressed keys when composing a vi command.
##   - progress: Progress bar for the current page loading.
c.statusbar.widgets = ['history', 'url', 'scroll', 'history', 'tabs', 'progress']

## Padding (in pixels) around text for tabs.
## Type: Padding
c.tabs.padding = {'top': 0, 'bottom': 0, 'left': 2, 'right': 2}

## Position of the tab bar.
## Type: Position
## Valid values:
##   - top
##   - bottom
##   - left
##   - right
c.tabs.position = 'top'

## When to show the tab bar.
## Type: String
## Valid values:
##   - always: Always show the tab bar.
##   - never: Always hide the tab bar.
##   - multiple: Hide the tab bar if only one tab is open.
##   - switching: Show the tab bar when switching tabs.
c.tabs.show = 'multiple'

## Duration (in milliseconds) to show the tab bar before hiding it when
## tabs.show is set to 'switching'.
## Type: Int
c.tabs.show_switching_delay = 1500

## Open a new window for every tab.
## Type: Bool
# c.tabs.tabs_are_windows = False

## Alignment of the text inside of tabs.
## Type: TextAlignment
## Valid values:
##   - left
##   - right
##   - center
c.tabs.title.alignment = 'left'

## Default zoom level.
## Type: Perc
c.zoom.default = '100%'

## Available zoom levels.
## Type: List of Perc
# c.zoom.levels = ['25%', '33%', '50%', '67%', '75%', '90%', '100%', '110%', '125%', '150%', '175%', '200%', '250%', '300%', '400%', '500%']

c.content.blocking.adblock.lists = ['https://easylist.to/easylist/easylist.txt', 'https://easylist.to/easylist/easyprivacy.txt', 'https://easylist-downloads.adblockplus.org/easylistdutch.txt', 'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt', 'https://www.i-dont-care-about-cookies.eu/abp/', 'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt']

config.bind('1', 'hint all yank')
config.bind('2', 'spawn mpv {url}')
config.bind('3', 'hint links spawn mpv {hint-url}')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('t', 'open -t')
