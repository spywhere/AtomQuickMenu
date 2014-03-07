AtomQuickMenu = require '../lib/atom-quick-menu'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomQuickMenu", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('atomQuickMenu')

  describe "when the atom-quick-menu:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.atom-quick-menu')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'atom-quick-menu:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.atom-quick-menu')).toExist()
        atom.workspaceView.trigger 'atom-quick-menu:toggle'
        expect(atom.workspaceView.find('.atom-quick-menu')).not.toExist()
