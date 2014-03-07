## Atom QuickMenu

A quick panel utility for Atom packages

[This will be a screenshot for Atom QuickMenu]

### Features
 * Submenu, Redirecting items
 * Dynamic menu system

### Installation and Package Integration
Under development...

### Setup Menus
To setup a menu, you will need a menu and variable to store an instance of QuickMenu.

```
qm = None
```

To create a menu just using Dict with one element with your menu name as a key with a list of item inside.

```
menu = {
  "<Menu Name>": {
    "items": <List of item you want to display>
  }
}
```

and when you are ready to show it just using...

```
unless @qm?
  @qm = new QuickMenu(@menu)
@qm show(atom.workspace)
```

**IMPORTANT: Every menu must have "main" as a startup menu**

### Setup Menu Interaction
Once you have a menu to display, you will need some interactions with it, like go to submenu or run commands. To make items interactible, add a new list named "actions" into your menu.

```
menu = {
  "<Menu Name>": {
    "items": <List of items you want to display>
    "actions": [<List of actions order by item's index>]
  }
}
```

and then add an action order by your item's index. (Action format see below)

### Action Format
Item action can be use in many ways. These are all possible actions can be used by your items...

* Open a submenu
* Select an item from other submenu (redirect)
* Show a message dialog
* Show an error dialog
* Run command (with arguments)

#### Submenu
To make items go to a submenu, use a Dict with string named "name"...

```
{
  "name": "<Menu Name>"
}
```

#### Redirecting
To make items redirect itself to another item on the same or different submenu, use a Dict with following format...

```
{
  "name": "<Menu Name>",
  "item": <A index of item starts from 1>
}
```

#### Message Dialog
To make items show a message dialog, use a Dict with following format...

```
{
  "command": "message_dialog",
  "args": "<Your text goes here>"
}
```

#### Error Dialog
To make items show an error dialog, use a Dict with following format...

```
{
  "command": "error_dialog",
  "args": "<Your text goes here>"
}
```

#### Run Command
To make items run a command, use a Dict with following format...

```
{
  "command": "<Your command goes here>",
  "args": <A Dict of arguments>
}
```

### Example
You can see and try an example of QuickMenu within file named "atom-quick-menu-main.coffee" or type `QuickMenu: Example Code` in command palette.

### API
Under development... It would be similar to QuickMenu for Sublime API
