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

    bindServiceOptions: ($select) ->
        $select.empty()
        this.set("servicePlayer", 0)
        this.set("receiverPlayer", 0)

        if this.get("isTypeDouble") == null
            return

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
        
        i = 0
        for opt in optList
            $select.append($("<option />").val(i).text(opt))
            i++
