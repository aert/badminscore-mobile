# Badminscore.Views.App

class Badminscore.Views.App extends Badminscore.Extensions.View
    el: '#content'

    goto: (view) ->
        previous = this.currentPage || null
        next = view

        if previous
            previous.transitionOut(() -> previous.remove())
            noPrevious = false
        else
            noPrevisous = true

        next.render(page: true)
        this.$el.append(next.$el)
        next.transitionIn(noPrevious: noPrevious)
        this.currentPage = next

