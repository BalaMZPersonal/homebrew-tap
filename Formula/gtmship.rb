class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.24"

  depends_on "node@20"
  depends_on "postgresql@16"
  depends_on "pulumi"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.24/gtmship-darwin-arm64.tar.gz"
      sha256 "f9ae377e2987971f721414b5d3bce874bdd57d8d456154a57d206ede77d8a6b0"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.24/gtmship-darwin-x64.tar.gz"
      sha256 "09dcae33d4b887364090f33f31bb18fb3228f0678cafb921471061d03e3ed26c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.24/gtmship-linux-arm64.tar.gz"
      sha256 "99c3cd120da5bf5add50106f9df5e82f80d937cd8cc485b9ce7a931b7bc051c4"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.24/gtmship-linux-x64.tar.gz"
      sha256 "655dd47f6e2212a5bcdf31bccb39f4df1b2f68f0c3072725421b4c94fd3701b2"
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
