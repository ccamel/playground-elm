module.exports = {
  plugins: {
    'posthtml-expressions': {
      locals: {
        BASE_URL: process.env.BASE_URL,
      },
    },
  },
};
