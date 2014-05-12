# Badminscore.Views.NewGame

class Badminscore.Views.NewGame extends Badminscore.Extensions.View
    className: 'new-game'

    render: () ->
        template = _.template($('#new-game-tpl').html())
        this.$el.html(template)
        
        return Badminscore.Extensions.View.prototype.render.apply(this, arguments)
