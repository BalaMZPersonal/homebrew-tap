class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.19"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.19/gtmship-darwin-arm64.tar.gz"
      sha256 "b535c07c6b804e9df282d108683d2ed8eb1ae37b920cb9988ce58c14f88de2cb"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.19/gtmship-darwin-x64.tar.gz"
      sha256 "b7b80b9bc177633b0ed78bd922d56820d52dc8f5956be77873a57614724e9237"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.19/gtmship-linux-arm64.tar.gz"
      sha256 "a569aeb20c1481fd79942a7637a8c56b47770923241ec7755317070910fb7efa"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.19/gtmship-linux-x64.tar.gz"
      sha256 "8c34904ae8615ee3ed8e4c8176ff822d76c1e581b4dedc1b00b834d6404c0fac"
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
