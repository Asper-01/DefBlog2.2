import { Application } from "@hotwired/stimulus"
import ToggleController from "./toggle_controller"
import Rails from "@rails/ujs"

Rails.start();

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Enregistrement des contrôleurs
application.register("toggle-reply", ToggleController)

export { application }
