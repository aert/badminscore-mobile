# app.js

Badminscore = {
    Views: {}
    Extensions: {}
    Router: null

    run: () ->
        this.instance = new Badminscore.Views.App()
        Backbone.history.start()
}
