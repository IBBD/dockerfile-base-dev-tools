#
# Base Dev Tools Dockerfile
#
# https://github.com/ibbd/dockerfile-base-dev-tools
#
# sudo docker build -t ibbd/base-dev-tools ./
#
# @todo 命令行输入不了中文也显示不了中文
#

# Pull base image.
FROM buildpack-deps:jessie

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# sources.list
# git clone git@github.com:IBBD/docker-compose.git
# 如果导致apt-get Install不成功，可以先注释这句
#ADD ext/sources.list   /etc/apt/sources.list
#ADD ext/oh-my-zsh.sh   /oh-my-zsh.sh

# 安装公共开发工具的工具
RUN \
    apt-get update \
    && apt-get install -y \
        apt-transport-https \
        build-essential \
        man \
        git \
        git-flow \
        vim \
        tmux \
        python-dev \
        python-pip \
        locales \
    && pip install --upgrade pip \
    && pip install --upgrade virtualenv \
    && pip install mycli \
    && git config --global push.default simple \
    && rm -r /var/lib/apt/lists/*

# 配置系统
RUN dpkg-reconfigure locales \
    && locale-gen C.UTF-8 \
    && /usr/sbin/update-locale LANG=C.UTF-8

# 解决时区问题
ENV TZ "Asia/Shanghai"
ENV LC_ALL C.UTF-8

# 安装vim插件
# 解决vim中文显示的问题
# install oh-my-zsh
#&& sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" \
#&& sed -i -E "s/^plugins=\((.*)\)$/plugins=(\1 tmux)/" ~/.zshrc \
# 一直报错：sh: 52: /root/.zshrc: Syntax error: "(" unexpected")"
# 如果是本地构建，使用预先下载的形式
#ADD ext/spf13-vim.sh /spf13-vim.sh 
#RUN sh /spf13-vim.sh \
RUN curl http://j.mp/spf13-vim3 -L -o - | sh \
    && echo "set fileencodings=utf-8" >> /etc/vim/vimrc \
    && echo "set fileencoding=utf-8" >> /etc/vim/vimrc \
    && echo "set encoding=utf-8" >> /etc/vim/vimrc \
    && rm -f /spf13-vim.sh

ADD ext/vimrc.local  /root/.vimrc.local
ADD ext/bashrc       /root/.bashrc

# 代码目录
RUN mkdir -p /var/www 
WORKDIR /var/www

VOLUME /var/www

