# Patches for Qt must be at the very least submitted to Qt's Gerrit codereview
# rather than their bug-report Jira. The latter is rarely reviewed by Qt.
class QtAT5 < Formula
  desc "Cross-platform application and UI framework"
  homepage "https://www.qt.io/"
  # NOTE: Use *.diff for GitLab/KDE patches to avoid their checksums changing.
  url "https://download.qt.io/official_releases/qt/5.15/5.15.8/single/qt-everywhere-opensource-src-5.15.8.tar.xz"
  mirror "https://mirrors.dotsrc.org/qtproject/archive/qt/5.15/5.15.8/single/qt-everywhere-opensource-src-5.15.8.tar.xz"
  mirror "https://mirrors.ocf.berkeley.edu/qt/archive/qt/5.15/5.15.8/single/qt-everywhere-opensource-src-5.15.8.tar.xz"
  sha256 "776a9302c336671f9406a53bd30b8e36f825742b2ec44a57c08217bff0fa86b9"
  license all_of: ["GFDL-1.3-only", "GPL-2.0-only", "GPL-3.0-only", "LGPL-2.1-only", "LGPL-3.0-only"]
  revision 3

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "51c1a85183da0a893df5be45cc36e9c13822c6f0f0135ff9f84d7649356a8e4d"
    sha256 cellar: :any,                 arm64_monterey: "99e62401706b90148209fd0c7284b5d638310e8734f36506c0ac3f0ea43c7580"
    sha256 cellar: :any,                 arm64_big_sur:  "b9f989aa0599f3e7c6636f5315ee0dd719ad819fa20c0825f441ff6fe8d5278f"
    sha256 cellar: :any,                 ventura:        "ccf3df1316af6067293a15dacfb1ee4626fabb8895073187c5bdbb56f0212815"
    sha256 cellar: :any,                 monterey:       "a68fcdf5cf44aec33b43fd27598a9087ed79ba6e6994687e5332b93fa7b7c702"
    sha256 cellar: :any,                 big_sur:        "cf7596ecc8a7284e06d335df6656161c70c083f74fc9a31606b7752a9950d027"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3390ad5f10b5cd0ae988fa2fb693e5a59d0324ca36488b0358fccf18c727c698"
  end

  keg_only :versioned_formula

  depends_on "node"       => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.10" => :build
  depends_on xcode: :build
  depends_on "freetype"
  depends_on "glib"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on macos: :sierra
  depends_on "pcre2"
  depends_on "webp"

  uses_from_macos "gperf" => :build
  uses_from_macos "bison"
  uses_from_macos "flex"
  uses_from_macos "krb5"
  uses_from_macos "libxslt"
  uses_from_macos "sqlite"

  on_linux do
    depends_on "alsa-lib"
    depends_on "at-spi2-core"
    depends_on "fontconfig"
    depends_on "harfbuzz"
    depends_on "icu4c"
    depends_on "libdrm"
    depends_on "libevent"
    depends_on "libice"
    depends_on "libproxy"
    depends_on "libsm"
    depends_on "libvpx"
    depends_on "libxcomposite"
    depends_on "libxkbcommon"
    depends_on "libxkbfile"
    depends_on "libxrandr"
    depends_on "libxtst"
    depends_on "mesa"
    depends_on "minizip"
    depends_on "nss"
    depends_on "opus"
    depends_on "pulseaudio"
    depends_on "re2"
    depends_on "sdl2"
    depends_on "snappy"
    depends_on "systemd"
    depends_on "wayland"
    depends_on "xcb-util"
    depends_on "xcb-util-image"
    depends_on "xcb-util-keysyms"
    depends_on "xcb-util-renderutil"
    depends_on "xcb-util-wm"
    depends_on "zstd"
  end

  fails_with gcc: "5"

  resource "qtwebengine" do
    url "https://code.qt.io/qt/qtwebengine.git",
        tag:      "v5.15.11-lts",
        revision: "3d23b379a7c0a87922f9f5d9600fde8c4e58f1fd"

    # Add Python 3 support to qt-webengine-chromium.
    # Submitted upstream here: https://codereview.qt-project.org/c/qt/qtwebengine-chromium/+/416534
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/7ae178a617d1e0eceb742557e63721af949bd28a/qt5/qt5-webengine-chromium-python3.patch?full_index=1"
      sha256 "a93aa8ef83f0cf54f820daf5668574cc24cf818fb9589af2100b363356eb6b49"
      directory "src/3rdparty"
    end

    # Add Python 3 support to qt-webengine.
    # Submitted upstream here: https://codereview.qt-project.org/c/qt/qtwebengine/+/416535
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/a6f16c6daea3b5a1f7bc9f175d1645922c131563/qt5/qt5-webengine-python3.patch?full_index=1"
      sha256 "398c996cb5b606695ac93645143df39e23fa67e768b09e0da6dbd37342a43f32"
    end

    # Fix build of qt-webengine-chromium with newer GCC.
    # Submitted upstream here: https://codereview.qt-project.org/c/qt/qtwebengine-chromium/+/416598
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/a6f16c6daea3b5a1f7bc9f175d1645922c131563/qt5/qt5-webengine-gcc12.patch?full_index=1"
      sha256 "cf9be3ffcc3b3cd9450b1ff13535ff7d76284f73173412d097a6ab487463a379"
      directory "src/3rdparty"
    end

    # Fix build for Xcode 14
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/405b6b7ca7b95860ee70368076382b171a1c66f4/qt5/qt5-webengine-xcode14.diff"
      sha256 "142c4fb11dca6c0bbc86ca8f74410447c23be1b1d314758515bfda20afa6f612"
      directory "src/3rdparty"
    end
  end

  # Update catapult to a revision that supports Python 3.
  resource "catapult" do
    url "https://chromium.googlesource.com/catapult.git",
    revision: "5eedfe23148a234211ba477f76fc2ea2e8529189"
  end

  # Fix build for GCC 11
  patch do
    url "https://invent.kde.org/qt/qt/qtbase/commit/ee7aed5e1020fa88f86777701948c8a236db4fc5.diff"
    sha256 "41df4232666363f63d87a0165ec05e835f4c730c270a52137fbc53bdaf4e5f20"
    directory "qtbase"
  end

  # https://download.qt.io/official_releases/qt/5.15/CVE-2022-25255-qprocess5-15.diff
  patch do
    url "https://invent.kde.org/qt/qt/qtbase/commit/12df089a0095645daae4f932c495258751d881fc.patch"
    sha256 "325178702d0cf30c96ab83f279c3f4db666d8fdc2be193ef944311e144caba0d"
    directory "qtbase"
  end

  # Fix build with Xcode 14.3.
  patch do
    url "https://invent.kde.org/qt/qt/qtlocation-mapboxgl/-/commit/5a07e1967dcc925d9def47accadae991436b9686.diff"
    sha256 "4f433bb009087d3fe51e3eec3eee6e33a51fde5c37712935b9ab96a7d7571e7d"
    directory "qtlocation/src/3rdparty/mapbox-gl-native"
  end

  def install
    rm_r "qtwebengine"

    resource("qtwebengine").stage(buildpath/"qtwebengine")

    rm_r "qtwebengine/src/3rdparty/chromium/third_party/catapult"

    resource("catapult").stage(buildpath/"qtwebengine/src/3rdparty/chromium/third_party/catapult")

    # FIXME: GN requires clang in clangBasePath/bin
    inreplace "qtwebengine/src/3rdparty/chromium/build/toolchain/mac/BUILD.gn",
       'rebase_path("$clang_base_path/bin/", root_build_dir)', '""'

    args = %W[
      -verbose
      -prefix #{prefix}
      -release
      -opensource -confirm-license
      -nomake examples
      -nomake tests
      -pkg-config
      -dbus-runtime
      -proprietary-codecs
      -system-freetype
      -system-libjpeg
      -system-libpng
      -system-pcre
      -system-zlib
    ]

    if OS.mac?
      args << "-no-rpath"
      args << "-no-assimp" if Hardware::CPU.arm?
    else
      args << "-R#{lib}"
      # https://bugreports.qt.io/browse/QTBUG-71564
      args << "-no-avx2"
      args << "-no-avx512"
      args << "-no-sql-mysql"

      # Use additional system libraries on Linux.
      # Currently we have to use vendored ffmpeg because the chromium copy adds a symbol not
      # provided by the brewed version.
      # See here for an explanation of why upstream ffmpeg does not want to add this:
      # https://www.mail-archive.com/ffmpeg-devel@ffmpeg.org/msg124998.html
      # On macOS chromium will always use bundled copies and the webengine_*
      # arguments are ignored.
      args += %w[
        -system-harfbuzz
        -webengine-alsa
        -webengine-icu
        -webengine-kerberos
        -webengine-opus
        -webengine-pulseaudio
        -webengine-webp
      ]

      # Homebrew-specific workaround to ignore spurious linker warnings on Linux.
      inreplace "qtwebengine/src/3rdparty/chromium/build/config/compiler/BUILD.gn",
               "fatal_linker_warnings = true",
               "fatal_linker_warnings = false"
    end

    ENV.prepend_path "PATH", Formula["python@3.10"].libexec/"bin"
    system "./configure", *args

    # Remove reference to shims directory
    inreplace "qtbase/mkspecs/qmodule.pri",
              /^PKG_CONFIG_EXECUTABLE = .*$/,
              "PKG_CONFIG_EXECUTABLE = #{Formula["pkg-config"].opt_bin/"pkg-config"}"
    system "make"
    ENV.deparallelize
    system "make", "install"

    # Some config scripts will only find Qt in a "Frameworks" folder
    frameworks.install_symlink Dir["#{lib}/*.framework"]

    # The pkg-config files installed suggest that headers can be found in the
    # `include` directory. Make this so by creating symlinks from `include` to
    # the Frameworks' Headers folders.
    Pathname.glob("#{lib}/*.framework/Headers") do |path|
      include.install_symlink path => path.parent.basename(".framework")
    end

    # Move `*.app` bundles into `libexec` to expose them to `brew linkapps` and
    # because we don't like having them in `bin`.
    # (Note: This move breaks invocation of Assistant via the Help menu
    # of both Designer and Linguist as that relies on Assistant being in `bin`.)
    libexec.mkpath
    Pathname.glob("#{bin}/*.app") { |app| mv app, libexec }

    # Fix find_package call using QtWebEngine version to find other Qt5 modules.
    inreplace Dir[lib/"cmake/Qt5WebEngine*/*Config.cmake"],
              " #{resource("qtwebengine").version} ", " #{version} "
  end

  def caveats
    <<~EOS
      We agreed to the Qt open source license for you.
      If this is unacceptable you should uninstall.
    EOS
  end

  test do
    (testpath/"hello.pro").write <<~EOS
      QT       += core
      QT       -= gui
      TARGET = hello
      CONFIG   += console
      CONFIG   -= app_bundle
      TEMPLATE = app
      SOURCES += main.cpp
    EOS

    (testpath/"main.cpp").write <<~EOS
      #include <QCoreApplication>
      #include <QDebug>

      int main(int argc, char *argv[])
      {
        QCoreApplication a(argc, argv);
        qDebug() << "Hello World!";
        return 0;
      }
    EOS

    # Work around "error: no member named 'signbit' in the global namespace"
    ENV.delete "CPATH"

    system bin/"qmake", testpath/"hello.pro"
    system "make"
    assert_predicate testpath/"hello", :exist?
    assert_predicate testpath/"main.o", :exist?
    system "./hello"
  end
end
