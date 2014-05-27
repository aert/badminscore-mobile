# Badminscore.Router

class Badminscore.MainRouter extends Backbone.Marionette.AppRouter

    appRoutes:
        '': 'showIndex'
        'new-game': 'showNewGame'
        'game/:id': 'showGameDetails'

