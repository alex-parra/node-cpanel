module.exports = {
  apps: [
    {
      name: 'node-cpanel',
      script: './src/server.js',
      watch: false,
      env: {
        NODE_ENV: 'production',
      },
    },
  ],
};
