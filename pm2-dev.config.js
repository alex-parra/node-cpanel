module.exports = {
  apps: [
    {
      name: 'node-cpanel',
      script: './src/server.js',
      watch: ['./src/**/*.js'],
      env: {
        NODE_ENV: 'development',
      },
    },
  ],
};
