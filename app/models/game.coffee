# gameModel

class Badminscore.Models.Game extends Backbone.Model

    defaults:
        refereeFirstname: ""
        refereeSurname: ""
        field: ""
        isTypeDouble: null

        player1Firstname: ""
        player1Surname: ""
        player2Firstname: ""
        player2Surname: ""

        playerA1Firstname: ""
        playerA1Surname: ""
        playerA2Firstname: ""
        playerA2Surname: ""

        playerB1Firstname: ""
        playerB1Surname: ""

        playerB2Firstname: ""
        playerB2Surname: ""

        servicePlayer: 0
        receiverPlayer: 0

        totalScore1: 0
        totalScore2: 0

        exchangeResults: []

    initialize: () ->
        this.on("change:exchangeResults", this.refreshScore())

    refreshScore: () ->
        totalScore1 = 0
        totalScore2 = 0
        exchangeResults = this.get("exchangeResults")

        for r in exchangeResults
            if r == "A"
                totalScore1++
            else
                totalScore2++
        this.set("totalScore1", totalScore1)
        this.set("totalScore2", totalScore2)

    getWinnerNum: (numPlay) ->
        exchangeResults = this.get("exchangeResults")
        if numPlay < 0 or numPlay >= exchangeResults.length
            return -1

        if this.get("isTypeDouble") == false
            if exchangeResults[numPlay] == "A"
                return 0
            if exchangeResults[numPlay] == "B"
                return 1
        else
            [servicePlayer, receiverPlayer] = @getServiceReceiver(numPlay)
            if exchangeResults[numPlay] == "A"
                return if servicePlayer < 2 then servicePlayer else receiverPlayer
            if exchangeResults[numPlay] == "B"
                return if servicePlayer >= 2 then servicePlayer else receiverPlayer

        return -1
        
    getWinner: (numPlay) ->
        exchangeResults = this.get("exchangeResults")
        if numPlay < 0 or numPlay >= exchangeResults.length
            return "---"
        
        playerA = this.getLabelPlayerA()
        playerB = this.getLabelPlayerB()

        if exchangeResults[numPlay] == "A"
            return playerA
        if exchangeResults[numPlay] == "B"
            return playerB
        return "---"

    getServiceReceiver: (numPlay) ->
        exchangeResults = this.get("exchangeResults")
        servicePlayer = this.get("servicePlayer") - 1
        receiverPlayer = this.get("receiverPlayer") - 1
        isDouble = this.get("isTypeDouble")

        if numPlay > exchangeResults.length
            return [-1, -1]

        winner = if exchangeResults[0] == "A" then 0 else 1

        if not isDouble
            if numPlay == 0
                return [servicePlayer, receiverPlayer]
            changeService = () ->
                if servicePlayer == 0
                    servicePlayer = 1
                    receiverPlayer = 0
                else
                    servicePlayer = 0
                    receiverPlayer = 1
            for i in [1..numPlay]
                if winner != servicePlayer
                    changeService()
                winner = if exchangeResults[i] == "A" then 0 else 1
            return [servicePlayer, receiverPlayer]

        # isDouble
        if servicePlayer < 2
            teamARight = servicePlayer
            teamALeft = if servicePlayer == 0 then 1 else 0
            teamBRight = receiverPlayer
            teamBLeft = if receiverPlayer == 2 then 3 else 2
        else
            teamARight = receiverPlayer
            teamALeft = if receiverPlayer == 0 then 1 else 0
            teamBRight = servicePlayer
            teamBLeft = if servicePlayer == 2 then 3 else 2

        if numPlay == 0
            return [servicePlayer, receiverPlayer, teamARight, teamALeft, teamBRight, teamBLeft]

        updateServiceSide = (model, currentNumPlay) ->
            totalScore1 = model.getScoreA(currentNumPlay - 1)
            totalScore2 = model.getScoreB(currentNumPlay - 1)

            if servicePlayer < 2
                if totalScore1 % 2 == 0
                    teamARight = servicePlayer
                    teamALeft = if servicePlayer == 0 then 1 else 0
                    receiverPlayer = teamBRight
                else
                    teamALeft = servicePlayer
                    teamARight = if servicePlayer == 0 then 1 else 0
                    receiverPlayer = teamBLeft
            else
                if totalScore2 % 2 == 0
                    teamBRight = servicePlayer
                    teamBLeft = if servicePlayer == 2 then 3 else 2
                    receiverPlayer = teamARight
                else
                    teamBLeft = servicePlayer
                    teamBRight = if servicePlayer == 2 then 3 else 2
                    receiverPlayer = teamALeft

        changeService = () ->
            servicePlayer = receiverPlayer

        servicePlayerTeam = (player) -> return if player > 1 then 1 else 0
        winner = if exchangeResults[0] == "A" then 0 else 1

        for i in [1..numPlay]
            if winner != servicePlayerTeam(servicePlayer)
                changeService()
            updateServiceSide(this, i)
            winner = if exchangeResults[i] == "A" then 0 else 1
        return [servicePlayer, receiverPlayer, teamARight, teamALeft, teamBRight, teamBLeft]


    getLabelReferee: () ->
        return this.get("refereeSurname").toUpperCase() + " " + this.get("refereeFirstname")

    getLabelPlayerA: () ->
        if this.get("isTypeDouble") == false
            optList = this.getOptList()
            playerA = optList[1]
        else
            playerA = "Equipe A"

    getLabelPlayerB: () ->
        if this.get("isTypeDouble") == false
            optList = this.getOptList()
            playerA = optList[2]
        else
            playerA = "Equipe B"

    getFeuilleScore: (numPlayer, numPlay) ->
        servicePlayer = this.getWinnerNum(numPlay)
        if servicePlayer != numPlayer
            return ""
        if this.get("isTypeDouble") == false
            if servicePlayer == 0
                return this.getScoreA(numPlay)
            else
                return this.getScoreB(numPlay)
        else
            if servicePlayer < 2
                return this.getScoreA(numPlay)
            else
                return this.getScoreB(numPlay)

    getScoreA: (numPlay) ->
        exchangeResults = this.get("exchangeResults")
        if numPlay >= exchangeResults.length
            return this.get("totalScore1")

        score = 0
        for i in [0..numPlay]
            if exchangeResults[i] == "A"
                score++
        return score

    getScoreB: (numPlay) ->
        exchangeResults = this.get("exchangeResults")
        if numPlay >= exchangeResults.length
            return this.get("totalScore2")

        score = 0
        for i in [0..numPlay]
            if exchangeResults[i] == "B"
                score++
        return score

    addExchangeResultA: () ->
        exchanges = this.get("exchangeResults")
        exchanges.push("A")
        this.set("exchangeResults", exchanges)
        this.refreshScore()

    addExchangeResultB: () ->
        exchanges = this.get("exchangeResults")
        exchanges.push("B")
        this.set("exchangeResults", exchanges)
        this.refreshScore()

    getOptList: () ->
        optList = []
        optList.push('---')

        if not this.get("isTypeDouble")
            optList.push(this.get("player1Firstname") + " " + this.get("player1Surname"))
            optList.push(this.get("player2Firstname") + " " + this.get("player2Surname"))
        else
            optList.push(this.get("playerA1Firstname") + " " + this.get("playerA1Surname"))
            optList.push(this.get("playerA2Firstname") + " " + this.get("playerA2Surname"))
            optList.push(this.get("playerB1Firstname") + " " + this.get("playerB1Surname"))
            optList.push(this.get("playerB2Firstname") + " " + this.get("playerB2Surname"))

        return optList

    getLabelService: () ->
        servicePlayer = this.get("servicePlayer") or 0

        if servicePlayer < 1
            return "---"

        optList = this.getOptList()
        return optList[servicePlayer]

    bindServiceOptions: ($select) ->
        $select.empty()
        this.set("servicePlayer", 0)
        this.set("receiverPlayer", 0)

        if this.get("isTypeDouble") == null
            return

        optList = this.getOptList()
        
        i = 0
        for opt in optList
            $select.append($("<option />").val(i).text(opt))
            i++

    bindReceiverOptions: ($select) ->
        $select.empty()
        this.set("receiverPlayer", 0)

        idxService = this.get("servicePlayer") or 0
        
        if idxService == 0
            return

        optList = this.getOptList()

        # Type Simple
        if this.get("isTypeDouble") == false
            idxOtherPlayer = if idxService == 1 then 2 else 1
            otherPlayer = optList[idxOtherPlayer]
            $select.append(
                $("<option />")
                .val(idxOtherPlayer)
                .text(otherPlayer)
            )
            this.set("receiverPlayer", idxOtherPlayer)
            return

        # Type Double
        $select.append($("<option />") .val(0).text("---"))

        if idxService >= 3
            idxOtherPlayers = [1, 2]
        else
            idxOtherPlayers = [3, 4]
        
        for idx in idxOtherPlayers
            $select.append(
                $("<option />")
                .val(idx)
                .text(optList[idx])
            )
        return

class Badminscore.Models.GameCollection extends Backbone.Collection
    model: Badminscore.Models.Game



