export PATH="$HOME/.local/bin/:$PATH:$HOME/go/bin/:$HOME/.cargo/bin/"
export EDITOR=nvim
export BAT_PAGER="less -RF"

export RUST_BACKTRACE=1
export RUSTFLAGS="-C link-arg=-fuse-ld=lld"
export CXX="clang++"
export CXXFLAGS="-Wall -Wextra -Werror -std=c++17 -g -pedantic"
#export CPPFLAGS="-MMD -D_GLIBCXX_DEBUG"
