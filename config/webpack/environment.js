const { environment } = require('@rails/webpacker')

// jQuery
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)
// jQuery

module.exports = environment
