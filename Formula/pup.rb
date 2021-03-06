class Pup < Formula
  desc "Parse HTML at the command-line"
  homepage "https://github.com/EricChiang/pup"
  url "https://github.com/ericchiang/pup/archive/v0.4.0.tar.gz"
  sha256 "0d546ab78588e07e1601007772d83795495aa329b19bd1c3cde589ddb1c538b0"
  license "MIT"
  revision 1 unless OS.mac?
  head "https://github.com/EricChiang/pup.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "b543d371442c8a14f8113396523d65f1775f4b61ca55d4b61b859c180eb20777" => :catalina
    sha256 "baeef002d46ed4c9872242419ed991b9d9f26d8e5b296f54b2ffb9e1e6bcfc84" => :mojave
    sha256 "f470de75187b994ef9612c5404dc7622a356c8ee6af21f6b2549b5d7c5d88d32" => :high_sierra
    sha256 "4ba84cffa7cfd01bd252223055abdf5fd8b6cfc27474131cf313e688ea8eeecf" => :sierra
    sha256 "a1aa49640871c127c76f4aea6db65487db964a055e2aa4d86ee2d8b7f5dcb561" => :el_capitan
    sha256 "248c3290273660e3b2b43c62909d1674784a7dab7f538b8fc228ec17981b6bf3" => :x86_64_linux
  end

  depends_on "go" => :build
  depends_on "gox" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/ericchiang/pup"
    dir.install buildpath.children
    os = OS.mac? ? "darwin" : "linux"

    cd dir do
      system "gox", "-arch", "amd64", "-os", os, "./..."
      bin.install "pup_#{os}_amd64" => "pup"
    end

    prefix.install_metafiles dir
  end

  test do
    output = pipe_output("#{bin}/pup p text{}", "<body><p>Hello</p></body>", 0)
    assert_equal "Hello", output.chomp
  end
end
