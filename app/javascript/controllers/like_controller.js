import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["likeCount", "likeIcon"]

  connect() {
    // Code to run when the controller is connected
    console.log("Norman test")
  }

  async like(event) {
    event.preventDefault()

    const tripId = this.data.get("trip_id")

    try {
      const response =await fetch(`/trips/${tripId}/like`, {method: "POST"})
      const data = await response.json()

      this.likeCountTarget.innerText = data.count
      this.likeIconTarget.classList.toggle("fa-regular", data.count === 0)
      this.likeIconTarget.classList.toggle("fa-solid", data.count > 0)
    } catch (error) {
      console.log(error)
    }

  }
}
