class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.11"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.11/gtmship-darwin-arm64.tar.gz"
      sha256 "6825c795f1be8432d912aeea15a5518fce1a770b92c627d167e26ad08b06c47b"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.11/gtmship-darwin-x64.tar.gz"
      sha256 "7bd15a92f538f06d20bb90b51683d172f38360c018b0a69c13e9fcd263b53cec"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.11/gtmship-linux-arm64.tar.gz"
      sha256 "63c60dfda9d90f3cc37341aedde40cfa491e3e7493cb020cc7c2b998edaa18ee"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.11/gtmship-linux-x64.tar.gz"
      sha256 "c6d397672dbdc38b122542392439ce019d35f22ae848090e9aee3792cacb1c2b"
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
