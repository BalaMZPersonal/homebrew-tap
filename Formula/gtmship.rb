class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.6"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.6/gtmship-darwin-arm64.tar.gz"
      sha256 "140d41d82c24872264bc17307587ba12dff29c3e91eec9bc36106fb18ce636bd"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.6/gtmship-darwin-x64.tar.gz"
      sha256 "2cda15f38eefefb5f91baa24e173410536ca9587c452cfa078aa1c62974734a6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.6/gtmship-linux-arm64.tar.gz"
      sha256 "12da3f4fc825f534e578dfcc66d37ab4edf2f612d40bcf154d87c57970971552"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.6/gtmship-linux-x64.tar.gz"
      sha256 "42f14635cd11403144c128e57d837dd77e17b5811e56980c8b9bfb3197ce48f2"
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
