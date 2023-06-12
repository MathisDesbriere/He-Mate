import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["likeCount", "likeIcon"];

  connect() {
    // Code to run when the controller is connected
    const tripId = this.element.dataset.tripId;
    this.clicked = false;
    console.log(this.clicked)

  }

  async like(event) {
    event.preventDefault();

    const tripId = this.element.dataset.tripId;

    if (this.clicked) {
      try {
        console.log(this.clicked)
          const response = await fetch(`/trips/${tripId}/like?count=1`,

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
          this.likeCountTarget.innerText = data.count;
        } catch (error) {
          console.log(error);
        }
      this.clicked = false;
    } else {
      try {
        const response = await fetch(`/trips/${tripId}/like?count=-1`,

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
        this.likeCountTarget.innerText = data.count;
      } catch (error) {
        console.log(error);
      }
      this.clicked = true;
    }

    // try {
    //   const response = await fetch(`/trips/${tripId}/like`,

    //   {method: "POST", headers: {'content-type': 'application/json'
    //    ,'accept': 'application/json'
    //   ,"X-CSRF-Token": document.querySelector("[name='csrf-token']").getAttribute("content")}})
    //   const data = await response.json();

    //   if (this.clicked) {
    //     this.likeIconTarget.classList.remove("fa-regular");
    //     this.likeIconTarget.classList.add("fa-solid");
    //   } else {
    //     this.likeIconTarget.classList.remove("fa-solid");
    //     this.likeIconTarget.classList.add("fa-regular");
    //   }
    //   console.log(this.clicked)
    //   this.likeCountTarget.innerText = data.count;
    // } catch (error) {
    //   console.log(error);
    // }
  }

}
