#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'inPlay', true
    # @get('playerHand').on('playerbust', => console.log "app hears bust"
    #  , @)
    @get('playerHand').on('hit', (-> console.log "app hears hit"), @)
    @get('playerHand').on('playerbust', (->
      console.log "app hears bust"
      @set 'inPlay', false
      @get('dealerHand').at(0).flip()
      )
    , @)
    @get('playerHand').on('playerstand', (->
      console.log "app hears stand"
      if @get 'inPlay'
        @set 'inPlay', false
        do @get('dealerHand').hit
        do @get('dealerHand').at(0).flip
        do @determineWinner
      else
        console.log "tried to stand after busting!")
    , @)
    # @get('dealerHand').on('gameover', (->
    #   do @determineWinner)
    # )

  determineWinner: ->
    playerscore = do @get('playerHand').score
    dealerscore = do @get('dealerHand').score
    # @get('dealerHand').at(0).flip()
    if playerscore > dealerscore
      console.log "player wins"
    else
      console.log "dealer wins"
  # events:
  #   'playerbust': ->
  #     console.log "app hears playerbust"
  redeal: ->
    console.log "app heard redeal"
    newhand = (@get 'deck').dealPlayer().models
    (@get 'playerHand').reset(newhand)
    newhand = (@get 'deck').dealDealer().models
    (@get 'dealerHand').reset(newhand)
    @set 'inPlay', true
    # console.log ans
    # set((@get 'deck').dealPlayer())
    # params =
    #   (@get 'deck'): new Deck(),
    #   (@get 'playerHand'): deck.dealPlayer(),
    #   (@get 'dealerHand'): deck.dealDealer()
    # @set(params)

