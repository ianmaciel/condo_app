const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const ewelink = require("./ewelink");
const virtualKey = require("./virtual_key");
exports.getDevices = functions.https.onCall(ewelink.getDevices);
exports.toggleCarGate = functions.https.onCall(ewelink.toggleCarGate);
exports.setCarGateStateOn = functions.https.onCall(ewelink.setCarGateStateOn);
exports.getVirtualKey = functions.https.onCall(virtualKey.getVirtualKey);
exports.openGateWithKey = functions.https.onCall(virtualKey.openGateWithKey);
