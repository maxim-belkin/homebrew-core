class Texi2html < Formula
  desc "Convert TeXinfo files to HTML"
  homepage "https://www.nongnu.org/texi2html/"
  url "https://download.savannah.gnu.org/releases/texi2html/texi2html-5.0.tar.gz"
  sha256 "e60edd2a9b8399ca615c6e81e06fa61946ba2f2406c76cd63eb829c91d3a3d7d"
  license "GPL-2.0"

  livecheck do
    skip "No longer developed or maintained"
  end

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "10f6d76de400799fb21dc900a2344ef444d43658dd502f0c040ad7c0a4bf0fbb" => :catalina
    sha256 "10f6d76de400799fb21dc900a2344ef444d43658dd502f0c040ad7c0a4bf0fbb" => :mojave
    sha256 "10f6d76de400799fb21dc900a2344ef444d43658dd502f0c040ad7c0a4bf0fbb" => :high_sierra
    sha256 "7f306764ce0a5c0d3db56c36806cf61b596bc762ba558108b568095329f0a1dd" => :x86_64_linux
  end

  depends_on "gettext"

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}",
                          "--mandir=#{man}", "--infodir=#{info}"
    chmod 0755, "./install-sh"
    system "make", "install"
  end

  test do
    (testpath/"test.texinfo").write <<~EOS
      @ifnottex
      @node Top
      @top Hello World!
      @end ifnottex
      @bye
    EOS
    system "#{bin}/texi2html", "test.texinfo"
    assert_match /Hello World!/, File.read("test.html")
  end
end
