import { Controller } from "@hotwired/stimulus"

// ボトムシートおよびポップアップ（Step1〜3）の開閉・遷移を管理するコントローラー
export default class extends Controller {
  static targets = ["sheet", "overlay", "popupOverlay", "step1", "step2", "step3"]

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

  // 現在表示中のStepを非表示にして次のStepを表示する
  // Step1 → Step2 → Step3 の順に進む
  nextStep() {
    if (!this.step1Target.classList.contains("hidden")) {
      // Step1が表示中 → Step2へ
      this.step1Target.classList.add("hidden")
      this.step2Target.classList.remove("hidden")
    } else if (!this.step2Target.classList.contains("hidden")) {
      // Step2が表示中 → Step3へ
      this.step2Target.classList.add("hidden")
      this.step3Target.classList.remove("hidden")
    }
  }

  // Step1〜3およびポップアップオーバーレイをすべて非表示にしてポップアップを閉じる
  // eventを受け取りデフォルト動作とバブリングを止めることでフォーム送信を完全にブロックする
  closePopup(event) {
    event.preventDefault()
    event.stopPropagation()
    this.step1Target.classList.add("hidden")
    this.step2Target.classList.add("hidden")
    this.step3Target.classList.add("hidden")
    this.popupOverlayTarget.classList.add("hidden")
  }
}
