#!/bin/bash
source PKGBUILD
curdir=$PWD
tmpdir=$(mktemp -d)
cd $tmpdir
git clone $curdir
checkout=${curdir##*/}
rm -rf $checkout/.git $checkout/.gitignore $checkout/COPYRIGHT $checkout/README.${pkgname%*-git} \
       $checkout/make-release.sh $checkout/${pkgname%*-git}.install $checkout/.gitignore \
       $checkout/PKGBUILD
tar czvf "${pkgname}-${pkgver}-${pkgrel}.tar.gz" $checkout
cp "${pkgname}-${pkgver}-${pkgrel}.tar.gz" $curdir
echo "Wrote ${pkgname}-${pkgver}-${pkgrel}.tar.gz"
