let Room = {
  init(socket, htmlElement) {
    const roomId = htmlElement.getAttribute("data-id")
    const name = htmlElement.getAttribute("data-name")
    const isHost = htmlElement.getAttribute("data-is-host") == 'true'

    socket.connect()
    this.onReady({ roomId, name, isHost }, socket)
  },

  onReady({ roomId, name, isHost }, socket) {
    const roomChannel = socket.channel("rooms:" + roomId)
    const buzzerButton = document.getElementById("buzzer-button")
    const msgContainer = document.getElementById("msg-container")
    const exitLink = document.getElementById("buzzer-exit")
    const resetButton = document.getElementById("reset-button")

    if (!isHost) exitLink.style.visibility = 'hidden'

    buzzerButton.addEventListener("click", e => {
      roomChannel.push("buzzer_press", { body: name })
        .receive("error", e => console.log(e))
    })

    roomChannel.on("buzzer_press", resp => {
      const presser = resp.body
      buzzerButton.disabled = true
      this.renderPressMessage(msgContainer, presser)
      if (isHost) resetButton.style.visibility = 'visible'
    })

    resetButton.addEventListener("click", e => {
      roomChannel.push("buzzer_reset", {})
        .receive("error", e => console.log(e))
    })

    exitLink.addEventListener("click", e => {
      e.preventDefault()
      let href = e.target.href

      roomChannel
        .push("room_close", { body: { name, href, roomId } })
        .receive("error", e => console.log(e))
    })

    roomChannel.on("buzzer_reset", resp => {
      buzzerButton.disabled = false
      msgContainer.innerHTML = ''
      if (isHost) resetButton.style.visibility = 'hidden';
    })

    roomChannel.on("room_close", resp => {
      const { href, name } = resp.body
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
    const div = document.createElement("div")
    div.appendChild(document.createTextNode(input))
    return div.innerHTML
  },

  renderPressMessage(msgContainer, presser) {
    const div = document.createElement("div")

    div.innerHTML = `
    <span>
      <strong>${this.esc(presser)} pressed the button!</strong>
    </span>
    `
    msgContainer.appendChild(div)
  }
}

export default Room