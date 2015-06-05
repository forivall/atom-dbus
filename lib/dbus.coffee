dbus = require 'dbus-native'
{CompositeDisposable} = require 'atom'

module.exports = AtomDbus =
  subscriptions: null
  bus: null
  name: 'io.atom'
  path: -> "/io/atom/#{atom.workspace.id}"
  interface:
    name: 'io.atom.Workspace'
    methods: {
      addFolder: ['s']
    }

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable()

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'dbus:toggle': => @toggle()
    @bus = dbus.sessionBus()

    @bus.requestName(@name, 0)
    console.log @path()
    @bus.exportInterface(@dbusMethods(), @path(), @interface)

  deactivate: ->
    @bus.connection.end()
    @bus = null
    @subscriptions.dispose()

  serialize: -> {}

  dbusMethods: ->
    addFolder: (folderPath) ->
      console.log("adding #{folderPath}")
      atom.project.addPath(folderPath)

  toggle: ->
    console.log 'AtomDbus was toggled!'
