{View} = require 'atom'

module.exports =
class AtomQuickMenuDialog extends View
  message: "Placeholder"
  type: "message"

  @content: ->
    @div class: 'overlay from-bottom', =>
      @div @message, class: @type

  constructor: (message, type) ->
    if message?
      @message = message
    if type?
      @type = type
    super

  initialize: (serializeState) ->
    atom.workspaceView.append(this)

  destroy: ->
    @detach()
