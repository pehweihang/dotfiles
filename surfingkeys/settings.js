settings.omnibarPosition = "bottom"
settings.focusFirstCandidate = true
settings.hintAlign = "left"
settings.hintExplicit = true
api.unmap('e');
api.unmap('p');
api.unmap('H')
api.unmap('L')
api.unmap('ZZ')
api.unmap('ZR')
api.unmap('T')
api.unmap('af')
api.unmap('F')
api.unmap('B')
// scroll half page up
api.map('u', 'e');

// forward in history
api.map('L', 'D')
// backward in history
api.map('H', 'S')

// previous tab
api.map('J', 'R')
// next tab
api.map('K', 'E')

// open link in new tab
api.map("F", "gf")

const hintsCss =
  "font-family: 'JetBrains Mono NL', 'Cascadia Code', 'Helvetica Neue', Helvetica, Arial, sans-serif; color: #292c3c !important; background: #f2d5cf; border-color: #292c3c;" ;

api.Hints.style(hintsCss);
api.Hints.style(hintsCss, "text");

// set theme
settings.theme = `
@import url('https://unpkg.com/@catppuccin/palette/css/catppuccin.css');
.sk_theme {
    background: var(--ctp-frappe-base);
    color: var(--ctp-frappe-text);
}
.sk_theme input {
    color: var(--ctp-frappe-text);
}
.sk_theme .url {
    color: var(--ctp-frappe-rosewater);
}
.sk_theme .annotation {
    color: var(--ctp-frappe-text);
}
.sk_theme kbd {
    background: var(--ctp-frappe-overlay0);
    color: var(--ctp-frappe-base);
}
.sk_theme .frame {
    background: #0f0;
}
.sk_theme .omnibar_highlight {
    color: var(--ctp-frappe-blue);
}
.sk_theme .omnibar_folder {
    color: #4b3acc;
}
.sk_theme .omnibar_timestamp {
    color: var(--ctp-frappe-overlay0);
}
.sk_theme .omnibar_visitcount {
    color: var(--ctp-frappe-peach);
}
.sk_theme .prompt, .sk_theme .resultPage {
    color: #aaa;
}
.sk_theme .feature_name {
    color: var(--ctp-frappe-rosewater);
}
.sk_theme .separator {
    color: var(--ctp-frappe-rosewater);
}

body {
    margin: 0;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 12px;
}
#sk_omnibar {
    overflow: hidden;
    position: fixed;
    width: 80%;
    max-height: 80%;
    left: 10%;
    text-align: left;
    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.8);
    z-index: 2147483000;
}
.sk_omnibar_middle {
    top: 10%;
    border-radius: 4px;
}
.sk_omnibar_bottom {
    bottom: 0;
    border-radius: 4px 4px 0px 0px;
}
#sk_omnibar span.omnibar_highlight {
    text-shadow: 0 0 0.01em;
}
#sk_omnibarSearchArea .prompt, #sk_omnibarSearchArea .resultPage {
    display: inline-block;
    font-size: 20px;
    width: auto;
}
#sk_omnibarSearchArea>input {
    display: inline-block;
    width: 100%;
    flex: 1;
    font-size: 20px;
    margin-bottom: 0;
    padding: 0px 0px 0px 0.5rem;
    background: transparent;
    border-style: none;
    outline: none;
}
#sk_omnibarSearchArea {
    display: flex;
    align-items: center;
    border-bottom: 1px solid var(--ctp-frappe-overlay0);
}
.sk_omnibar_middle #sk_omnibarSearchArea {
    margin: 0.5rem 1rem;
}
.sk_omnibar_bottom #sk_omnibarSearchArea {
    margin: 0.2rem 1rem;
}
.sk_omnibar_middle #sk_omnibarSearchResult>ul {
    margin-top: 0;
}
.sk_omnibar_bottom #sk_omnibarSearchResult>ul {
    margin-bottom: 0;
}
#sk_omnibarSearchResult {
    max-height: 60vh;
    overflow: hidden;
    margin: 0rem 0.6rem;
}
#sk_omnibarSearchResult:empty {
    display: none;
}
#sk_omnibarSearchResult>ul {
    padding: 0;
}
#sk_omnibarSearchResult>ul>li {
    padding: 0.2rem 0rem;
    display: flex;
    align-items: center;
    max-height: 600px;
    overflow-x: hidden;
    overflow-y: auto;
}

.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    background: var(--ctp-frappe-base);
}

.sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: var(--ctp-frappe-surface0);
}
.sk_theme #sk_omnibarSearchResult>ul>li.window {
    border: 0px solid var(--ctp-frappe-surface0);
    border-radius: 8px;
    margin: 4px 0px;
}
.sk_theme #sk_omnibarSearchResult>ul>li.window.focused {
    border: 0px solid var(--ctp-frappe-surface0);
    margin: 4px 0px;
}
.sk_theme div.table {
    display: table;
}
.sk_theme div.table>* {
    vertical-align: middle;
    display: table-cell;
}
#sk_omnibarSearchResult li .icon {
    margin-right: 0.5rem;
    width: 16px;
}
#sk_omnibarSearchResult li div.title {
    text-align: left;
}
#sk_omnibarSearchResult li div.url {
    font-weight: bold;
    white-space: nowrap;
}
#sk_omnibarSearchResult li.focused div.url {
    white-space: nowrap;
}
#sk_omnibarSearchResult li span.annotation {
    float: right;
}
#sk_omnibarSearchResult .tab_in_window {
    display: inline-block;
    padding: 5px;
    margin: 5px;
    box-shadow: 0px 2px 10px rgb(0 0 0 / 88%);
}
#sk_status {
    position: fixed;
    bottom: 0;
    right: 20%;
    z-index: 2147483000;
    padding: 4px 8px 0 8px;
    border-radius: 4px 4px 0px 0px;
    border: 1px solid var(--ctp-frappe-surface0);
    font-size: 12px;
}
#sk_status>span {
    line-height: 16px;
}

.expandRichHints span.annotation {
    padding-left: 4px;
    color: var(--ctp-frappe-text);
}
.expandRichHints .kbd-span {
    min-width: 30px;
    text-align: right;
    display: inline-block;
}
.expandRichHints kbd>.candidates {
    color: var(--ctp-frappe-rosewater);
    font-weight: bold;
}
.expandRichHints kbd {
    padding: 1px 2px;
}
#sk_find {
    border-style: none;
    outline: none;
}
#sk_keystroke {
    padding: 6px;
    position: fixed;
    float: right;
    bottom: 0px;
    z-index: 2147483000;
    right: 0px;
    background: var(--ctp-frappe-mantle);
    color: var(--ctp-frappe-text);
}
#sk_usage, #sk_popup, #sk_editor {
    overflow: auto;
    position: fixed;
    width: 80%;
    max-height: 80%;
    top: 10%;
    left: 10%;
    text-align: left;
    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.8);
    z-index: 2147483298;
    padding: 1rem;
}
#sk_nvim {
    position: fixed;
    top: 10%;
    left: 10%;
    width: 80%;
    height: 30%;
}
#sk_popup img {
    width: 100%;
}
#sk_usage>div {
    display: inline-block;
    vertical-align: top;
}
#sk_usage .kbd-span {
    width: 80px;
    text-align: right;
    display: inline-block;
}
#sk_usage .feature_name {
    text-align: center;
    padding-bottom: 4px;
}
#sk_usage .feature_name>span {
    border-bottom: 2px solid var(--ctp-frappe-rosewater);
}
#sk_usage span.annotation {
    padding-left: 32px;
    line-height: 22px;
}
#sk_usage * {
    font-size: 10pt;
}
kbd {
    white-space: nowrap;
    display: inline-block;
    padding: 3px 5px;
    font: 11px Consolas, "Liberation Mono", Menlo, Courier, monospace;
    line-height: 10px;
    vertical-align: middle;
    border: solid 1px var(--ctp-frappe-overlay1);
    border-bottom-color: var(--ctp-frappe-overlay2);
    border-radius: 3px;
    box-shadow: inset 0 -1px 0 var(--ctp-frappe-overlay1);
}
#sk_banner {
    padding: 0.5rem;
    position: fixed;
    left: 10%;
    top: -3rem;
    z-index: 2147483000;
    width: 80%;
    border-radius: 0px 0px 4px 4px;
    border: 1px solid var(--ctp-frappe-surface0);
    border-top-style: none;
    text-align: center;
    background: var(--ctp-frappe-crust);
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    color: var(--ctp-frappe-text)
}
#sk_tabs {
    position: fixed;
    top: 0;
    left: 0;
    background: #000;
    overflow: auto;
    z-index: 2147483000;
}
#sk_tabs.horizontal {
    width: 100%;
}
#sk_tabs.horizontal div.sk_tab {
    display: inline-grid;
}
#sk_tabs.horizontal div.sk_tab_hint {
    float:right;
}
#sk_tabs.vertical div.sk_tab_title {
    min-width: 100pt;
    max-width: 60vw;
}
#sk_tabs.vertical div.sk_tab_hint {
    position: fixed;
    left: 80pt;
}
div.tab_rocket {
    margin: 6px;
    display: inline-block;
    padding: 0px 2px 0px 2px;
    opacity: 0;
}
#sk_tabs.inline div.sk_tab {
    display: inline-block;
}
div.tab_rocket {
    margin: 6px;
    display: inline-block;
    padding: 0px 2px 0px 2px;
    opacity: 0;
}
div.sk_tab {
    vertical-align: bottom;
    justify-items: center;
    border-radius: 3px;
    margin: 1px;
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#DAE6F5), color-stop(100%,#B0CCEF));
    box-shadow: 0px 3px 7px 0px rgba(245, 245, 0, 0.3);
    padding-top: 2px;
    border-top: solid 1px black;
}
div.sk_tab_wrap {
    display: inline-block;
}
div.sk_tab_icon {
    display: inline-block;
    padding-left: 1px;
    vertical-align: middle;
}
div.sk_tab_icon>img {
    width: 18px;
}
div.sk_tab_title {
    display: inline-block;
    vertical-align: middle;
    font-size: 10pt;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    padding-left: 5px;
    color: #000;
}
div.sk_tab_url {
    font-size: 10pt;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    color: #333;
}
div.sk_tab_hint {
    display: inline-block;
    font-size: 10pt;
    font-weight: bold;
    padding: 0px 2px 0px 2px;
    margin: 6px;
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FFF785), color-stop(100%,#FFC542));
    color: #000;
    border: solid 1px #C38A22;
    border-radius: 3px;
    box-shadow: 0px 3px 7px 0px rgba(0, 0, 0, 0.3);
}
#sk_bubble {
    position: absolute;
    padding: 9px;
    border: 1px solid #999;
    border-radius: 4px;
    box-shadow: 0 0 20px rgba(0,0,0,0.5);
    color: #222;
    background-color: #0f0;
    z-index: 2147483000;
    font-size: 14px;
}
#sk_bubble .sk_bubble_content {
    overflow-y: scroll;
    background-size: 3px 100%;
    background-position: 100%;
    background-repeat: no-repeat;
}
.sk_scroller_indicator_top {
    background-image: linear-gradient(rgb(0, 0, 0), transparent);
}
.sk_scroller_indicator_middle {
    background-image: linear-gradient(transparent, rgb(0, 0, 0), transparent);
}
.sk_scroller_indicator_bottom {
    background-image: linear-gradient(transparent, rgb(0, 0, 0));
}
#sk_bubble * {
    color: #000 !important;
}
div.sk_arrow>div:nth-of-type(1) {
    left: 0;
    position: absolute;
    width: 0;
    border-left: 12px solid transparent;
    border-right: 12px solid transparent;
    background: transparent;
}
div.sk_arrow[dir=down]>div:nth-of-type(1) {
    border-top: 12px solid #999;
}
div.sk_arrow[dir=up]>div:nth-of-type(1) {
    border-bottom: 12px solid #999;
}
div.sk_arrow>div:nth-of-type(2) {
    left: 2px;
    position: absolute;
    width: 0;
    border-left: 10px solid transparent;
    border-right: 10px solid transparent;
    background: transparent;
}
div.sk_arrow[dir=down]>div:nth-of-type(2) {
    border-top: 10px solid #ffd;
}
div.sk_arrow[dir=up]>div:nth-of-type(2) {
    top: 2px;
    border-bottom: 10px solid #ffd;
}
.ace_editor.ace_autocomplete {
    z-index: 2147483300 !important;
    width: 80% !important;
}
@media only screen and (max-width: 767px) {
    #sk_omnibar {
        width: 100%;
        left: 0;
    }
    #sk_omnibarSearchResult {
        max-height: 50vh;
        overflow: scroll;
    }
    .sk_omnibar_bottom #sk_omnibarSearchArea {
        margin: 0;
        padding: 0.2rem;
    }
}

#sk_editor {
    height: 50% !important; /*Remove this to restore the default editor size*/
    background: var(--ctp-frappe-base) !important;
}
.ace_dialog-bottom{
    border-top: 0px solid #0f0 !important;
}
.ace-chrome .ace_print-margin, .ace_gutter, .ace_gutter-cell, .ace_dialog{
    background: var(--ctp-frappe-base) !important;
}
.ace-chrome{
    color: var(--ctp-frappe-text) !important;
}
.ace_gutter, .ace_dialog {
    color: var(--ctp-frappe-text) !important;
}
.ace_cursor{
    color: var(--ctp-frappe-rosewater) !important;
}
.normal-mode .ace_cursor{
    background-color: rgba(var(--ctp-frappe-rosewater-rgb) / 0.8); !important;
}
.ace_marker-layer .ace_selection {
    background: var(--ctp-frappe-overlay0) !important;
}
`;
// click `Save` button to make above settings to take effect.</ctrl-i></ctrl-y>