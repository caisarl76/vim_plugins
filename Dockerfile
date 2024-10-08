FROM python:3.12

WORKDIR /root/

# Install necessary packages
RUN apt-get update && \
    apt-get install -y git curl build-essential libncurses5-dev && \
    git clone https://github.com/vim/vim.git && \
    cd vim && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Node.js (required for coc.nvim)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Install vim-plug for Vim
RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install coc.nvim plugin using vim-plug
COPY vimrc /root/.vimrc
RUN vim +'PlugInstall --sync' +qa
# Install coc-pyright using coc.nvim
RUN vim +'CocInstall -sync coc-pyright' +qa
CMD ["bash"]
