# Badminscore.Views.Index

class Badminscore.Views.Index extends Badminscore.Extensions.View
    className: 'index'

    render: () ->
        template = _.template($('#index-tpl').html())
        this.$el.html(template)
        return Badminscore.Extensions.View.prototype.render.apply(this, arguments)
