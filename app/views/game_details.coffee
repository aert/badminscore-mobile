# Badminscore.Views.ShowGame

class Badminscore.Views.GameDetails extends Backbone.Marionette.View

    className: "view_show_game"
    
    initialize: (model) ->
        @model = model
        @maxNumPlay = @model.get("totalScore1") + @model.get("totalScore2")
        @numPlay = @maxNumPlay

    events:
        "click #btnExchangePrevious" : "onBtnExchangePrevious"
        "click #btnExchangeNext" : "onBtnExchangeNext"
        "click #btnExchangeFirst" : "onBtnExchangeFirst"
        "click #btnExchangeLast" : "onBtnExchangeLast"

        "click #btnWinPlayerA" : "onBtnWinPlayerA"
        "click #btnWinPlayerB" : "onBtnWinPlayerB"

    ui:
        numPlay: "#numPlay"
        panExchangePast: "#panExchangePast"
        panExchangeCurrent: "#panExchangeCurrent"
        lblExchangePastWinner: "#lblExchangePastWinner"
        lblScoreA: "#lblScoreA"
        lblScoreB: "#lblScoreB"

    render: () ->
        # render template
        template = _.template($("#template-gameDetails").html(),
                              model: @model, numPlay: @numPlay + 1)
        this.$el.html(template)
        return this

    # -- UI Events ------------------------------------------------------------

    onBtnExchangeFirst: () ->
        if @numPlay == 0 then return
        @numPlay = 0
        this.bindModel()

    onBtnExchangeLast: () ->
        if @numPlay == @maxNumPlay then return
        @numPlay = @maxNumPlay
        this.bindModel()

    onBtnExchangePrevious: () ->
        if @numPlay > 0
            @numPlay--
            this.bindModel()

    onBtnExchangeNext: () ->
        if @numPlay < @maxNumPlay
            @numPlay++
            this.bindModel()

    onBtnWinPlayerA: () ->
        player = @model.getLabelPlayerA()
        r = confirm("#{player} gagne ?")
        if not r
            return

        @model.addExchangeResultA()
        @maxNumPlay++
        @numPlay = @maxNumPlay
        this.bindModel()

    onBtnWinPlayerB: () ->
        player = @model.getLabelPlayerB()
        r = confirm("#{player} gagne ?")
        if not r
            return

        @model.addExchangeResultB()
        @maxNumPlay++
        @numPlay = @maxNumPlay
        this.bindModel()

    # -- Private Methods ------------------------------------------------------

    bindModel: () ->
        $(@ui.numPlay).html(@numPlay + 1)

        $(@ui.panExchangeCurrent).hide()
        $(@ui.panExchangePast).hide()
        $(@ui.lblScoreA).hide()
        $(@ui.lblScoreB).hide()

        $(@ui.lblScoreA).html(@model.getScoreA(@numPlay))
        $(@ui.lblScoreB).html(@model.getScoreB(@numPlay))

        if @numPlay == @maxNumPlay
            $(@ui.panExchangeCurrent).fadeIn()
        else
            $(@ui.lblExchangePastWinner).html(@model.getWinner(@numPlay))
            $(@ui.panExchangePast).fadeIn()

        $(@ui.lblScoreA).fadeIn()
        $(@ui.lblScoreB).fadeIn()
