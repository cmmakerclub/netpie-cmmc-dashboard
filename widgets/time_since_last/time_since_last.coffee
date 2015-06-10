class Dashing.TimeSinceLast extends Dashing.Widget

  ready: ->
    if not @last_event? and this.time?
      @onData(this)
    setInterval(@startTime, 500)
 
  onData: (data) ->
    @last_event = moment(data.time*1000)
    @startTime()
    @set('sub', @last_event.format("ddd h:mm a"))
 
  startTime: =>
    node = $(@node)
    if @last_event? and @last_event.isValid()
      @set('time_past', @last_event.fromNow(true))
      if @get('threshold')
        if @last_event < moment().subtract(@get('threshold'), 'hours')
          node.addClass('bad')
          node.removeClass('good')
        else
          node.addClass('good')
          node.removeClass('bad')
    else
      @set('time_past', "?")
      node.removeClass('bad')
      node.removeClass('good')
