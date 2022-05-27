const Ewelink = require("ewelink-api");
const admin = require("firebase-admin");
const ewelinkDoc = "/configs/ewelinkConnection";
const carGateDoc = "/publicDevices/carGate";
admin.initializeApp();
const db = admin.firestore();

/**
 * Start the login with eewlink
 * @param {object} data user-provided data.
 * @param {object} context automagic context.
 */
async function getDevices(data, context) {
  const ewelink = await init();

  /* get all devices */
  const devices = await ewelink.getDevices();
  if (devices != null) {
    return {
      status: "ok",
      code: 200,
      devices: devices,
    };
  }
  return {
    status: "error",
    code: 500,
    message: "Devices are null",
  };
}

/**
 * Start the login with eewlink
 * @param {object} data user-provided data.
 * @param {object} context automagic context.
 */
async function toggleCarGate(data, context) {
  if (!context.auth) {
    return {
      status: "error",
      code: 401,
      message: "Not signed in",
    };
  }

  const carGateSnapshot = await db.doc(carGateDoc).get();
  const ewelink = await init();

  const ewelinkResponse = await ewelink.toggleDevice(
      carGateSnapshot.data().deviceid);
  return {
    status: "ok",
    code: 200,
    message: ewelinkResponse,
  };
}

/**
 * Initialize ewelink
 * @return {object} An ewelink instance.
 */
async function init() {
  const ewelinkConfigSnapshot = await db.doc(ewelinkDoc).get();
  const ewelink = await getEwelinkInstance(ewelinkConfigSnapshot.data());
  return ewelink;
}

/**
 * Check if connection exists
 * @param {object} ewelinkConfig The ewelink configuration structure (key,
 *                               user, pwd and region).
 * @return {boolean} true/false if the connection exists
 */
function isConnected(ewelinkConfig) {
  const {auth} = ewelinkConfig;
  if (auth && auth.at && auth.user.apikey && auth.region) return true;
  return false;
}

/**
 * Connect with eWelink using email and password.
 * @param {object} ewelinkConfig The ewelink configuration structure (key,
 *                               user, pwd and region).
 * @return {object} the connected ewelink instance.
 */
async function connect(ewelinkConfig) {
  const {email, password, region} = ewelinkConfig;
  console.log(email);
  console.log(password);
  console.log(region);

  const connection = new Ewelink({
    email,
    password,
    region,
  });

  const auth = await connection.getCredentials();
  await db.doc(ewelinkDoc).set(
      {auth},
      {merge: true},
  );
  return connection;
}

/**
 * Get the connected instance of eWelink.
 * @param {object} ewelinkConfig The ewelink configuration structure (key,
 *                               user, pwd and region).
 * @return {object} the already connected eWelink instance.
 */
async function getEwelinkInstance(ewelinkConfig) {
  return isConnected(ewelinkConfig) ? createEwelinkWithToken(ewelinkConfig) :
    await connect(ewelinkConfig);
}

/**
 * Create the eWelink instance using an auth token.
 * @param {object} ewelinkConfig The ewelink configuration structure (key,
 *                               user, pwd and region).
 * @return {object} the already connected eWelink instance.
 */
function createEwelinkWithToken(ewelinkConfig) {
  const {at, region} = ewelinkConfig.auth;
  return new Ewelink({
    at,
    region,
  });
}

/**
 * Start the login with eewlink.
 */
async function getRegion() {
  const {email, password} = db.doc(ewelinkDoc).get();
  const connection = new Ewelink({
    email,
    password,
  });

  const region = await connection.getRegion();
  console.log(region);
  return region;
}

module.exports = {
  getDevices,
  getRegion,
  toggleCarGate,
};
