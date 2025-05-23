# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python interface to sendmail milter API"
HOMEPAGE="https://github.com/sdgathman/pymilter"
SRC_URI="https://github.com/sdgathman/${PN}/archive/${P}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	mail-filter/libmilter:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		$(python_gen_impl_dep sqlite)
		|| (
			mail-mta/opensmtpd
			mail-mta/sendmail
		)
	)
"

distutils_enable_tests unittest
