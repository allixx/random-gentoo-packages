# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs systemd

DESCRIPTION="A Tunnel which Improves your Network Quality with Forward Error Correction"
HOMEPAGE="https://github.com/wangyu-/UDPspeeder"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/wangyu-/UDPspeeder.git"
else
	KEYWORDS="amd64 x86"
	SRC_URI="https://github.com/wangyu-/UDPspeeder/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/UDPspeeder-${PV}
fi

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# Disable optimisation flags and remove prefixes of exec files
	sed -e 's/ -O[0-3a-z]*//' \
		-e 's/\${NAME}_[a-zA-Z0-9\$@]*/\${NAME}/' \
		-e 's/ -static//' \
		-e "s/\${cc_[a-zA-Z0-9_]*}/$(tc-getCXX)/" \
		-i makefile || die 'sed failed!'

	default
}

src_compile() {
	append-cxxflags -Wa,--noexecstack
	emake OPT="${CXXFLAGS}"
}

src_install() {
	local exec_name=speederv2

	newinitd "${FILESDIR}/${PN}".initd "${PN}"
	newconfd "${FILESDIR}/${PN}".confd "${PN}"

	systemd_dounit "${FILESDIR}/${PN}.service"

	dobin $exec_name
}

pkg_postinst() {
	elog "\nhttps://github.com/wangyu-/UDPspeeder/wiki\n"
}
