class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.22"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.22/gtmship-darwin-arm64.tar.gz"
      sha256 "3a23f12d50dd3f75866b06c97c113b22771432b20ac4bd22f414f2acc8be3e5c"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.22/gtmship-darwin-x64.tar.gz"
      sha256 "314784b66fec4cef3918a1ab8f05f6d56c84302487dda1ddffa72bcac975f698"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.22/gtmship-linux-arm64.tar.gz"
      sha256 "fd33c39f23291616b5ee143ecd33bb8564d7b3451ca80b81a0ef2f09d97dff6a"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.22/gtmship-linux-x64.tar.gz"
      sha256 "63f6149b406cfe6ca82fa81cf51bcbc5725e29443df9ceeb58a8a1809117185d"
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
