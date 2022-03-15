# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit bash-completion-r1 go-module
MY_PV=${PV/_/-}

DESCRIPTION="Multi-container orchestration for Docker"
HOMEPAGE="https://github.com/docker/compose"
SRC_URI="https://github.com/docker/compose/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://dev.gentoo.org/~williamh/dist/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"

RDEPEND=">=app-containers/docker-20.10.3"

S="${WORKDIR}/compose-${MY_PV}"

src_prepare() {
	default
	# do not strip
	sed -i -e 's/-s -w//' builder.Makefile || die
}

src_compile() {
	emake -f builder.Makefile GIT_TAG=v${PV}
}

src_install() {
	dodir /usr/libexec/docker/cli-plugins
	exeinto /usr/libexec/docker/cli-plugins
	doexe bin/docker-compose
dodoc README.md
}

src_test() {
	emake -f builder.Makefile test
}

pkg_postinst() {
	has_version =docker-compose-1.* || return
	elog
	elog "docker-compose 2.x is a sub command of docker"
	elog "Use 'docker compose' from the command line instead of"
	elog "'docker-compose'"
}
