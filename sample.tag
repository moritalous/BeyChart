<Layer>
    <p class="mdl-textfield__input">レイヤー</p>
    <select class="mdl-textfield__input" id="layer-select">
      <option  each="{ opt, key in opts }" value="{key}">{opt.name}</option>
  </select>
</Layer>

<Disk>
    <p class="mdl-textfield__input">ディスク</p>
    <select class="mdl-textfield__input" id="disk-select">
      <option  each="{ opt, key in opts }" value="{key}">{opt.name}</option>
  </select>
</Disk>

<Driver>
    <p class="mdl-textfield__input">ドライバー</p>
    <select class="mdl-textfield__input" id="driver-select">
      <option  each="{ opt, key in opts }" value="{key}">{opt.name}</option>
  </select>
</Driver>

<RadarChart>
    <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect" onclick={f1}>けってい</button><br>
    <img id="chart">

    <script>
        f1(e) {
            let layerValue = document.getElementById('layer-select').value
            let diskValue = document.getElementById('disk-select').value
            let driverValue = document.getElementById('driver-select').value

            let selectedLayer = opts.Layer[layerValue]
            let selectedDisk = opts.Disk[diskValue]
            let selectedDriver = opts.Driver[driverValue]

            let url = f2(selectedLayer, selectedDisk, selectedDriver)

            document.getElementById('chart').src = url

            return
        }

        function f2(layer, disk, driver) {

            console.log(layer)
            console.log(disk)
            console.log(driver)

            let attack = layer.attack + disk.attack + driver.attack
            let defense = layer.defense + disk.defense + driver.defense
            let stamina = layer.stamina + disk.stamina + driver.stamina
            let weight = layer.weight + disk.weight + driver.weight
            let speed = layer.speed + disk.speed + driver.speed
            let burst = layer.burst

            let url = encodeURI("http://chart.apis.google.com/chart?cht=r&chxt=x,y&chds=0,10&chco=FF0000&chd=t:" + attack + "," + defense + "," + stamina + "," + weight + "," + speed + "," + burst + "," + attack + "&chls=2&chm=B,FF000020,0,0,0&chxl=1:|0|2.5|5|7.5|10|0:|攻撃力|防御力|持久力|重量|機動力|バースト力&chs=320x320")

            console.log(url)
            return url
        }
    </script>
</RadarChart>