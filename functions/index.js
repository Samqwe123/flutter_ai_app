/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {setGlobalOptions} = require("firebase-functions");
const {onRequest} = require("firebase-functions/https");
const logger = require("firebase-functions/logger");

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require('firebase-functions');
const fetch = require('node-fetch');

exports.steamUserStatsProxy = functions.https.onRequest(async (req, res) => {

  if (req.method === 'OPTIONS') {
    res.set('Access-Control-Allow-Origin', '*');
    res.set('Access-Control-Allow-Methods', 'GET, POST');
    res.set('Access-Control-Allow-Headers', 'Content-Type');
    res.status(204).send('');
    return;
  }

  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST');
  res.set('Access-Control-Allow-Headers', 'Content-Type');

  const steamId = req.query.steamid;
  const appId = req.query.appid;
  const apiKey = req.query.apikey;
  const urlAchievements = `https://api.steampowered.com/ISteamUserStats/GetPlayerAchievements/v0001/?appid=${appId}&key=${apiKey}&steamid=${steamId}&l=en`;
  const urlSchema = `https://api.steampowered.com/ISteamUserStats/GetSchemaForGame/v2/?key=${apiKey}&appid=${appId}`;

  const achievementsResponse = await fetch(urlAchievements);
  const achievementsData = await achievementsResponse.json();

    const schemaResponse = await fetch(urlSchema);
    const schemaData = await schemaResponse.json();

    res.json({
      achievements: achievementsData,
      schema: schemaData,
    });
  }
  );

  // Proxy Steam CDN images to resolve CORS issues
  exports.steamImageProxy = functions.https.onRequest(async (req, res) => {
    const imageUrl = req.query.url;
    if (!imageUrl) {
      return res.status(400).json({ error: 'Missing image URL' });
    }
    try {
      const response = await fetch(imageUrl, {
        headers: {
          'User-Agent': 'Mozilla/5.0'
        }
      });
      const contentType = response.headers.get('content-type');
      const buffer = await response.buffer();
      res.set('Access-Control-Allow-Origin', '*');
      res.set('Content-Type', contentType);
      res.send(buffer);
    } catch (error) {
      res.status(500).json({ error: 'Failed to fetch image' });
    }
  });


