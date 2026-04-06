class Gtmship < Formula
  desc "GTMShip local CLI and dashboard runtime"
  homepage "https://github.com/BalaMZPersonal/gtmship"
  license "MIT"
  version "0.1.0"

  depends_on "node@20"
  depends_on "postgresql@16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.0/gtmship-darwin-arm64.tar.gz"
      sha256 "fe29e2429e9e7b512c2d5cc0879c1ab435508fe8d3b812f4179d76dc7c541cfa"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.0/gtmship-darwin-x64.tar.gz"
      sha256 "1206c3dd4b17a06f4a62e8b65b44038876b1cc4b0ee555b7230301913e4fa841"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.0/gtmship-linux-arm64.tar.gz"
      sha256 "f771fd78505a467429b478b0bb2ba85e3b156f35c8022c587878b76683712351"
    else
      url "https://github.com/BalaMZPersonal/gtmship/releases/download/v0.1.0/gtmship-linux-x64.tar.gz"
      sha256 "11dd51e7f22a0d93b7b57f5b318609d820b86a3a763ae2678ff5d10d54b64a27"
    end
  end

  def install
    libexec.install Dir["*"]

    (bin/"gtmship").write <<~EOS
      #!/bin/sh
      set -e
      ROOT_DIR="#{libexec}"
      export GTMSHIP_INSTALL_ROOT="${ROOT_DIR}"
      export GTMSHIP_POSTGRES_BIN="${HOMEBREW_PREFIX}/opt/postgresql@16/bin"

      if [ -x "${HOMEBREW_PREFIX}/opt/node@20/bin/node" ]; then
        exec "${HOMEBREW_PREFIX}/opt/node@20/bin/node" "${ROOT_DIR}/packages/cli/dist/index.js" "$@"
      fi

      exec node "${ROOT_DIR}/packages/cli/dist/index.js" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Start GTMShip with:
        gtmship open

      GTMShip runs the same localhost URLs on macOS and Linux:
        Dashboard: http://localhost:3000
        Auth:      http://localhost:4000
    EOS
  end
end
