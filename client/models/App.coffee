#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # @get('playerHand').on('playerbust', => console.log "app hears bust"
    #  , @)
    @get('playerHand').on('hit', (-> console.log "app hears hit"), @)
    @get('playerHand').on('playerbust', (-> console.log "app hears bust"), @)
    @get('playerHand').on('playerstand', (->
      console.log "app hears stand"
      do @get('dealerHand').hit
      do @determineWinner)
    , @)

  determineWinner: ->
    playerscore = do @get('playerHand').score
    dealerscore = do @get('dealerHand').score
    if playerscore > dealerscore
      console.log "player wins"
    else
      console.log "dealer wins"
  # events:
  #   'playerbust': ->
  #     console.log "app hears playerbust"


