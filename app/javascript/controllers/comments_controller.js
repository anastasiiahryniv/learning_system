import { Controller } from 'stimulus';
export default class extends Controller {
    initialize() {}
    connect() {}
    toggleEditForm(event) {
        this._toggleForm(event, ["form", "body"]);
    }

    toggleReplyForm(event) {
        this._toggleForm(event, ["form"]);
    }

    _toggleForm(event, params) {
        event.preventDefault();
        event.stopPropagation();
        params.forEach(param => {
            const element = document.getElementById(event.params[param]);
            element.classList.toggle("d-none");
            if (param === "form") element.classList.toggle("mt-5");
        });
    }
}
