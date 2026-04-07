class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.8"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.8/gtmship-darwin-arm64.tar.gz"
      sha256 "b74b9dbd1c35ac808da46cfbfc70ecddc4f5422bf04ce2cb895c7e50e88ba446"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.8/gtmship-darwin-x64.tar.gz"
      sha256 "de9df5d074d274c046bbfcb32b5cc9722cf8dfe8fb762f06e900e2d0ef5b62d8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.8/gtmship-linux-arm64.tar.gz"
      sha256 "51f629fa3cddfa63ff8eb32a121f0aad9ec9f34019fa7d92ccc25f105e05ef85"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.8/gtmship-linux-x64.tar.gz"
      sha256 "f7c16ed14b78e2945da44dfb69ee7a077888be1a992bcf6d523d7d3abba6e338"
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
