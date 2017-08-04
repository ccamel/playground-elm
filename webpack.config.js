'use strict';

var path = require('path');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var CleanWebpackPlugin = require('clean-webpack-plugin');
var webpack = require('webpack');

module.exports = {
    entry: {
        app: './src/resources/index.js',
        vendor: [
            'bootstrap',
            'animate.css'
        ]
    },

    plugins: [
        new CleanWebpackPlugin(['dist']),
        new HtmlWebpackPlugin({
            filename: 'index.html',
            template: './src/resources/index.ejs'
        }),
        new webpack.optimize.CommonsChunkPlugin({
            name: 'vendor'
        }),
        new webpack.optimize.CommonsChunkPlugin({
            name: 'runtime'
        }),
    ],

    output: {
        path: path.resolve(__dirname + '/dist'),
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
                loader: 'elm-webpack?verbose=true&warn=true'
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
