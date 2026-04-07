class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.9"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.9/gtmship-darwin-arm64.tar.gz"
      sha256 "0af0bdb94e70581f499affe6c2399eafcc955441b9f2eb75f555f996e67068c3"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.9/gtmship-darwin-x64.tar.gz"
      sha256 "23cec404e66d4ee2ce4de0c52d470ada7af0d2f9ea8abafbc9a042c4377b4309"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.9/gtmship-linux-arm64.tar.gz"
      sha256 "3621caad17bd1a3ba11dcdf51ad2d98622e6972a0270271e897fb08c81c3549f"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.9/gtmship-linux-x64.tar.gz"
      sha256 "0abad21610ab3adecfc1f99b1a88fac6fe8a0addb278bc3907c65ee83eb46483"
    end
  end

  def install
    libexec.install Dir["*"]

    (bin/"gtmship").write <<~EOS
      #!/bin/sh
      set -e
      exec "#{libexec}/bin/gtmship" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Start GTMShip with:
        Desktop: gtmship open
        Headless Linux / VMs: gtmship start
        Check status: gtmship status

      GTMShip runs the same localhost URLs on macOS and Linux:
        Dashboard: http://localhost:3000
        Auth:      http://localhost:4000
    EOS
  end

  test do
    ENV.delete("HOMEBREW_PREFIX")
    output = shell_output("#{bin}/gtmship --help")
    assert_match "Usage: gtmship", output
  end
end
