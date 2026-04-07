class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.5"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.5/gtmship-darwin-arm64.tar.gz"
      sha256 "a35a9325339b52673720091f77478cfd02ff2504be374e1c7b66c4f4b19d171a"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.5/gtmship-darwin-x64.tar.gz"
      sha256 "8d783b8c3fb5e78dd5e340730859de4baeed5f8aba0fb463cfcc12c9f8870ab0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.5/gtmship-linux-arm64.tar.gz"
      sha256 "e246fa5541091db2012130d8108d78dfe6acfd2b13034938457a07c744b3058c"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.5/gtmship-linux-x64.tar.gz"
      sha256 "9082a2c7a94c5a4e0051786ed0f2b56ff2ae07d05392250514c07af5e5c00561"
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
