FROM frolvlad/alpine-glibc

COPY texlive-profile.txt /tmp/

# set up packages
RUN apk add --no-cache wget perl xz bash && \
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    install-tl-20*/install-tl --profile=/tmp/texlive-profile.txt && \
    rm -rf install-tl-*

ENV PATH=/usr/local/texlive/bin/x86_64-linux:$PATH

RUN tlmgr update --self

# base
RUN tlmgr install \
  collection-latexrecommended \
  latex \
  latex-bin

# math and algo
RUN tlmgr install \
  mathtools \
  amsmath \
  amscls \
  algorithms \
  algorithmicx \
  algorithm2e

# fonts and languages
RUN tlmgr install \
  babel-english \
  latex-fonts \
  collection-fontsrecommended \
  collection-fontsextra \
  lm

# graphical
RUN tlmgr install \
  graphics \
  xcolor \
  epstopdf \
  geometry \
  pgf \
  pgfplots

# other
RUN tlmgr install \
  tools \
  preprint \
  float \
  hyperref \
  caption \
  relsize \
  oberdiek
