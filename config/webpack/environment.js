const { environment } = require('@rails/webpacker')
const sassLoader = environment.loaders.get('sass');

// jQuery
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)
// jQuery

const sassLoaderOptions = sassLoader.use.find(loader => loader.loader === 'sass-loader').options;
sassLoaderOptions.implementation = require('sass');

module.exports = environment
