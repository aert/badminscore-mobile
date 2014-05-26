# app.js

# Namespace
Badminscore = new Backbone.Marionette.Application()
Badminscore.Models = {}
Badminscore.Views = {}
Badminscore.controller = null
Badminscore.router = null
Badminscore.layout = null

# Regions
Badminscore.addRegions(
    rgNavigation: "#navigation"
    rgContent: "#content"
)

Marionette.Region.prototype.open = (view) ->
    this.$el.hide()
    this.$el.html(view.el)
    this.$el.fadeIn("slow")

# Initializer
Badminscore.addInitializer((options) ->
    Badminscore.controller = new Badminscore.MainController()
    Badminscore.router = new Badminscore.MainRouter(controller: Badminscore.controller)

    Backbone.history.start()
)
