command: "
    ps aux  | awk 'BEGIN { sum = 0 }  { sum += $3 }; END { print sum }' &&
    sysctl -a kern.memorystatus_vm_pressure_level | awk '{ print $2 }' &&
    sysctl hw.ncpu | awk '{print $2}'
"
refreshFrequency: 30000

render: -> """
    <div id="container">
        <div id="cpu-label">CPU Utilization</div>
        <div id="cpu">CPU%</div>
        <div id="mem-label">Mem Pressure</div>
        <div id="mem">PRESSURE</div>
    </div>
"""

style: """
    @media all and (max-width: 3440px){
        top: 63%
        left: 50%
    }

    @media all and (max-width: 2560px){
        top: 63%
        left: 50%
    }

    font-family: futura
    font-size: 20px

    #container
        width: 400px

    #cpu-label
        width: 200px
        float: left

    #mem-label
        width: 200px
        float: left
    
    .blink_me {
         animation: blinker 1s linear infinite;
         color: red
    }

    @keyframes blinker {  
        50% { opacity: 0; } 
    }
"""

update: (output, domEl) ->
  data = output.split('\n')
  $(domEl).find('#cpu').text (data[0]/data[2]).toFixed(2) + '%';

  if (data[1] > 1) 
      $(domEl).find('#mem').text 'HIGH'
      $(domEl).find('#mem').addClass('blink_me');
  else 
      $(domEl).find('#mem').text 'NORMAL'

  $(domEl).find('#date').text (data[0] + ' ' + data[1])