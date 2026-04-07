class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.4"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.4/gtmship-darwin-arm64.tar.gz"
      sha256 "e6d5a2ee3d2860004f99501983bafa001c3373a776256af4003faf59fa28940e"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.4/gtmship-darwin-x64.tar.gz"
      sha256 "5157d99c51ac62136493dbf0c60d59cc4506f332c089b31aebf95d0cc9a7df23"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.4/gtmship-linux-arm64.tar.gz"
      sha256 "65afdf32f704488ba273661db970f4795434aba1702911df7a22d783aa8bac5c"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.4/gtmship-linux-x64.tar.gz"
      sha256 "4466637875c3abd70f329276d8db421bc9b1c1dd2585b78b89a69e9e96403e24"
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
