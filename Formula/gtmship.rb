class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.23"

  depends_on "node@20"
  depends_on "postgresql@16"
  depends_on "pulumi"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.23/gtmship-darwin-arm64.tar.gz"
      sha256 "15451e8e58affad3ce1c47f7ab4e864595880fc11bc8b729a88cf0c948d21e55"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.23/gtmship-darwin-x64.tar.gz"
      sha256 "d4ecf8e05df879c3a1840e35c610f4f16a40506244ab9bb2cbed3fdb6cd62569"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.23/gtmship-linux-arm64.tar.gz"
      sha256 "4d302d4c9a116f2d1d2bf76f47962f592b42fcd2a93f3d11e82b6c46e5e91344"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.23/gtmship-linux-x64.tar.gz"
      sha256 "3f31f6ccc99caad92130107e19a699171d91ce2424e74f3f904e56f252f41d2b"
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
