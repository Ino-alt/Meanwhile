import { Controller } from "@hotwired/stimulus"

// ボトムシートの開閉を管理するコントローラー
export default class extends Controller {
  static targets = ["sheet", "overlay"]

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
}
