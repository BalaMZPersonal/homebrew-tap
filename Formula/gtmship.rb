class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.13"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.13/gtmship-darwin-arm64.tar.gz"
      sha256 "298a1b1292a393fd136bea68192f47b6778191b3234ecaa27f7a887f47bbd3f3"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.13/gtmship-darwin-x64.tar.gz"
      sha256 "7ecc337f29b9f55890610f9ff03c6cf00671a788adeb4dc21533221913638b12"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.13/gtmship-linux-arm64.tar.gz"
      sha256 "74f1857ac73cd18935903acbef73410df79b7d4fffae74870d233d21a065c462"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.13/gtmship-linux-x64.tar.gz"
      sha256 "8ad652316fd9895b8fd5e6e1110a7286ee361a01334afc98644d0fb74c558636"
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
