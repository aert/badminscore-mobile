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

    testGame1 =
        id: "1",
        refereeFirstname: "Blake", refereeSurname: "Mortimer", field: "Riedisheim Gambetta", isTypeDouble: true,
        playerA1Firstname: "Carlos", playerA1Surname: "B.", playerA2Firstname: "Adam", playerA2Surname: "C.",
        playerB1Firstname: "Alexandre", playerB1Surname: "H.", playerB2Firstname: "Julien", playerB2Surname: "F.",
        servicePlayer: 1, receiverPlayer: 4,
        exchangeResults: ['A', 'A', 'B', 'B', 'B', 'A', 'B', 'A', 'A', 'B', 'B', 'B', 'A', 'B', 'B', 'A', 'B', 'A', 'A', 'A', 'A', 'B', 'B', 'B', 'A', 'B', 'B', 'A', 'B', 'A', 'A']
    testGame2 =
        id: "2",
        refereeFirstname: "Blake", refereeSurname: "Mortimer",
        field: "Habsheim", isTypeDouble: false,
        player1Firstname: "Romain", player1Surname: "S.", player2Firstname: "Lorraine", player2Surname: "B.",
        servicePlayer: 1, receiverPlayer: 2,
        exchangeResults: ['A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'B', 'B', 'A', 'B', 'A', 'A', 'A', 'A', 'B', 'B', 'B']
    testGame3 =
        id: "3",
        refereeFirstname: "Blake", refereeSurname: "Mortimer",
        field: "01", isTypeDouble: false,
        player1Firstname: "Samuel", player1Surname: "E.", player2Firstname: "Nicolas", player2Surname: "H.",
        servicePlayer: 2, receiverPlayer: 1,
        exchangeResults: ['B', 'B', 'A', 'B', 'B', 'B', 'B', 'A', 'B', 'B', 'A', 'B', 'B', 'A', 'B', 'B']
    testGame4 =
        id: "4",
        refereeFirstname: "Blake", refereeSurname: "Mortimer",
        field: "ASPTT Strasbourg", isTypeDouble: false,
        player1Firstname: "Valérie", player1Surname: "A.", player2Firstname: "Katia", player2Surname: "N.",
        servicePlayer: 2, receiverPlayer: 1,
        exchangeResults: ['A', 'B', 'A', 'B', 'A', 'B', 'B', 'A', 'B', 'B', 'A', 'B', 'B', 'A', 'B', 'B', 'A', 'B', 'A', 'A', 'B', 'B', 'B', 'A', 'B']
    testGame5 =
        id: "5",
        refereeFirstname: "Blake", refereeSurname: "Mortimer",
        field: "ASPTT Strasbourg", isTypeDouble: false,
        player1Firstname: "Christophe", player1Surname: "B.", player2Firstname: "Marianne", player2Surname: "N.",
        servicePlayer: 1, receiverPlayer: 2,
        exchangeResults: ['A', 'A', 'B', 'B', 'B', 'B', 'B', 'A', 'B', 'A', 'B', 'B', 'A', 'B', 'B', 'B', 'A', 'A', 'A', 'A']

    Badminscore.Data.games.add([ testGame1, testGame2, testGame3, testGame4, testGame5 ])
    
    # End Test Data

    Badminscore.controller = new Badminscore.MainController()
    Badminscore.router = new Badminscore.MainRouter(controller: Badminscore.controller)

    Backbone.history.start()
)
