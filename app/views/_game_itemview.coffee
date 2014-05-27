# _game_itemview.coffee

class Badminscore.Views.GameItemView extends Backbone.Marionette.ItemView

    model: Badminscore.Views.Game
    tagName: "li"
    className: "score"

    events:
        "click": "onClick"
    
    render: () ->
        template = _.template($('#template-control-score').html(), model: @model)
        this.$el.html(template)
        return this

    onClick: () ->
        alert("OK")

class Badminscore.Views.GameCollectionView extends Backbone.Marionette.CollectionView
    itemView: Badminscore.Views.GameItemView
    tagName: "ul"
    className: "row"
