{SelectListView} = require 'atom'

module.exports =
class AtomQuickMenuView extends SelectListView
  items: null
  callback: null

  constructor: (items, callback, viewForItem) ->
    if items?
     @items = items
    @callback = callback
    if viewForItem?
     @viewForItem = viewForItem
    super

  initialize: (serializeState) ->
    super
    @addClass('overlay from-top')
    @setItems(@items)
    atom.workspaceView.append(this)
    @focusFilterEditor()

  getFilterKey: ->
    return 0

  viewForItem: (item) ->
    """
    <li class=\"two-lines\">
      <div class=\"primary-line\">#{item[0]}</div>
      <div class=\"secondary-line\">#{item[1]}</div>
    </li>
    """

  confirmed: (item) ->
    alert item
    if callback?
      callback item
    console.log("#{item} was selected")
