return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

  
        alpha.setup(dashboard.config)
    end
}
    