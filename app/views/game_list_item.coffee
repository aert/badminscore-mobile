# _game_itemview.coffee

class Badminscore.Views.GameItem extends Backbone.Marionette.ItemView

    model: Badminscore.Views.Game
    tagName: "li"
    className: "score"

    events:
        "click": "onClick"
    
    render: () ->
        template = _.template($('#template-gameListItem').html(), model: @model)
        this.$el.html(template)
        return this

    onClick: () ->
        id = @model.get("id")
        Badminscore.router.navigate("game/#{id}", trigger: true)

class Badminscore.Views.GameCollection extends Backbone.Marionette.CollectionView
    itemView: Badminscore.Views.GameItem
    tagName: "ul"
    className: "row"
