# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="IP address calculator"
HOMEPAGE="https://github.com/dreibh/subnetcalc"
SRC_URI="https://github.com/dreibh/${PN}/archive/${P}.tar.gz -> {$PN}-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${P}"
