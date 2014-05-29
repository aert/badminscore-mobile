# game_create.coffee

class Badminscore.Views.GameCreate extends Backbone.Marionette.View
    className: 'view-gameCreate'

    initialize: (model) ->
        @model = model
        this.listenTo(@model, "change", this.onModelChanged)
        this.listenTo(@model, "change:servicePlayer", this.onModelServicePlayerChanged)
        this.listenTo(@model, "change:receiverPlayer", this.onModelReceiverPlayerChanged)

        @changesCount = 0

    events:
        "click .radPlayerCount": "onSwitchGameType"
        "click #btnNewGameFirst": "onBtnNewGameFirst"
        "click #btnNewGameSecond": "onBtnSave"
        "change #servicePlayer": "onSelectServicePlayerChanged"
        "change #receiverPlayer": "onSelectReceiverPlayerChanged"

    # -- Binding --------------------------------------------------------------
    bindings:
        '#refereeFirstname': 'refereeFirstname'
        '#refereeSurname': 'refereeSurname'
        '#gameField': 'field'

        '#player1Firstname': 'player1Firstname'
        '#player1Surname': 'player1Surname'
        '#player2Firstname': 'player2Firstname'
        '#player2Surname': 'player2Surname'

        '#playerA1Firstname': 'playerA1Firstname'
        '#playerA1Surname': 'playerA1Surname'
        '#playerA2Firstname': 'playerA2Firstname'
        '#playerA2Surname': 'playerA2Surname'
        '#playerB1Firstname': 'playerB1Firstname'
        '#playerB1Surname': 'playerB1Surname'
        '#playerB2Firstname': 'playerB2Firstname'
        '#playerB2Surname': 'playerB2Surname'


    # -- UI Events ------------------------------------------------------------
    onSwitchGameType: () ->
        radValue = this.$el.find("input[name=radPlayerCount]:checked").val()

        if !!radValue
            isDouble = radValue == "double"
        else
            isDouble = null

        @model.set(isTypeDouble: isDouble)

        if isDouble
            this.$el.find(".new_game_simple").hide()
            this.$el.find(".new_game_double").fadeIn(duration: 1500)
        else
            this.$el.find(".new_game_double").hide()
            this.$el.find(".new_game_simple").fadeIn(duration: 1500)

    onBtnNewGameFirst: () ->
        this.bindConfirmForm()
        this.$el.find('#newGameConfirm').modal()

    onSelectServicePlayerChanged: () ->
        newValue = parseInt(this.$el.find("#servicePlayer").val()) or 0
        @model.set("servicePlayer", newValue)
        this.$el.find("#receiverPlayer").val($("#receiverPlayer option:first").val())
        
    onSelectReceiverPlayerChanged: () ->
        newValue = parseInt(this.$el.find("#receiverPlayer").val()) or 0
        @model.set("receiverPlayer", newValue)

    onBtnSave: () ->
        @model.set("id", Badminscore.Data.games.length + 1)
        Badminscore.Data.games.add(@model, at: 0)
        
        this.$el.find('#newGameConfirm').modal("hide")
        this.$el.find('#newGameConfirm').on("hidden.bs.modal", (e) ->
            Badminscore.router.navigate('', trigger: true)
        )


    # -- Model Changes --------------------------------------------------------
    
    onModelChanged: () ->
        @changesCount++
        enableBtnNewGameFirst = false

        hasRadValue = @model.get("isTypeDouble") != null
        enableBtnNewGameFirst = hasRadValue

        if enableBtnNewGameFirst
            this.$el.find("#btnNewGameFirst").removeAttr("disabled")
        else
            this.$el.find("#btnNewGameFirst").attr("disabled", "disabled")

    onModelServicePlayerChanged: () ->
        servicePlayer = @model.get("servicePlayer") or 0

        $select = this.$el.find('#receiverPlayer').first()
        @model.bindReceiverOptions($select)

        if servicePlayer < 1
            this.$el.find("#newGameFormReceiver").hide()
        else
            this.$el.find("#newGameFormReceiver").fadeIn(duration: 1500)
        
    onModelReceiverPlayerChanged: () ->
        receiverPlayer = @model.get("receiverPlayer") or 0

        if receiverPlayer < 1
            this.$el.find("#btnNewGameSecond").attr("disabled", "disabled")
        else
            this.$el.find("#btnNewGameSecond").removeAttr("disabled")
        
    bindConfirmForm: () ->
        $select = this.$el.find('#servicePlayer').first()
        @model.bindServiceOptions($select)

    # -- Render ---------------------------------------------------------------
    render: () ->
        template = _.template($('#template-gameCreate').html())
        this.$el.html(template)
        this.stickit()
        return this
