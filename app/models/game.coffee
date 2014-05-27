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



