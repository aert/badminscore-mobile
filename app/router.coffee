# Badminscore.Router

class Badminscore.MainRouter extends Backbone.Marionette.AppRouter

    appRoutes:
        '': 'showIndex'
        'game/create': 'showGameCreate'
        'game/:id': 'showGameDetails'

