import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["likeCount", "likeIcon"];

  connect() {
    // Code to run when the controller is connected
    console.log("Success");
    // this.clicked = false
    // console.log(this.clicked);
  }

  async like(event) {
    event.preventDefault();

    this.clicked = false;
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
        console.log(data);
        if (data.current_user && data.current_user.id && data.count.some(item => item.user_id === data.current_user.id)) {
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
