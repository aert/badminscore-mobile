# app.js

# Namespace
Badminscore = new Backbone.Marionette.Application()
Badminscore.Views = {}
Badminscore.controller = null
Badminscore.router = null
Badminscore.layout = null

# Regions
Badminscore.addRegions(
    rgNavigation: "#navigation"
    rgContent: "#content"
)

# Initializer
Badminscore.addInitializer((options) ->
    Badminscore.controller = new Badminscore.MainController()
    Badminscore.router = new Badminscore.MainRouter(controller: Badminscore.controller)

    Backbone.history.start()
)
