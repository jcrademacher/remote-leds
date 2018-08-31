var path = require("path");
// const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
  entry: {
    app: [
      './src/js/index.js',
      './src/css/main.scss'
    ]
  },

  output: {
    path: path.resolve(__dirname),
    filename: '[name].js',
  },

  module: {
    rules: [
      {
        test: /\.(css|scss)$/,
        use: [
          'style-loader',
          'css-loader',
          //'postcss-loader',
          'sass-loader'
        ]
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack-loader?verbose=true&warn=true',
      },
      {
        test: /\.(eot|ttf|woff|woff2|svg)$/,
        use: 'file-loader'
      }
    ],

    noParse: /\.elm$/,
  },

  // plugins: [
  //   // extract CSS into a separate file
  //   new MiniCssExtractPlugin({
  //     // Options similar to the same options in webpackOptions.output
  //     // both options are optional
  //     filename: "[name].css",
  //     chunkFilename: "[id].css"
  //   })
  // ],

  devServer: {
    inline: true,
    contentBase: path.join(__dirname, 'dist'),
    stats: { colors: true }
  },
};
