#!/bin/bash
wget "http://www8.plala.or.jp/p_dolce/font/ap6.zip"

wget "http://www8.plala.or.jp/p_dolce/font/ap8.zip"
wget "https://github.com/mzyy94/RictyDiminished-for-Powerline/archive/master.zip"
unzip -O cp932 ap8.zip
unzip -O cp932 ap6.zip
unzip master.zip

mkdir -p $HOME/.local/share/fonts/
mv "./あんずもじ等幅2020/APT.ttf" $HOME/.local/share/fonts/
mv "./あんずもじ始等幅/APJapanesefontHT.ttf" $HOME/.local/share/fonts/
mv ./RictyDiminished-for-Powerline-master/vim-powerline-fontpatched/* $HOME/.local/share/fonts/

rm -r "./あんずもじ等幅2020" "./あんずもじ始等幅" ap8.zip ap6.zip master.zip RictyDiminished-for-Powerline-master

 fc-cache -vf
