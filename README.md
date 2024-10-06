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
    :nmap <F9> :call MessagePanelHandle("m t")<CR>
    ```
### flags
   - `m` - Add Message Type in panel
   - `t` - Add Message receive/send time in panel
### Ignoring messages by pattern:
```vim
    :call PanelAddPattern(<pattern>)
    :call PanelAddPattern("DASHBOARDPARAM-.*")
    :call PanelClearPatter()
```
## UI
### General View
![image](https://github.com/user-attachments/assets/0c7fb8d8-5e7c-4bf5-89fb-8ceaf0ecb3eb)
### Search View
![image](https://github.com/user-attachments/assets/d164a2c7-a08f-4062-8978-f3b1cc7a0650)
### Sorting View
![image](https://github.com/user-attachments/assets/d87bc687-b950-48eb-9bb3-2743e21ede25)


