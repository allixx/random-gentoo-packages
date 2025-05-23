# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Domain Keys Identified Mail (DKIM) signing/verifying milter for Postfix/Sendmail"
HOMEPAGE="
	https://launchpad.net/dkimpy-milter/
	https://pypi.org/project/dkimpy-milter/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	acct-user/dkimpy-milter
	acct-group/dkimpy-milter
	>=dev-python/dnspython-2.0.0[${PYTHON_USEDEP}]
	dev-python/dkimpy
	dev-python/pycparser
	dev-python/pymilter
	dev-python/authres
"
BDEPEND="
	test? (
		dev-python/pynacl[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

src_install() {
	distutils-r1_src_install
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
}

pkg_postinst() {
	optfeature "ed25519 capability" dev-python/pynacl
}
