FROM debian:stable-slim

MAINTAINER Valerio Casalino <casalinovalerio.cv@gmail.com>

# Configuring user to run inside the container
RUN useradd -ms /bin/bash dtexlive

# Update and install texlive
RUN apt -y update && apt -y install texlive-full

# Clean apt and don't make it look for upgrades
RUN apt -y autoremove && apt -y autoclean && rm -rf /var/lib/apt/lists

# Increase main memory dedicated to tex
RUN echo "\nmain_memory = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && echo "\nextra_mem_bot = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && echo "\nfont_mem_size = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && echo "\npool_size = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && echo "\nbuf_size = 12000000" >> /etc/texmf/texmf.d/00debian.cnf \
    && update-texmf && texhash

WORKDIR /usr/src/project
USER dtexlive
