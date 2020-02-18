// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket";

import "phoenix_html";
import LiveSocket from "phoenix_live_view";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", {
  params: { _csrf_token: csrfToken }
});
var a = liveSocket.connect();
console.log(a);
