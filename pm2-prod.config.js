module.exports = {
  apps: [
    {
      name: 'node-cpanel',
      script: './src/server.js',
      watch: false,
      exec_mode: 'cluster',
      instances: 1,
      env: {
        NODE_ENV: 'production',
      },
    },
  ],
};
