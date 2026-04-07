class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.1"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.1/gtmship-darwin-arm64.tar.gz"
      sha256 "2ca71767992869136284d0aac7dcbd7e97914d2e01adf4ac91ce089834a69122"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.1/gtmship-darwin-x64.tar.gz"
      sha256 "799ae3a322a9eb9fac204a766a0cb1311af246a37af4f9c9434923ac4d802535"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.1/gtmship-linux-arm64.tar.gz"
      sha256 "1bcbdc6566301c40c04279374d441d0d216ac6280840587e3a66b8c8d1ae7b6f"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.1/gtmship-linux-x64.tar.gz"
      sha256 "527701404747e135a9098b2544cddc92737e6866eee53741dec4871c03b1e26e"
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
