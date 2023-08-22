
import { Elm } from "./src/Main.elm";

Elm.Main.init({ node: document.getElementById("app") });

async function copyToClipboard(text: string): Promise<void> {
    try {
        await navigator.clipboard.writeText(text);
        console.log("Text copied");
    } catch (err) {
        console.error("Error copying", err);
    }
}