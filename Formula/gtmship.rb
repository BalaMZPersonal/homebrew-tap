class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.12"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.12/gtmship-darwin-arm64.tar.gz"
      sha256 "c81b0c34f62ea4161aa2f40a8147392e73e0888a280d4315314d85ce9fb6e927"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.12/gtmship-darwin-x64.tar.gz"
      sha256 "6d2f9bc795b94e0472364ac688461d4cf88b4ea26021ae24a78b88bd04f9c839"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.12/gtmship-linux-arm64.tar.gz"
      sha256 "fdec8430ad7f1334ff5798a7531647d5f49bdcfba8fc1c8b961c3b556c8a965a"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.12/gtmship-linux-x64.tar.gz"
      sha256 "646ddb9fcb0877e9f1d2a1b466033127f3aa89ba217e0dd9ef805a2c1c08623b"
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
