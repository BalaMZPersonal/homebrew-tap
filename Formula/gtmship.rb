class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.26"

  depends_on "node@20"
  depends_on "postgresql@16"
  depends_on "pulumi"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.26/gtmship-darwin-arm64.tar.gz"
      sha256 "f251d5ba8fac9fa2e3bea04f283bf72abcdbff62539d887ee45fc1c51a7d2c5e"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.26/gtmship-darwin-x64.tar.gz"
      sha256 "d261312539385c7d86e072b8a39ca870bd0af506898d46e22240967c6eabfdf3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.26/gtmship-linux-arm64.tar.gz"
      sha256 "d5538c131accddeaa771df2e22c17181b45c46b22276a37f4ff63d216d01602d"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.26/gtmship-linux-x64.tar.gz"
      sha256 "9263e435b1496e41963b0d6300c14d89620fb79b3fc025b51d04d3b9fa127583"
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
