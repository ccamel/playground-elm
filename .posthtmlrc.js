const pjson = require("./package.json");

module.exports = {
  plugins: {
    "posthtml-expressions": {
      locals: {
        BASE_URL: process.env.BASE_URL,
        VERSION: pjson.version,
        DESCRIPTION: pjson.description,
        AUTHOR: pjson.author,
      },
    },
  },
};
