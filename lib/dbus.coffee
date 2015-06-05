{CompositeDisposable} = require 'atom'

module.exports = Dbus =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable()

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'dbus:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  serialize: -> {}

  toggle: ->
    console.log 'Dbus was toggled!'
