class SqliteUtils < Formula
  include Language::Python::Virtualenv
  desc "CLI utility for manipulating SQLite databases"
  homepage "https://sqlite-utils.readthedocs.io/"
  url "https://files.pythonhosted.org/packages/93/9a/5a175c8987955760b115c5fa17de2ce45dd5533f9caabff237ed8ec534e9/sqlite-utils-2.16.1.tar.gz"
  sha256 "2c45175890d5f66ceaa1b37a56db7ef8d44f5d35bd2349814d2e46427e4519f7"
  license "Apache-2.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "e490a52af5f1d240e0fcc6aac9f9b47ba8b298c65064adc294d193f940f9fc6e" => :catalina
    sha256 "dc0c7f8e6aa845c348a170f803c2db4e1b6f9998e5af691cf22ce41359d3eae0" => :mojave
    sha256 "76bc8e334307ebd983fc032eaa53c7239bc904d83db83a825443ee2171f027d8" => :high_sierra
  end

  depends_on "python@3.8"

  resource "click" do
    url "https://files.pythonhosted.org/packages/27/6f/be940c8b1f1d69daceeb0032fee6c34d7bd70e3e649ccac0951500b4720e/click-7.1.2.tar.gz"
    sha256 "d2b5255c7c6349bc1bd1e59e08cd12acbbd63ce649f2588755783aa94dfb6b1a"
  end

  resource "click-default-group" do
    url "https://files.pythonhosted.org/packages/22/3a/e9feb3435bd4b002d183fcb9ee08fb369a7e570831ab1407bc73f079948f/click-default-group-1.2.2.tar.gz"
    sha256 "d9560e8e8dfa44b3562fbc9425042a0fd6d21956fcc2db0077f63f34253ab904"
  end

  resource "tabulate" do
    url "https://files.pythonhosted.org/packages/57/6f/213d075ad03c84991d44e63b6516dd7d185091df5e1d02a660874f8f7e1e/tabulate-0.8.7.tar.gz"
    sha256 "db2723a20d04bcda8522165c73eea7c300eda74e0ce852d9022e0159d7895007"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "15", shell_output("#{bin}/sqlite-utils :memory: 'select 3 * 5'")
  end
end
