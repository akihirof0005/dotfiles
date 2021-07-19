#!/bin/zsh
if ! "${PERL5_FLAG}"; then
  echo "perl is disable."
  exit 0
fi

if [ -e "$HOME/.perl5" ]; then
  echo "exist ~/.perl5"
  echo "please remove ~/.perl5 if you reinstall perl enviroment."
  exit 0
fi


PERL_VERSION=$PERL5_VER

PERL_BIN_DIR=$HOME/.perl5
PERL_CPANM_OPT="--local-lib=~/.perl5"
PATH=$HOME/.perl5/bin:$PATH;
PERL5LIB=$HOME/.perl5/lib/perl5:$PERL5LIB;

cd /tmp
wget https://www.cpan.org/src/5.0/perl-$PERL_VERSION.tar.gz
tar xf perl-$PERL_VERSION.tar.gz
cd perl-$PERL_VERSION
./Configure -Dprefix=$PERL_BIN_DIR -Dscriptdir=$PERL_BIN_DIR/bin -des -Dman1dir=none -Dman3dir=none -DDEBUGGING=-g
make -j4
make install

cd $PERL_BIN_DIR/bin
curl -L https://cpanmin.us/ -o cpanm
chmod +x cpanm
cpanm App::cpanminus
fi
