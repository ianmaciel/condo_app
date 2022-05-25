

const ewelink = require("./ewelink");
const functions = require("firebase-functions");

exports.getDevices = functions.https.onRequest(ewelink.getDevices);
exports.toggleCarGate = functions.https.onRequest(ewelink.toggleCarGate);
