class EventHandler {
    constructor() {
        this.handleEvent = this.handleEvent.bind(this);
    }

    addEventHandlerToDoc(doc) {
        doc.addEventListener("select", this.handleEvent);
    }

    handleEvent(event) {
        var element = event.target
        var data = element.getAttribute("data");
        dispatchAction("increment", data, function(args) {
            element.setAttribute("data", args)
            console.log(args)
        });
    }

}