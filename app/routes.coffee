# Badminscore.Router

class Badminscore.Router extends Backbone.Router

    routes:
        '': 'index'
        'new-game': 'newGame'

    # Views
    index: () ->
        view = new Badminscore.Views.Index()
        Badminscore.instance.goto(view)

    newGame: () ->
        view = new Badminscore.Views.NewGame()
        Badminscore.instance.goto(view)

