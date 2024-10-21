# Incognito_vim_log Vim: Log Highlighter & Analyzer Plugin

## Description

This Vim plugin provides syntax highlighting and analysis tools for specific log files. It supports:

- Syntax highlighting for logs from:
  - `cwmp-proxy`
  - `obuspa`
  - `launcher-lite`
- A dedicated side panel for analyzing `obuspa` logs, allowing:
  - Search functionality within `obuspa` messages
  - Navigation between messages

## Installation

### Using [Vim-Plug](https://github.com/junegunn/vim-plug)

1. Add the following line to your `.vimrc` or `init.vim`:
    ```vim
    Plug 'Abstract-Chief/incognito_vim_log'
    ```
## Use
### Keymaps
   - `S` - Search for a message and jump to the file
   - `R` - Refresh the message and jump to the file
   - `ENTER` - Search for a message only in gile
   - `qs` - Search for a message only in panel
   - `r` - Refresh messages in panel
   - `Q` - Quit the panel
   - `?` - Show help

### Log Highlighting

The plugin automatically activates when opening log files with the `.log` extension. It supports the following log types:

- For `cwmp-proxy`, `obuspa`, and `launcher-lite`

### `obuspa` Log Analysis

For `obuspa` logs, you can use the dedicated side panel for analysis:

1. Open a log file:
    ```bash
    vim obuspa.log
    ```
2. Activate the analysis panel with the command:
    ```vim
    :call MessagePanelHandle("<flag1> <flag2>")
    :nmap <F9> :call MessagePanelHandle("m t d")<CR>
    ```
### flags
   - `i` - Add Message Id in panel
   - `m` - Add Message Type in panel
   - `t` - Add Message receive/send time in panel
   - `d` - Add First message Data param in panel
   - 'uc' - Use custom colors
### Ignoring messages by pattern:
```vim
    :call PanelAddPattern(<pattern>)
    :call PanelAddPattern("DASHBOARDPARAM-.*")
    :call PanelClearPatter()
```
## UI
### General View
![image](https://github.com/user-attachments/assets/e13f9f21-2c85-43c8-adab-f1012affb505)
### Search View
![image](https://github.com/user-attachments/assets/8c0ccfd5-b919-4568-8e62-550c1b72c397)
### All flags View
![image](https://github.com/user-attachments/assets/39a41d34-b8b9-4c4d-a1cb-0343a68ae808)
### Sorting View
![image](https://github.com/user-attachments/assets/64d4fce6-7ab9-4fc3-94b7-c0990031e7e5)



