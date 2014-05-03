class window.CardView extends Backbone.View

  className: 'card'

  template:  _.template '<div><img src="img/cards/<%= rankName.toString().toLowerCase() %>-<%= suitName.toLowerCase() %>.png" /></div>'

  #_.template '<%- rankName %> of <%- suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
