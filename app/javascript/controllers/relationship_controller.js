import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['follow', 'unfollow'];

  follow(event) {
    event.preventDefault()
    const followForm = this.followTarget.querySelector('input[name="follow[user_id]"]');
    // const unfollowForm = this.unfollowTarget.querySelector('input[name="follow[user_id]"]');
    const userId = followForm.dataset.userId;

    fetch(`/relationships/follow_user/${userId}`, {
      method: 'POST',
      headers: { "Accept": "application/json" },
      body: new FormData(this.followTarget)
     })
      .then(response => {
        if (response.ok) {
          this.followTarget.classList.add('d-none');
          this.unfollowTarget.classList.remove('d-none');
        }
      });
  }

  unfollow(event) {
    event.preventDefault();
    // const followForm = this.followTarget;
    // const unfollowForm = this.unfollowTarget;
    const unfollowForm = this.unfollowTarget.querySelector('input[name="follow[user_id]"]');

    const userId = this.unfollowTarget.dataset.userId;

    fetch(`/relationships/unfollow_user/${userId}`, {
      method: 'POST',
      headers: { "Accept": "application/json" },
      body: new FormData(this.unfollowTarget)
     })
      .then(response => {
        if (response.ok) {
          this.unfollowTarget.classList.add('d-none');
          this.followTarget.classList.remove('d-none');
        }
      });

  }
}
