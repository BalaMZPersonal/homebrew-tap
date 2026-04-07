class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.14"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.14/gtmship-darwin-arm64.tar.gz"
      sha256 "b4c490d0cfad4c462b07e74fd50e1a2e6f2bb8a6471e53dbd3f52f6d8f14e800"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.14/gtmship-darwin-x64.tar.gz"
      sha256 "e2e993b5a7ebd3f7f5350dbca98ec927ef4cb8a692b3b5d5e268284f404a949b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.14/gtmship-linux-arm64.tar.gz"
      sha256 "47e276d0824e36025e20c9be424531613e8e3bd5e776dc05f067488dc25ed866"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.14/gtmship-linux-x64.tar.gz"
      sha256 "af98493bfed5cd63b4874c0847746f35cf79ed150e5d9898efb8ed5cff56fb3b"
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
