require('dotenv-flow').config();

const env = (key, required = false) => {
  if (required && !(key in process.env)) throw new Error(`Required env missing: ${key}`);
  return process.env[key];
};

module.exports = {
  port: env('PORT', true),
};
