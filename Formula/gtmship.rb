class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.17"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.17/gtmship-darwin-arm64.tar.gz"
      sha256 "b780b4b0a30b9f215f8465a4ba91cf3c257eb15b01fbc028aa4d6a7df99a23c1"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.17/gtmship-darwin-x64.tar.gz"
      sha256 "dbd555b952178883c3bb0ed4c235a192750d01b3cda917936639f2578b3b24da"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.17/gtmship-linux-arm64.tar.gz"
      sha256 "5280985c878740c0bbb2e3ce08dcd93c5cf1bdd38aa934cf2ae046c8089e48b8"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.17/gtmship-linux-x64.tar.gz"
      sha256 "359140640c00d218cad953f0a51d71d5e56282fa57416f598e8d6742a8f1307a"
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
