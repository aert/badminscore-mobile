# navigationModel

class Badminscore.Models.Navigation extends Backbone.Model

    initialize: () ->
        #selectedId
        this.setNavOngoing()

    getFlagActive: (id) ->
        if id == this.get('selectedId')
            return "active"
        return ""

    setNavOngoing: () ->
        this.set(selectedId: "nav-ongoing")

    setNavDone: () ->
        this.set(selectedId: "nav-done")

    setNavNew: () ->
        this.set(selectedId: "nav-new")
