class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.16"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.16/gtmship-darwin-arm64.tar.gz"
      sha256 "407a26ab9e4c31d5a6f84d7b9ce0fc669e461236159888107c0b96c1dcf80971"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.16/gtmship-darwin-x64.tar.gz"
      sha256 "468f51fbe228534a5a651e52ca3448cb9fa7b03eda3cd464f82c872e984ce552"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.16/gtmship-linux-arm64.tar.gz"
      sha256 "4270603396481db51d9d61ac019cae19bf2c9eeb6741260f39f941a2e5b96502"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.16/gtmship-linux-x64.tar.gz"
      sha256 "27d7e2856cfc25c587dbfa4e9f937954884ac3784a81789370e58882abb028cc"
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
