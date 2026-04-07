class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.2"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.2/gtmship-darwin-arm64.tar.gz"
      sha256 "1f2a7046b6a901f86e36c51deae50008779d8f96b4d544a3b67ab117decd2b7a"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.2/gtmship-darwin-x64.tar.gz"
      sha256 "5ddda5a12f5b567798b1bd1440facd227897dbf0dc96e9b5a62f34d027fa5e28"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.2/gtmship-linux-arm64.tar.gz"
      sha256 "b208dc6ee018a9da5b6813e50d7fc35f1bb4d7d13f796e270f20753ab4e7db1b"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.2/gtmship-linux-x64.tar.gz"
      sha256 "10c4acfe5650564460557ecf47e144436ca7a946f7469fdd714959bff2867698"
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
