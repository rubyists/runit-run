# This PKGBUILD replaces sysV init scheme
# with the runit supervision system.  see
# smarden.org/runit for more information.

# Contributor: Kevin Berry <kb@rubyists.com>
# Maintainer: TJ Vanderpoel <tj@rubyists.com>
pkgname='runit-run'
pkgver=1.1.2
pkgrel=3
pkgdesc="A SysV replacement init scheme with parallel start-up and flexible service directories"
arch=('i686' 'x86_64')
url="http://github.com/rubyists/runit-run"
license=('custom')
provides=('runit-run')
conflicts=('runit-run-git' 'initscripts')
depends=('runit' 'runit-services>=1.1.0' 'ngetty' 'sysvinit' 'sysvinit-tools' 'syslog-ng')
optdepends=('socklog-dietlibc: advanced logging system' 
            'sv-helper: Wrapper for easy service management')
backup=('etc/rc.conf' 'etc/runit/1' 'etc/runit/2' 'etc/runit/3')
install='runit-run.install'
source=("https://s3.amazonaws.com/rubyists/aur/${pkgname}/${pkgname}-${pkgver}-${pkgrel}.tar.gz")
md5sums=('e8437d7bd53e2470ce18ca7afb39cf3f')

package() {
  cd "$srcdir/$_gitname/"

  # Support functions for rc. scripts. Cloned from arch initscripts, Feb 2013
  install -D -d "$pkgdir/etc/runit/rc/functions.d"
  install -m 0755 etc/runit/rc/functions "$pkgdir/etc/runit/rc/functions"
  for fun in etc/runit/rc/functions.d/*;do
    install -m 0755 etc/runit/rc/functions.d/${fun##*/}  "$pkgdir/etc/runit/rc/functions.d/${fun##*/}"
  done

  # The rc. scripts. Cloned from arch initscripts, Feb 2013
  for script in sysinit single multi shutdown local local.shutdown; do
    install -m 0755 etc/runit/rc/rc.${script} "$pkgdir/etc/runit/rc/rc.${script}"
  done

  # For legagy rc.conf stuff
  install -m 0644 etc/runit/rc/rc.conf "$pkgdir/etc/runit/rc/rc.conf"
  install -m 0755 -d -D "$pkgdir/etc/rc.d"
  ln -s /etc/runit/rc/functions "$pkgdir/etc/rc.d"

  # The 3 init levels. Startup (1), runtime (2), and shutdown (3), plus
  # the script for action to taks on ctrl-alt-del
  for init in 1 2 3 ctrlaltdel;do
    install -m 0755 etc/runit/${init} "$pkgdir/etc/runit/${init}"
  done

  install -D -m 0644 README.runit-run "$pkgdir/usr/share/doc/runit-run/README"
  install -D -m 0644 COPYRIGHT "$pkgdir/usr/share/doc/runit-run/COPYRIGHT"

  # Add a couple service levels
  install -d "$pkgdir/etc/runit/runsvdir/runit-run-default" # sshd, no syslog
  install -d "$pkgdir/etc/runit/runsvdir/archlinux-default" # Standard, with syslog and sshd
  ln -s /etc/sv/ngetty "$pkgdir/etc/runit/runsvdir/runit-run-default/"
  ln -s /etc/sv/cron "$pkgdir/etc/runit/runsvdir/runit-run-default/"
  ln -s /etc/sv/sshd "$pkgdir/etc/runit/runsvdir/runit-run-default/"

  ln -s /etc/sv/ngetty "$pkgdir/etc/runit/runsvdir/archlinux-default/"
  ln -s /etc/sv/syslog-ng "$pkgdir/etc/runit/runsvdir/archlinux-default/"
  ln -s /etc/sv/sshd "$pkgdir/etc/runit/runsvdir/archlinux-default/"
  ln -s /etc/sv/cron "$pkgdir/etc/runit/runsvdir/archlinux-default/"
} 
