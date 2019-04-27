const appConfig = require('../webpack.config')

module.exports = async ({ config, mode }) => {
  config.entry.push('/usr/local/pankara/app/stylesheet/application.scss')
  config.module.rules = appConfig.module.rules
  config.resolve = appConfig.resolve
  return config
}
