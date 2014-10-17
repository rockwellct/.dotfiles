.dotfiles
=========

    # Install RCM
    brew tap thoughtbot/formulae
    brew install rcm

    # Install oh-my-zsh
    curl -L http://install.ohmyz.sh | sh

    # Install dotfiles
    git clone git@github.com:masonjm/.dotfiles.git
    rcup

    # Install "laptop"
    bash <(curl -s https://raw.githubusercontent.com/thoughtbot/laptop/master/mac) 2>&1 | tee ~/laptop.log