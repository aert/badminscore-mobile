# app.js

# Namespace
Badminscore = new Backbone.Marionette.Application()
Badminscore.Models = {}
Badminscore.Views = {}
Badminscore.Data ||= {}

Badminscore.controller = null
Badminscore.router = null
Badminscore.Data.games = null

# Regions
Badminscore.addRegions(
    rgNavigation: "#navigation"
    rgContent: "#content"
)

Marionette.Region.prototype.open = (view) ->
    this.$el.hide()
    this.$el.html(view.el)
    this.$el.fadeIn("slow")

# Initializer
Badminscore.addInitializer((options) ->
    Badminscore.Data.games = new Badminscore.Models.GameCollection()

    # Test Data

    Badminscore.Data.games.add([
        {
            refereeFirstname: "Blake", refereeSurname: "Mortimer", field: "Riedisheim Gambetta", isTypeDouble: true,
            playerA1Firstname: "Carlos", playerA1Surname: "B.", playerA2Firstname: "Adam", playerA2Surname: "C.",
            playerB1Firstname: "Alexandre", playerB1Surname: "H.", playerB2Firstname: "Julien", playerB2Surname: "F.",
            servicePlayer: 1, receiverPlayer: 4,
            totalScore1: 15, totalScore2: 10
        },
        {
            refereeFirstname: "Blake", refereeSurname: "Mortimer",
            field: "Habsheim", isTypeDouble: false,
            player1Firstname: "Romain", player1Surname: "S.", player2Firstname: "Lorraine", player2Surname: "B.",
            servicePlayer: 1, receiverPlayer: 2,
            totalScore1: 12, totalScore2: 4
        },
        {
            refereeFirstname: "Blake", refereeSurname: "Mortimer",
            field: "01", isTypeDouble: false,
            player1Firstname: "Samuel", player1Surname: "E.", player2Firstname: "Nicolas", player2Surname: "H.",
            servicePlayer: 2, receiverPlayer: 1,
            totalScore1: 9, totalScore2: 10
        },
        {
            refereeFirstname: "Blake", refereeSurname: "Mortimer",
            field: "ASPTT Strasbourg", isTypeDouble: false,
            player1Firstname: "Valérie", player1Surname: "A.", player2Firstname: "Katia", player2Surname: "N.",
            servicePlayer: 2, receiverPlayer: 1,
            totalScore1: 3, totalScore2: 11
        },
        {
            refereeFirstname: "Blake", refereeSurname: "Mortimer",
            field: "ASPTT Strasbourg", isTypeDouble: false,
            player1Firstname: "Christophe", player1Surname: "B.", player2Firstname: "Marianne", player2Surname: "N.",
            servicePlayer: 1, receiverPlayer: 2,
            totalScore1: 13, totalScore2: 8
        }
    ])
    
    # End Test Data


    Badminscore.controller = new Badminscore.MainController()
    Badminscore.router = new Badminscore.MainRouter(controller: Badminscore.controller)

    Backbone.history.start()
)
