let Room = {
  init(socket, htmlElement) {
    let roomId = htmlElement.getAttribute("data-id");
    let name = htmlElement.getAttribute("data-name");
    let isHost = htmlElement.getAttribute("data-is-host") == 'true';
    socket.connect();
    this.onReady({ roomId, name, isHost }, socket);
  },

  onReady({ roomId, name, isHost }, socket) {
    let buzzerButton = document.getElementById("buzzer-button")
    let roomChannel = socket.channel("rooms:" + roomId)
    let msgContainer = document.getElementById("msg-container")
    let exitLink = document.getElementById("buzzer-exit")
    let resetButton = document.getElementById("reset-button")

    if (!isHost) exitLink.style.visibility = 'hidden'

    buzzerButton.addEventListener("click", e => {
      roomChannel.push("buzzer_press", { body: name })
        .receive("error", e => console.log(e))
    })

    roomChannel.on("buzzer_press", resp => {
      let presser = resp.body
      buzzerButton.disabled = true
      this.renderPressMessage(msgContainer, presser)
      if (isHost) resetButton.style.visibility = 'visible'
    })

    resetButton.addEventListener("click", e => {
      roomChannel.push("buzzer_reset", {})
        .receive("error", e => console.log(e))
    })

    roomChannel.on("buzzer_reset", resp => {
      buzzerButton.disabled = false
      msgContainer.innerHTML = ''
      if (isHost) {
        resetButton.style.visibility = 'hidden';
      }
    })

    exitLink.addEventListener("click", e => {
      e.preventDefault()
      let href = e.target.href

      roomChannel.push("room_close", { body: { name, href, roomId } })
        .receive("error", e => console.log(e))
    })

    roomChannel.on("room_close", resp => {
      console.log(resp)
      let { href, name } = resp.body
      alert(`This room has been closed by ${name}`)
      window.location = href
    })

    roomChannel
      .join()
      .receive("ok", response => console.log("joined room channel", response))
      .receive("error", reason => console.log("failed to join", reason));

    window.onbeforeunload = e => {
      return 'Are you sure you want to exit?'
    }
  },

  esc(input) {
    let div = document.createElement("div")
    div.appendChild(document.createTextNode(input))
    return div.innerHTML
  },

  renderPressMessage(msgContainer, presser) {
    let div = document.createElement("div")

    div.innerHTML = `
    <span>
      <strong>${this.esc(presser)} pressed the button!</strong>
    </span>
    `
    msgContainer.appendChild(div)
  }
}

export default Room