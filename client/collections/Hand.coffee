class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if @isDealer
      console.log "dealer hit"
      score = @score()
      # while score < 17
      loop
        break if score > 17
        console.log score
        score += @add(@deck.pop())
        do @scores
        score = @score()
        console.log score
      @trigger 'gameover'
    else
      @trigger 'hit'
      @add(@deck.pop()).last()
      if (do @scores)[0] <= 21
        console.log do @scores
      else
        console.log "you bust"
        @trigger "playerbust"
    @last()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  stand: ->
    @trigger "playerstand"

  score: ->
    scores = do @scores
    scores = _.filter(scores, (score)->
      score <= 21
    )
    if scores[0]?
      _.max(scores)
    else
      0
