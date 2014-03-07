# {AtomQuickMenuView} = require './atom-quick-menu-view'
AtomQuickMenu = require './atom-quick-menu'

module.exports =
  qm: null
  menu: {
    # Startup menu
    "main": {
      # Its items
      "items": [["Dialogs", "All dialog items"], ["Items...", "Do action on item"], ["Commands...", "Run command"]],
      # Item's actions
      "actions": [
        {
          # Redirect to "dialogs" submenu
          "name": "dialogs"
        }, {
          # Redirect to "items" submenu
          "name": "items"
        }, {
          # Redirect to "commands" submenu
          "name": "commands"
        }
      ]
    },
    # Custom menu named "dialogs"
    "dialogs": {
      # Selected second item as default
      "selected_index": 2,
      "items": [["Back", "Back to previous menu"], ["Message Dialog", "Hello, World on Message Dialog"], ["Error Dialog", "Hello, World on Error Dialog"]],
      "actions": [
        {
          "name": "main",
        }, {
          # This will select "Message Dialog command" on "commands" menu
          "name": "commands",
          "item": 2
        }, {
          "name": "commands",
          "item": 3
        }
      ]
    },
    "items": {
      "selected_index": 2,
      "items": [["Back", "Back to previous menu"], ["Item 2 on Dialogs", "Select item 2 in Dialogs"], ["Item 3 on Dialogs", "Select item 3 in Dialogs"], ["Item 4 on Commands", "Select item 4 in Commands"]],
      "actions": [
        {
          "name": "main",
        }, {
          "name": "dialogs",
          "item": 2
        }, {
          "name": "dialogs",
          "item": 3
        }, {
          "name": "commands",
          "item": 4
        }
      ]
    },
    "commands": {
      "selected_index": 2,
      "items": [["Back", "Back to previous menu"], ["Message Dialog command", "Hello, World on Message Dialog"], ["Error Dialog command", "Hello, World on Error Dialog"], ["Custom command", "Open User's settings file"]],
      "actions": [
        {
          "name": "main",
        }, {
          # Show a message dialog
          "command": "message_dialog",
          "args": "Message: Hello, World"
        }, {
          # Show an error dialog
          "command": "error_dialog",
          "args": "Error: Hello, World"
        }, {
          # Run custom command
          "command": "open_file",
          "args": {
            "file": "${packages}/User/Preferences.sublime-settings"
          }
        }
      ]
    }
  }

  activate: (state) ->
    atom.workspaceView.command "atom-quick-menu:example-code", => @open_file()
    atom.workspaceView.command "atom-quick-menu:demo", => @quick_menu()
    atom.workspaceView.command "atom-quick-menu:submenu-dialog", => @quick_menu(null, {
      "name": "dialogs"
    })
    atom.workspaceView.command "atom-quick-menu:submenu-items", => @quick_menu(null, {
      "name": "items"
    })
    atom.workspaceView.command "atom-quick-menu:submenu-commands", => @quick_menu(null, {
      "name": "commands"
    })
    atom.workspaceView.command "atom-quick-menu:select-item-2-on-commands-menu", => @quick_menu(null, {
      "name": "commands",
      "item": 2
    })
    atom.workspaceView.command "atom-quick-menu:command-hello,-world!", => @quick_menu(null, {
      "command": "message_dialog",
      "args": "Hello, World!"
    })

  open_file: ->
    # Open quick menu file in this package (need package path)
    atom.workspace.open './atom-quick-menu.coffee'

  quick_menu: (menu, action) ->
    # @atomQuickMenuView = new AtomQuickMenuView @menu["main"]["items"]
    if not @qm?
      if menu?
        @menu = menu
      @qm = new AtomQuickMenu @menu
    @qm.show atom.workspace
