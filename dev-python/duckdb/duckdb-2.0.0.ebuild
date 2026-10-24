# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=standalone
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="DuckDB embedded database"
HOMEPAGE="https://www.duckdb.org"
SRC_URI="https://files.pythonhosted.org/packages/source/d/duckdb/duckdb-${PV}.tar.gz -> duckdb-python-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pybind11[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pyarrow[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_test() {
	einfo $(pwd)
	rm -rf duckdb || die
	epytest
}
