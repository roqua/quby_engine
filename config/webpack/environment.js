const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')

environment.loaders.prepend('typescript', typescript)

// replace css-loader with typings-for-css-modules-loader
environment.loaders.get('moduleSass').use = environment.loaders.get('moduleSass').use.map((u) => {
  if(u.loader == 'css-loader') {
    return { ...u, loader: 'typings-for-css-modules-loader' };
  } else {
    return u;
  }
});

module.exports = environment

