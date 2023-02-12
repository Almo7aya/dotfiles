emulate sh
source ~/.profile
emulate zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/node@16/bin:/opt/homebrew/opt/openjdk/bin:/Users/almo7aya/.local/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

export PATH="$PATH:$HOME/go/bin"

export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

export PATH="$PATH:/Applications/Neovide.app/Contents/MacOS"

export PATH="$PATH:$HOME/.bin"

export PATH="$PATH:$HOME/Library/Android/sdk/tools"

export ANDROID_HOME="$HOME/Library/Android/sdk"

export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

export PATH="$(brew --prefix)/opt/binutils/bin:$PATH"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# export HELIX_RUNTIME="$HOME/.local/share/helix"

# export CC="gcc-12"
# export cc="gcc-12"
# export gcc12="gcc-12"
# export gcc="gcc-12"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"


export ESLINT_D_LOCAL_ESLINT_ONLY=1

##
# Your previous /Users/almo7aya/.zprofile file was backed up as /Users/almo7aya/.zprofile.macports-saved_2022-10-02_at_09:38:44
##

# MacPorts Installer addition on 2022-10-02_at_09:38:44: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2022-10-02_at_09:38:44: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.

