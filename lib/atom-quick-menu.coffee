AtomQuickMenuDialog = require './atom-quick-menu-dialog'
AtomQuickMenuView = require './atom-quick-menu-view'

module.exports =
class AtomQuickMenu
  settings: {
    "menu": [],
    "max_level": 50,
    "silent": true,
    "save_selected": true
  }

  tmp: {
    "menu": null,
    "select": null,
    "workspace": null,
    "callback": null,
    "atom": true,
    "level": 0
  }

  constructor: (menu=[], silent=true, save_selected=true, max_level=50) ->
    @settings["menu"] = menu
    @settings["max_level"] = max_level
    @settings["silent"] = silent
    @settings["save_selected"] = save_selected

  set: (key, value) ->
    @settings[key] = value

  setMenu: (name, menu) ->
    @settings["menu"][name] = menu

  show: (workspace, on_done, menu, action, level=0) ->
    # selected_index = -1

    if not workspace? and @tmp["workspace"]?
      workspace = @tmp["workspace"]
      @tmp["workspace"] = null

    if not workspace?
      if not @settings["silent"]
        #error
        alert "No workspace to show"
      return

    if not on_done? and @tmp["callback"]?
      on_done = @tmp["callback"]

    if not @settings["menu"]? or "main" not of @settings["menu"] or "items" not of @settings["menu"]["main"]
      if not @settings["silent"]
        #error
        alert "No menu to show"
      return

    if not menu? and @tmp["menu"]
      menu = @tmp["menu"]
      @tmp["menu"] = null

    if not menu? or "items" not of menu
      menu = @settings["menu"]["main"]

    if not action? and @tmp["select"]?
      action = @tmp["select"]
      @tmp["select"] = null

    if action?
      if "name" of action
        if action["name"] not of @settings["menu"]
          if not @settings["silent"]
            #error
            alert "No menu found"
          return
        menu = @settings["menu"][action["name"]]

        if "item" of action and "actions" of menu
          if level >= @settings["max_level"]
            if not @settings["silent"]
              #msg
              alert "Seem like menu go into too many levels now..."
            return
          if menu["actions"].length < action["item"]
            if not @settings["silent"]
              #msg
              alert "Invalid menu selection"
            return
          @tmp["atom"] = false
          @show workspace, on_done, menu, menu["actions"][action["item"]-1], level+1
          return
      else if "command" of action
        if "args" of action
          if action["command"] == "message_dialog"
            #msg
            alert action["args"]
          else if action["command"] == "error_dialog"
            #error
            alert action["args"]
          else
            #run command
            alert "Run command..."
        return
      else if not @settings["silent"]
        #msg
        alert "No action assigned"
        return
      else
        return

    # if "selected_index" of menu and menu["selected_index"] > 0
    #   selected_index = menu["selected_index"]-1
    # if @settings["save_selected"] and "previous_selected_index" of menu and menu["previous_selected_index"] >= 0
    #   selected_index = menu["previous_selected_index"]

    @tmp["menu"] = menu
    @tmp["workspace"] = workspace
    @tmp["callback"] = on_done
    @tmp["level"] = @tmp["level"]+1

    # new AtomQuickMenuDialog "Hello, World!"
    new AtomQuickMenuView menu["items"]
    return

  select: (item) ->
    alert item
    if @tmp["callback"]?
      @tmp["callback"] item
    if item < 0
      @tmp["menu"] = null
      @tmp["select"] = null
      @tmp["workspace"] = null
      @tmp["callback"] = null
      @tmp["atom"] = true
      @tmp["level"] = 0
      return
    if "actions" of @tmp["menu"] and @tmp["menu"]["actions"].length > item
      @tmp["menu"]["previous_selected_index"] = item
      @tmp["select"] = @tmp["menu"]["actions"][index]
      @tmp["atom"] = false
      @show
    return
