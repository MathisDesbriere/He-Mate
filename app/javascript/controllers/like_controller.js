import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["likeCount", "likeIcon"];

  connect() {
    // Code to run when the controller is connected
    const tripId = this.element.dataset.tripId;
    this.clicked = false;
    console.log(this.clicked)
    console.log(tripId)
    // console.log(this.likeCountTarget);
    // console.log(this.likeIconTarget);
  }

  async like(event) {
    event.preventDefault();

    const tripId = this.element.dataset.tripId;
    if (this.clicked) {
      this.clicked = false;
    } else {
      this.clicked = true;
    }

    try {
      const response = await fetch(`/trips/${tripId}/like`,

      {method: "POST", headers: {'content-type': 'application/json'
       ,'accept': 'application/json'
      ,"X-CSRF-Token": document.querySelector("[name='csrf-token']").getAttribute("content")}})
      const data = await response.json();

      if (this.clicked) {
        this.likeIconTarget.classList.remove("fa-regular");
        this.likeIconTarget.classList.add("fa-solid");
      } else {
        this.likeIconTarget.classList.remove("fa-solid");
        this.likeIconTarget.classList.add("fa-regular");
      }
      console.log(this.clicked)
      this.likeCountTarget.innerText = data.count;
    } catch (error) {
      console.log(error);
    }
  }

}
