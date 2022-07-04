
const ewelink = require("./ewelink");
const functions = require("firebase-functions");
exports.getDevices = functions.https.onCall(ewelink.getDevices);
exports.toggleCarGate = functions.https.onCall(ewelink.toggleCarGate);
exports.setCarGateStateOn = functions.https.onCall(ewelink.setCarGateStateOn);
