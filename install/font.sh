#!/bin/bash
wget "http://structure.kais.kyoto-u.ac.jp/lab/IncoUDJP010b.zip"
unzip -O cp932 IncoUDJP010b.zip

mkdir -p $HOME/.local/share/fonts/
mv ./IncoUDJP010b/* $HOME/.local/share/fonts/

rm -r "./IncoUDJP010b" IncoUDJP010b.zip

 fc-cache -vf
