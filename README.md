.dotfiles
=========

    # Install "laptop"
    bash <(curl -s https://raw.githubusercontent.com/thoughtbot/laptop/master/mac) 2>&1 | tee ~/laptop.log

    # Install oh-my-zsh
    curl -L http://install.ohmyz.sh | sh

    # Install dotfiles
    git clone git@github.com:rockwellct/.dotfiles.git
    rcup

    # Run laptop again
    bash <(curl -s https://raw.githubusercontent.com/thoughtbot/laptop/master/mac) 2>&1 | tee ~/laptop.log
