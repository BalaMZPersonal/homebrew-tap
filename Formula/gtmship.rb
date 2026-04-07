class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.20"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.20/gtmship-darwin-arm64.tar.gz"
      sha256 "30779353ebba3f36e7ed18ada8700e2c9cc196d7a7141966c0b13360396be091"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.20/gtmship-darwin-x64.tar.gz"
      sha256 "f30bc9508bf79eab237200148bf846204f7f33a6af0e8470a082c8f3065b0488"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.20/gtmship-linux-arm64.tar.gz"
      sha256 "4b3921b34bcdbd6ad13dc5f17303a00acce97875626b3d6a762d0bf1842f6b6c"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.20/gtmship-linux-x64.tar.gz"
      sha256 "443e60f8e07628b7f4cc0d3a0eb67d6bd940d896165eab60fea3b7dc41084a47"
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
