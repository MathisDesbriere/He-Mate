import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["items", "form"]
  //Connect to insert-in-list
  connect() {
  }


  send(event) {
    event.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
        this.formTarget.reset();
        this.formTarget.querySelector(".post-comment").focus();
      })
      .catch(error => {
        console.error(error)
      });
  }
}
