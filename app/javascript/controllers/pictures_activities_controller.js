import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pictures-activities"
export default class extends Controller {
  static targets = ['pictures', 'plus', 'minus']

  connect() {
    console.log("hello")
  }

  toggle(event) {
    event.preventDefault()
    if (this.minusTarget.classList.contains("d-none")) {
      this.picturesTarget.classList.remove("d-none")
      this.minusTarget.classList.remove("d-none")
      this.plusTarget.classList.add("d-none")
    }
    else {
      this.picturesTarget.classList.add("d-none")
      this.minusTarget.classList.add("d-none")
      this.plusTarget.classList.remove("d-none")
    }
  }
}
