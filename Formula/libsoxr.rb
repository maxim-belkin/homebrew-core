class Libsoxr < Formula
  desc "High quality, one-dimensional sample-rate conversion library"
  homepage "https://sourceforge.net/projects/soxr/"
  url "https://downloads.sourceforge.net/project/soxr/soxr-0.1.3-Source.tar.xz"
  sha256 "b111c15fdc8c029989330ff559184198c161100a59312f5dc19ddeb9b5a15889"

  livecheck do
    url :stable
    regex(%r{url=.*?/soxr[._-]v?(\d+(?:\.\d+)+)(?:-Source)?\.t}i)
  end

  bottle do
    cellar :any
    sha256 "a6c8f1003e47e95e1653d617df2a228935fcea753bb578904687eb211d24d213" => :catalina
    sha256 "060d8d9eff5fc5152bdb8e1be67e2dbbdeebc6bfeb1deaf0561f96ba0a2de184" => :mojave
    sha256 "10b952f7e1ca5f9c839f87a2920e6739d4e3c262e88b05a3b8a62074de69e5ac" => :high_sierra
    sha256 "b469390e789389d10825c86d2ed825e1cb64efd14ecf98870043178846ed38ab" => :sierra
    sha256 "473b6f61851824ec47918a423295332f00d2ac802f2da4ef7058c621a4f365b0" => :el_capitan
    sha256 "af2772bb670a700e64e2f7c7afbe9067ee12925f716d625ad6e7ab9838c3a51a" => :x86_64_linux
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <soxr.h>

      int main()
      {
        char const *version = 0;
        version = soxr_version();
        if (version == 0)
        {
          return 1;
        }
        return 0;
      }
    EOS
    system ENV.cc, "-L#{lib}", "-lsoxr", "test.c", "-o", "test"
    system "./test"
  end
end
