# Badminscore.Extensions.View

class Badminscore.MainController extends Backbone.Marionette.Controller

    initialize: () ->
        @currentPage = null
        Badminscore.rgNavigation.show(new Badminscore.Views.Navigation())

    # -- Views ----------------------------------------------------------------
    showIndex: () ->
        view = new Badminscore.Views.Index()
        this.gotoPage(view)

    showNewGame: () ->
        view = new Badminscore.Views.NewGame()
        this.gotoPage(view)

    # -- Private Methods ------------------------------------------------------
    gotoPage: (view) ->
        Badminscore.rgContent.show(view)
        @currentPage = view
