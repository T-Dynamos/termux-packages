TERMUX_PKG_HOMEPAGE=https://www.blender.org
TERMUX_PKG_DESCRIPTION="A fully integrated 3D graphics creation suite"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@T-Dynamos"
TERMUX_PKG_VERSION=3.3.0
TERMUX_PKG_SRCURL=https://git.blender.org/blender.git

# FIXME : add opencollada, openxr, openimageio, 
# openshadinglanguage, openimagedenoise, jemalloc,  log4cplus, embree
# libharu, draco , openvdb

TERMUX_PKG_DEPENDS="libpng, libtiff, python, openexr2, desktop-file-utils, potrace, shared-mime-info, hicolor-icon-theme, glew, openjpeg, python-numpy, freetype, ffmpeg, fftw, alembic, libsndfile, ptex, sdl2, libspnav, openal-soft, libspnav, opencolorio"

termux_step_pre_configure() {
	_PYTHON_VERSION=$(. $TERMUX_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)
	termux_setup_python_crossenv
	pushd $TERMUX_PYTHON_CROSSENV_SRCDIR
	_CROSSENV_PREFIX=$TERMUX_PKG_BUILDDIR/python-crossenv-prefix
	python${_PYTHON_VERSION} -m crossenv \
		$TERMUX_PREFIX/bin/python${_PYTHON_VERSION} \
		${_CROSSENV_PREFIX}
	popd
	. ${_CROSSENV_PREFIX}/bin/activate

	build-pip install requests
	export WITH_IN_SOURCE_BUILD
}
