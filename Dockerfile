FROM nvidia/cuda:12.3.2-devel-ubuntu20.04

# あらかじめタイムゾーンの指定
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# ルートユーザーに切り替え
USER root

# sumoのインストールに必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        gdal-bin \
        libgdal-dev \
        libgdal-grass \
        proj-bin \
        proj-data \
        proj-rdnap \
        libfox-* && \
    add-apt-repository ppa:sumo/stable && \
    apt-get update && \
    apt-get install -y \
        sumo \
        sumo-tools \
        sumo-doc \
        wget \
        tar && \
    # pythonのインストール
    apt-get install -y \
        python3 \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# rubyのインストールとpycallのインストール
RUN apt-get update && \
    apt-get install -y \
        ruby \
        ruby-dev && \
    gem install pycall gnuplot && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# sumoのソースをダウンロードしてビルド
WORKDIR /root/sumosim
RUN wget https://sourceforge.net/projects/sumo/files/sumo/version%200.32.0/sumo-all-0.32.0.tar.gz && \
    tar -zxvf sumo-all-0.32.0.tar.gz && \
    rm sumo-all-0.32.0.tar.gz && \
    cd sumo-0.32.0 && \
    ./configure && \
    make && \
    make install && \
    mv /usr/local/bin/sumo /usr/local/bin/sumo0 && \
    mv /usr/local/bin/sumo-gui /usr/local/bin/sumo-gui0

# PATHを~/.profileに追加
RUN echo 'export PATH="$PATH:/usr/local/bin"' >> /root/.profile

# PyTorchのインストール、及び強化学習用のstable baseline3, gymnasiumのインストール
RUN pip3 install torch torchvision torchaudio 'stable-baselines3[extra]' gymnasium

ENV PATH="/usr/local/bin:${PATH}"

# 作業ディレクトリを設定
WORKDIR /root
