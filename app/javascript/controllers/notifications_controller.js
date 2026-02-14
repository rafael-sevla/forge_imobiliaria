import { Controller } from "@hotwired/stimulus"
import Notiflix from "notiflix"

export default class extends Controller {
  static values = {
    notice: String,
    alert: String,
    errors: Array
  }

  connect() {
    Notiflix.Notify.init({
      width: "340px",
      position: "right-bottom",
      distance: "16px",
      borderRadius: "6px",
      timeout: 4000,
      clickToClose: true,
      pauseOnHover: true,
      fontFamily: "inherit",
      fontSize: "14px",
    })

    if (this.hasNoticeValue && this.noticeValue.trim() !== "") {
      Notiflix.Notify.success(this.noticeValue)
    }

    if (this.hasAlertValue && this.alertValue.trim() !== "") {
      Notiflix.Notify.failure(this.alertValue)
    }

    if (this.hasErrorsValue && this.errorsValue.length > 0) {
      this.errorsValue.forEach(message => Notiflix.Notify.failure(message))
    }
  }
}
