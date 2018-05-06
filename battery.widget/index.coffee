command: "
    pmset -g batt | 
    grep \"%\" |
    awk '
        BEGINN { FS = \";\" }; 
        END { print $1,$2,$3,$4,$5 } 
    ' |
    sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'
"

refreshFrequency: 50000

render: (output) -> """
    <div id='container'>
        <div id='batt-title'></div>
        <div id='progress-wrapper' class='wrapper'>
            <div class='progress-bar'>
                <span id='progress' class='progress-bar-fill'></span>
            </div>
        </div>
    </div>
"""
update: (output, domEl) ->
  data = output.split(' ')
  $(domEl).find('#progress').css("width", data[2])
  $(domEl).find('#batt-title').text data[3].toUpperCase()

style: """
    @media all and (max-width: 3440px){
        top: 15%
        left: 46%
    }

    @media all and (max-width: 2560px){
        top: 15%
        left: 42%
    }

    font-family: futura

    #container
        width: 150px
        transform: rotate(270deg);

    #batt-title
        width: 150px
        float: left
        text-align: center

    .wrapper {
        width: 150px;
        float: left
    }
        
    .progress-bar {
        width: 100%;
        background-color: #e0e0e0;
        padding: 3px;
        border-radius: 3px;
    }
    
    .progress-bar-fill {
        display: block;
        height: 22px;
        background-color: black;
        border-radius: 3px;
        
        transition: width 500ms ease-in-out;
    }
"""