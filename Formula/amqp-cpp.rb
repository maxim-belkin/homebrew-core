class AmqpCpp < Formula
  desc "C++ library for communicating with a RabbitMQ message broker"
  homepage "https://github.com/CopernicaMarketingSoftware/AMQP-CPP"
  url "https://github.com/CopernicaMarketingSoftware/AMQP-CPP/archive/v4.1.6.tar.gz"
  sha256 "48832068dc1e25a5313dd9e96fb33ba954c19f9dc04eeca8f7b2c6cecde3afc9"
  head "https://github.com/CopernicaMarketingSoftware/AMQP-CPP.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "14f369aa848a72960f6bc93f1617915584b519327f7e0af5c7105d6994386c90" => :catalina
    sha256 "4b6366bc8864159f9e9b5ca2ca69f98a3ad94880f15e8a6e7e14d25fae3f43a5" => :mojave
    sha256 "0a5ba77f7e077cc19dc5b87c5611fa8d2e16a4189774939c4aefc4317ec47aba" => :high_sierra
    sha256 "6fa50a29fce9b181732e12a552f4ebd31f4ca3738ec4a44d081e16ab861f675d" => :sierra
    sha256 "d98f164ee2138a83398c2d38210a7d38a4149e277c2b8bb526458fee0901a69f" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "openssl@1.1"

  def install
    ENV.cxx11

    system "cmake", "-DBUILD_SHARED=ON",
                    "-DCMAKE_MACOSX_RPATH=1",
                    "-DAMQP-CPP_LINUX_TCP=ON",
                    *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <amqpcpp.h>
      int main()
      {
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-L#{lib}", "-o",
                    "test", *("-lc++" if OS.mac?), "-lamqpcpp"
    system "./test"
  end
end
