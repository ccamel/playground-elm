'use strict';

var path = require('path');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var CleanWebpackPlugin = require('clean-webpack-plugin');
var webpack = require('webpack');
var ZipPlugin = require('zip-webpack-plugin');

module.exports = {
    watchOptions: {
        poll: true
    },
    entry: {
        app: './src/resources/index.js',
        vendor: [
            'jquery',
            'tether',
            'bootstrap',
            'animate.css'
        ]
    },

    plugins: [
        new webpack.DefinePlugin({
          'process.env.NODE_ENV': JSON.stringify('development')
        }),
        new CleanWebpackPlugin(['dist']),
        new webpack.optimize.UglifyJsPlugin({
            compress: {
              warnings: false
            }
        }),
        new ZipPlugin({
            path: '..',
            filename: 'playground-elm-site.zip',
            extension: 'zip',
            pathPrefix: './'
        }),
        new webpack.ProvidePlugin({
            $: 'jquery',
            jQuery: 'jquery',
            'window.jQuery': 'jquery',
            'Tether': 'tether',
            'window.Tether': 'tether',
            Popper: ['popper.js', 'default']
        }),
        new HtmlWebpackPlugin({
            filename: 'index.html',
            template: './src/resources/index.ejs'
        }),
        new webpack.optimize.CommonsChunkPlugin({
            name: 'vendor'
        }),
        new webpack.optimize.CommonsChunkPlugin({
            name: 'runtime'
        })
    ],

    output: {
        path: path.resolve(__dirname + '/dist/site'),
        filename: '[name]-[chunkhash].js'
    },

    module: {
        loaders: [
            {
                test: /\.(css|scss)$/,
                loaders: [
                    'style-loader',
                    'css-loader'
                ]
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'elm-webpack-loader?verbose=true&warn=true'
            },
            {
                test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'url-loader?limit=10000&mimetype=application/font-woff'
            },
            {
                test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'file-loader'
            }
        ],

        noParse: /\.elm$/
    },

    devServer: {
        inline: true,
        stats: {colors: true}
    }

};
