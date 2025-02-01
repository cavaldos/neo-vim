return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

        -- -- Tạo một section mới để hiển thị chữ "BOURBON"
        -- dashboard.section.header.val = {[[  ____   ___  _   _ ____  ____  _   _ _   _ ]],
        --                                 [[ | __ ) / _ \| | | | __ )| __ )| | | | \ | |]],
        --                                 [[ |  _ \| | | | | | |  _ \|  _ \| | | |  \| |]],
        --                                 [[ | |_) | |_| | |_| | |_) | |_) | |_| | |\  |]],
        --                                 [[ |____/ \___/ \___/|____/|____/ \___/|_| \_|]]}

        -- Cấu hình alpha-nvim với theme dashboard
        alpha.setup(dashboard.config)
    end
}
