<Layer>
    <p class="mdl-typography--title">レイヤー</p>
    <select class="mdl-textfield__input" id="layer-select">
      <option  each="{ opt, key in opts }" value="{key}">{opt.name}</option>
  </select>
    <br>
</Layer>

<Disk>
    <p class="mdl-typography--title">ディスク</p>
    <select class="mdl-textfield__input" id="disk-select">
      <option  each="{ opt, key in opts }" value="{key}">[{opt.initial}] {opt.name}</option>
  </select>
    <br>
</Disk>

<Driver>
    <p class="mdl-typography--title">ドライバー</p>
    <select class="mdl-textfield__input" id="driver-select">
      <option  each="{ opt, key in opts }" value="{key}">[{opt.initial}] {opt.name}</option>
    </select>
    <br>
</Driver>

<RadarChart>
    <Layer></Layer>
    <Disk></Disk>
    <Driver></Driver>

    <div style="text-align: center">
        <br>
        <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" style="width: 50%" onclick={f2}>けってい</button><br>
        <br>
        <h6 class="mdl-typography--title"><label id="CustomBeyName"></label></h6>
        <canvas id="chart2" , width="240" height="240"></canvas>
    </div>
    <script>
        let chart = null

        this.on('mount', function() {
            riot.mount('Layer', opts.Layer)
            riot.mount('Disk', opts.Disk)
            riot.mount('Driver', opts.Driver)
        })

        f2(e) {
            let layerValue = document.getElementById('layer-select').value
            let diskValue = document.getElementById('disk-select').value
            let driverValue = document.getElementById('driver-select').value

            let selectedLayer = opts.Layer[layerValue]
            let selectedDisk = opts.Disk[diskValue]
            let selectedDriver = opts.Driver[driverValue]

            let name = selectedLayer.name + '.' + selectedDisk.initial + "." + selectedDriver.initial
            document.getElementById('CustomBeyName').innerText = name

            let attack = selectedLayer.attack + selectedDisk.attack + selectedDriver.attack
            let defense = selectedLayer.defense + selectedDisk.defense + selectedDriver.defense
            let stamina = selectedLayer.stamina + selectedDisk.stamina + selectedDriver.stamina
            let weight = selectedLayer.weight + selectedDisk.weight + selectedDriver.weight
            let speed = selectedLayer.speed + selectedDisk.speed + selectedDriver.speed
            let burst = selectedLayer.burst

            var ctx = document.getElementById("chart2").getContext("2d");

            var data = {
                labels: ["攻撃(こうげき)力", "防御(ぼうぎょ)力", "持久(じきゅう)力", "重量(じゅうりょう)", "機動(きどう)力", "バースト力"],
                datasets: [{
                    label: name,
                    // backgroundColor: "rgba(179,181,198,0.2)",
                    // borderColor: "rgba(179,181,198,1)",
                    // pointBackgroundColor: "rgba(179,181,198,1)",
                    // pointBorderColor: "#fff",
                    // pointHoverBackgroundColor: "#fff",
                    // pointHoverBorderColor: "rgba(179,181,198,1)",
                    data: [attack, defense, stamina, weight, speed, burst]
                }]
            };

            if (chart == null) {
                chart = new Chart(ctx, {
                    type: "radar",
                    data: data,
                    options: {
                        scale: {
                            ticks: {
                                beginAtZero: true,
                                min: 0,
                                max: 10,
                                stepSize: 2
                            },
                        },
                        legend: {
                            // display: false
                        }
                    }
                });
            } else {
                chart.data.datasets.push(data.datasets[0])
                console.log(chart.data.datasets.length)
                if (chart.data.datasets.length > 2) {
                    chart.data.datasets.shift()
                }
                chart.update()
            }
        }
    </script>
</RadarChart>