class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%- rankName %> of <%- suitName %>'
  # _.template '<div><img src="img/cards/<%= rankName.toString().toLowerCase() %>-<%= suitName.toLowerCase() %>.png" /></div>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
