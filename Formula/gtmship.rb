class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.3"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.3/gtmship-darwin-arm64.tar.gz"
      sha256 "8c7ecc980510499ae8a17d6e4be3275d629ffbf7688f53f215d0de62de341575"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.3/gtmship-darwin-x64.tar.gz"
      sha256 "1656ec88c3c759acca89c9a739174dda8879fe84330d494e13b3bffe7baedf22"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.3/gtmship-linux-arm64.tar.gz"
      sha256 "ca8a1856a9ee0f413fa237cfa9912199ba43ccf234a508ae7784eaa6cbd6a89c"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.3/gtmship-linux-x64.tar.gz"
      sha256 "aa599f373a2e2d17b4655ee31ac246a0410ba1c56c0c24e7d993f8ddef55a824"
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
