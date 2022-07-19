const admin = require("firebase-admin");
const functions = require("firebase-functions");
const sanitizer = require("sanitizer");
const ewelink = require("../ewelink");
const db = admin.firestore();

/**
 * Get the virtual key details
 * @param {object} data user-provided data.
 * @param {object} context automagic context.
 */
async function getVirtualKey(data, context) {
  const id = sanitizer.sanitize(data.id);
  const virtualKey = (await db.doc(`/virtualKeys/${id}`).get()).data();
  const token = sanitizer.sanitize(data.token);
  if (virtualKey && virtualKey.token == token) {
    return virtualKey;
  }
  throw new functions.https.HttpsError("permission-denied", "Invalid key");
}

/**
 * Open the gate using the key
 * @param {object} data user-provided data.
 * @param {object} context automagic context.
 */
async function openGateWithKey(data, context) {
  const id = sanitizer.sanitize(data.id);
  const virtualKey = (await db.doc(`v/irtualKeys/${id}`).get()).data();
  const token = sanitizer.sanitize(data.token);
  const qrcode = sanitizer.sanitize(data.qrcode);
  // TODO - check if key is valid.
  // TODO: remove this hardcoded value. Each door should have its own code.
  if (virtualKey && virtualKey.token == token && qrcode == 'xDDI3l4iQzn') {
    return await ewelink.secureSetDevicePowerState("on");
  }
  throw new functions.https.HttpsError("permission-denied", "Invalid key");
}

module.exports = {
  getVirtualKey,
  openGateWithKey,
};
