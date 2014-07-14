#!/bin/bash
source PKGBUILD
curdir=$PWD
tmpdir=$(mktemp -d)
cd $tmpdir
git clone $curdir
checkout=${curdir##*/}
rm -rf $checkout/.git $checkout/make-release.sh $checkout/.gitignore  $checkout/PKGBUILD
tar czvf "${pkgname}-${pkgver}-${pkgrel}.tar.gz" $checkout
cp "${pkgname}-${pkgver}-${pkgrel}.tar.gz" $curdir
echo "Wrote ${pkgname}-${pkgver}-${pkgrel}.tar.gz"
cd $curdir
s3cmd put "${pkgname}-${pkgver}-${pkgrel}.tar.gz" s3://rubyists/aur/${pkgname}/"${pkgname}-${pkgver}-${pkgrel}.tar.gz"
s3cmd setacl --acl-public "s3://rubyists/aur/${pkgname}/${pkgname}-${pkgver}-${pkgrel}.tar.gz"
makepkg -g >> PKGBUILD
vim PKGBUILD
mkaurball
if [ -v AUR_USER ];then
  burp -u $AUR_USER -p $(<~/.aurpass) -c system -C ~/.burpcookies ${pkgname}-${pkgver}-${pkgrel}.src.tar.gz
else
  echo "Don't forget to upload to AUR"
fi
