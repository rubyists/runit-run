# This PKGBUILD replaces sysV init scheme
# with the runit supervision system.  see
# smarden.org/runit for more information.

# Contributor: Kevin Berry <kb@rubyists.com>
# Maintainer: TJ Vanderpoel <tj@rubyists.com>
pkgname='runit-run'
pkgver=1.0.1
pkgrel=1
pkgdesc="A SysV replacement init scheme with parallel start-up and flexible service directories"
arch=('i686' 'x86_64')
url="http://github.com/rubyists/runit-run"
license=('custom')
provides=('runit-run')
conflicts=('runit-run-git')
depends=('runit-dietlibc' 'ngetty')
optdepends=('socklog-dietlibc: advanced logging system' 
            'sv-helper: Wrapper for management of services'
            'runit-services: a collection of commonly used service directories')
backup=('etc/runit/1' 'etc/runit/2' 'etc/runit/3')
install='runit-run.install'
source=('https://github.com/downloads/rubyists/runit-run/runit-run-1.0.1-1.tar.gz')
md5sums=('b155efc561bc6c7c277f71e7265b6e21')

package() {
  cd "$srcdir/runit-run/"
  install -D -m 0755 etc/runit/1 $pkgdir/etc/runit/1
  install -m 0755 etc/runit/2 $pkgdir/etc/runit/2
  install -m 0755 etc/runit/3 $pkgdir/etc/runit/3
  install -m 0755 etc/runit/ctrlaltdel $pkgdir/etc/runit/ctrlaltdel
  install -d $pkgdir/etc/runit/runsvdir/runit-run-default
  install -d $pkgdir/etc/runit/runsvdir/archlinux-default
  install -D -m 0644 README.runit-run $pkgdir/usr/share/doc/runit-run/README
  install -D -m 0644 COPYRIGHT $pkgdir/usr/share/doc/runit-run/COPYRIGHT
  install -d $pkgdir/etc/sv
  for service in etc/sv/*;do
    cp -a $service $pkgdir/etc/sv/
  done
  install -m 0755 etc/runit/rc/functions.d/sshd-close-sessions  "$pkgdir/etc/runit/rc/functions.d/sshd-close-sessions"

  # The rc. scripts. Cloned from arch initscripts, Feb 2013
  for script in sysinit single multi shutdown local local.shutdown; do
    install -m 0755 etc/runit/rc/rc.${script} "$pkgdir/etc/runit/rc/rc.${script}"
  done

  # For legagy rc.conf stuff
  install -m 0644 etc/runit/rc/rc.conf "$pkgdir/etc/runit/rc/rc.conf"
  install -m 0755 -d -D "$pkgdir/etc/rc.d"
  ln -s /etc/runit/rc/functions "$pkgdir/etc/rc.d"

  # The 3 init levels. Startup (1), runtime (2), and shutdown (2), plus
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
