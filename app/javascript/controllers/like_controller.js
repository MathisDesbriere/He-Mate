import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["likeCount", "likeIcon"];

  connect() {
    // Code to run when the controller is connected
    console.log("Success");

  }

  async like(event) {
    event.preventDefault();

    const tripId = this.element.dataset.tripId;
    try {
      const response = await fetch(`/trips/${tripId}/like`,
        {
          method: "POST",
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
            "X-CSRF-Token": document.querySelector("[name='csrf-token']").getAttribute("content")
          }
        }
      );
      if (response.ok) {
        const data = await response.json();
        if (data.count.length > 0) {
          this.likeIconTarget.classList.remove("fa-regular");
          this.likeIconTarget.classList.add("fa-solid");
        } else {
          this.likeIconTarget.classList.remove("fa-solid");
          this.likeIconTarget.classList.add("fa-regular");
        }
        const totalNum = parseInt(this.likeCountTarget.innerText);
        this.likeCountTarget.innerText =  data.count.length;

      } else {
        console.log("Failed to update like count");
      }
    } catch (error) {
      console.log(error);
    }
  }



  }
