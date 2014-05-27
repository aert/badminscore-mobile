# Badminscore.Extensions.View

class Badminscore.MainController extends Backbone.Marionette.Controller

    initialize: () ->
        @currentPage = null

        @modelNavigation = new Badminscore.Models.Navigation()
        @viewNavigation = new Badminscore.Views.Navigation(@modelNavigation)

        Badminscore.rgNavigation.show(@viewNavigation)

    # -- Views ----------------------------------------------------------------
    showIndex: () ->
        view = new Badminscore.Views.GameCollectionView(collection: Badminscore.Data.games)
        #view = new Badminscore.Views.Index()
        this.gotoPage(view, 'nav-ongoing')

    showNewGame: () ->
        model = new Badminscore.Models.Game()
        view = new Badminscore.Views.NewGame(model)
        this.gotoPage(view, 'nav-new')

    # -- Private Methods ------------------------------------------------------
    gotoPage: (view, navId) ->
        Badminscore.rgContent.show(view)
        @currentPage = view

        @modelNavigation.set({selectedId: navId})
