
// @ts-expect-error
import { Elm } from "./src/Main.elm";

const app = Elm.Main.init({ node: document.getElementById("app") });

app.ports.sendText.subscribe(async (message: string) => {
    let success = "fail";
    try {
        await navigator.clipboard.writeText(message);
        console.log("Text copied");
        success = "success";
    } catch (err) {
        console.error("Error copying", err);
    }

    app.ports.acknowledge.send(success);
})
