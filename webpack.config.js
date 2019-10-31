const { resolve } = require("path");

module.exports = {
  mode: "production",
  entry: "./frontend/index.ts",
  output: {
    filename: "bundle.js",
    path: resolve(__dirname, "./app/assets/javascripts/quby/frontend/")
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        loader: "awesome-typescript-loader"
      }
    ]
  },
  resolve: {
    extensions: [".ts", ".tsx", ".js", ".json"]
  },
  devtool: "source-map"
};
