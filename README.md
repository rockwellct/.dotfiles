.dotfiles
=========

    # Install "laptop"
    bash <(curl -s https://raw.githubusercontent.com/thoughtbot/laptop/master/mac) 2>&1 | tee ~/laptop.log

    # Install oh-my-zsh
    curl -L http://install.ohmyz.sh | sh

    # Install dotfiles
    git clone https://github.com/rockwellct/.dotfiles.git
    rcup

    export SHELL="usr/local/bin/zsh"
    # Run laptop again
    bash <(curl -s https://raw.githubusercontent.com/thoughtbot/laptop/master/mac) 2>&1 | tee ~/laptop.log
