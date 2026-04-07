class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.21"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.21/gtmship-darwin-arm64.tar.gz"
      sha256 "b72bd59f93973a4f44e22e33237412a10ad68345a69906741cdc9f08c3c0134b"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.21/gtmship-darwin-x64.tar.gz"
      sha256 "0782625cdea79c365d0a5c72d4fce5a641481bd2fc9d13dba8a6dbe63e51b8cf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.21/gtmship-linux-arm64.tar.gz"
      sha256 "bb2054eeedd2fda84a3f88fc8f0593d31e37489caf2bd94d4fab3da30c495429"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.21/gtmship-linux-x64.tar.gz"
      sha256 "4822808a0271e323a7c33492416a807b2a4748d3d75bfc2b6838f066ec42e172"
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
