class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.15"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.15/gtmship-darwin-arm64.tar.gz"
      sha256 "fdfd1bb090f525b1bed05a4cfce26c6731ae694d48ba9ec21518c9f5a6aace95"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.15/gtmship-darwin-x64.tar.gz"
      sha256 "b74e9ef15b7ac64442f5bc2081f1e35ac5f167a00d43a702f40933ca4c9bbc77"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.15/gtmship-linux-arm64.tar.gz"
      sha256 "2279040d10b437a7fbd4cc809c87e1ef83ec0244ac1067fc6025f040cc4e9c85"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.15/gtmship-linux-x64.tar.gz"
      sha256 "c5543e3e9271d53d9082dbb970c06f457ecb476534060558ea9d5d4ea0da4e02"
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
