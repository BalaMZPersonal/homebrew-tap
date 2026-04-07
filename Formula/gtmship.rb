class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.7"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.7/gtmship-darwin-arm64.tar.gz"
      sha256 "cbae8f50a742f23bd54b79a26fd890306eb60ab1b8c9f37ab9364e6eb3b01e56"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.7/gtmship-darwin-x64.tar.gz"
      sha256 "e7f0e8efadcf181dd2300cfa2b687b119bd9204aa88f2c6255f949fe836b4049"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.7/gtmship-linux-arm64.tar.gz"
      sha256 "539581bef807d18e3857ba66d0b0997073e1a8da1e76f113494e361bb21cfde6"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.7/gtmship-linux-x64.tar.gz"
      sha256 "838923e852408f61a08cb8f529db66a206197b72bd330c538333787f80df75d4"
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
