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
        lblFlagPlayer1: "#lblFlagPlayer1"
        lblFlagPlayer2: "#lblFlagPlayer2"
        lblFlagPlayerA1: "#lblFlagPlayerA1"
        lblFlagPlayerA2: "#lblFlagPlayerA2"
        lblFlagPlayerB1: "#lblFlagPlayerB1"
        lblFlagPlayerB2: "#lblFlagPlayerB2"
        playersPlacement: "#playersPlacement"

    render: () ->
        # render template
        template = _.template($("#template-gameDetails").html(),
                              model: @model, numPlay: @numPlay + 1)
        this.$el.html(template)
        return this

    onShow: () ->
        this.bindModel()

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

        $(@ui.playersPlacement).hide()
        $(@ui.panExchangeCurrent).hide()
        $(@ui.panExchangePast).hide()
        $(@ui.lblScoreA).hide()
        $(@ui.lblScoreB).hide()
        $(@ui.lblFlagPlayer1).hide()
        $(@ui.lblFlagPlayer2).hide()
        $(@ui.lblFlagPlayerA1).hide()
        $(@ui.lblFlagPlayerA2).hide()
        $(@ui.lblFlagPlayerB1).hide()
        $(@ui.lblFlagPlayerB2).hide()

        $(@ui.lblScoreA).html(@model.getScoreA(@numPlay))
        $(@ui.lblScoreB).html(@model.getScoreB(@numPlay))

        placementData = @model.getServiceReceiver(@numPlay)
        $(@ui.lblFlagPlayer1).html(this.getFlag(placementData, 0))
        $(@ui.lblFlagPlayer2).html(this.getFlag(placementData, 1))
        $(@ui.lblFlagPlayerA1).html(this.getFlag(placementData, 0))
        $(@ui.lblFlagPlayerA2).html(this.getFlag(placementData, 1))
        $(@ui.lblFlagPlayerB1).html(this.getFlag(placementData, 2))
        $(@ui.lblFlagPlayerB2).html(this.getFlag(placementData, 3))

        if @numPlay == @maxNumPlay
            $(@ui.panExchangeCurrent).fadeIn()
        else
            $(@ui.lblExchangePastWinner).html(@model.getWinner(@numPlay))
            $(@ui.panExchangePast).fadeIn()

        $(@ui.lblScoreA).fadeIn()
        $(@ui.lblScoreB).fadeIn()
        $(@ui.lblFlagPlayer1).fadeIn()
        $(@ui.lblFlagPlayer2).fadeIn()
        $(@ui.lblFlagPlayerA1).fadeIn()
        $(@ui.lblFlagPlayerA2).fadeIn()
        $(@ui.lblFlagPlayerB1).fadeIn()
        $(@ui.lblFlagPlayerB2).fadeIn()

        if(@model.get("isTypeDouble") == true)
            this.updatePlacementUi(placementData)
            $(@ui.playersPlacement).fadeIn()

    updatePlacementUi: (placementData) ->
        [servicePlayer, receiverPlayer, teamARight, teamALeft, teamBRight, teamBLeft] = placementData
        optList = @model.getOptList()
        this.$el.find("#teamARight").html(optList[teamARight+1]).attr("class", @getTdFlag(placementData, teamARight))
        this.$el.find("#teamALeft").html(optList[teamALeft+1]).attr("class", @getTdFlag(placementData, teamALeft))
        this.$el.find("#teamBRight").html(optList[teamBRight+1]).attr("class", @getTdFlag(placementData, teamBRight))
        this.$el.find("#teamBLeft").html(optList[teamBLeft+1]).attr("class", @getTdFlag(placementData, teamBLeft))
        

    getFlag: (placementData, numPlayer) ->
        [servicePlayer, receiverPlayer] = placementData
            
        if servicePlayer == -1
            return "---"
        if servicePlayer == numPlayer
            return "&nbsp;<span class='text-success'><small>service</small></span>"
        else if receiverPlayer == numPlayer
            return "&nbsp;<span class='text-warning'><small>réception</small></span>"
        else
            return ""

    getTdFlag: (placementData, numPlayer) ->
        [servicePlayer, receiverPlayer] = placementData
            
        if servicePlayer == -1
            return "---"
        if servicePlayer == numPlayer
            return "success"
        else if receiverPlayer == numPlayer
            return "warning"
        else
            return ""

