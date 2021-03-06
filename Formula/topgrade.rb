class Topgrade < Formula
  desc "Upgrade all the things"
  homepage "https://github.com/r-darwish/topgrade"
  url "https://github.com/r-darwish/topgrade/archive/v5.7.0.tar.gz"
  sha256 "7d5e36b75e6eeaddb7e3d684a14fc8f52fe7d4aacdbffee132cae03e2dffa265"
  license "GPL-3.0-or-later"

  bottle do
    cellar :any_skip_relocation
    sha256 "6af26bfb1bf732aaa684325dbdb13dbfcfdc5d5222b11b1b11f2b6d06b2c61c8" => :catalina
    sha256 "e810023bb13faca384c26b684d34b7c6b174cc38282c98b2aed6e02ee0893026" => :mojave
    sha256 "926645050398ddab22605cdd5456d3928514f111283c0b55f6a4b48bef859ff5" => :high_sierra
    sha256 "82325e5f112f1a34316f5c58b7a727fca58bb8b44b4f497d2e21f4ee9d39e0dd" => :x86_64_linux
  end

  depends_on "rust" => :build
  depends_on xcode: :build if OS.mac? && MacOS::CLT.version >= "11.4" # libxml2 module bug

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Configuraton path details: https://github.com/r-darwish/topgrade/blob/HEAD/README.md#configuration-path
    # Sample config file: https://github.com/r-darwish/topgrade/blob/HEAD/config.example.toml
    (testpath/"Library/Preferences/topgrade.toml").write <<~EOS
      # Additional git repositories to pull
      #git_repos = [
      #    "~/src/*/",
      #    "~/.config/something"
      #]
    EOS

    assert_match version.to_s, shell_output("#{bin}/topgrade --version")

    output = shell_output("#{bin}/topgrade -n --only brew")
    assert_match "Dry running: #{HOMEBREW_PREFIX}/bin/brew upgrade", output
    assert_not_match /\sSelf update\s/, output
  end
end
