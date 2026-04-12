import { Controller } from "@hotwired/stimulus"

// ボトムシートおよびポップアップの開閉を管理するコントローラー
export default class extends Controller {
  static targets = ["sheet", "overlay", "step1", "step2"]

  // ＋ボタンが押されたらボトムシートとオーバーレイを表示する
  open() {
    this.sheetTarget.classList.remove("hidden")
    this.overlayTarget.classList.remove("hidden")
  }

  // ✕ボタンまたはオーバーレイをタップしたら閉じる
  close() {
    this.sheetTarget.classList.add("hidden")
    this.overlayTarget.classList.add("hidden")
  }

  // Step1（国・時刻表示）を非表示にしてStep2（質問・入力）を表示する
  nextStep() {
    this.step1Target.classList.add("hidden")
    this.step2Target.classList.remove("hidden")
  }

  // Step1・Step2両方を非表示にしてポップアップを閉じる
  closePopup() {
    this.step1Target.classList.add("hidden")
    this.step2Target.classList.add("hidden")
  }
}
