command: "
    date \"+%A\"; date \"+%d %B %Y\" &&
    date \"+%H:%M\"
"

render: -> """
    <div id="container">
        <div id=time>TIME</div>
        <div id=date>DATE</div>
    </div>
"""



refreshFrequency: 100000

style: """
    @media all and (max-width: 3440px){
        top: 40%
        left: 40%
    }

    @media all and (max-width: 2560px){
        top: 40%
        left: 30%
    }

    font-family: futura

    #time
        font-size: 40px
        margin-left: -4px

    #date
        font-size: 30px
"""

update: (output, domEl) ->
  data = output.split('\n')
  $(domEl).find('#time').text data[2]
  $(domEl).find('#date').text (data[0] + ' ' + data[1])

  