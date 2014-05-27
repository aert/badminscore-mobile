# Badminscore.Extensions.View

class Badminscore.MainController extends Backbone.Marionette.Controller

    initialize: () ->
        @currentPage = null

        @modelNavigation = new Badminscore.Models.Navigation()
        @viewNavigation = new Badminscore.Views.Navigation(@modelNavigation)

        Badminscore.rgNavigation.show(@viewNavigation)

    # -- Views ----------------------------------------------------------------
    showIndex: () ->
        view = new Badminscore.Views.GameCollection(collection: Badminscore.Data.games)
        this.gotoPage(view, 'nav-ongoing')

    showGameCreate: () ->
        model = new Badminscore.Models.Game()
        view = new Badminscore.Views.GameCreate(model)
        this.gotoPage(view, 'nav-new')

    showGameDetails: (id) ->
        id = parseInt(id)
        if isNaN(id) or id > Badminscore.Data.games.length
            Badminscore.router.navigate('', trigger: true)
            return

        model = Badminscore.Data.games.get(id)
        view = new Badminscore.Views.GameDetails(model)
        this.gotoPage(view, 'nav-ongoing')

    # -- Private Methods ------------------------------------------------------
    gotoPage: (view, navId) ->
        Badminscore.rgContent.show(view)
        @currentPage = view

        @modelNavigation.set({selectedId: navId})
