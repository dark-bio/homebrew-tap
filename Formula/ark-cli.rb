# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.3"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli-dev", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.3/ark-0.3.3-macos-arm64", using: :nounzip
    sha256 "5a21d20839080101f34e68960f892b97602165e37c198c46c5fdbb005356fb91"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.3/ark-0.3.3-macos-amd64", using: :nounzip
    sha256 "17269d68721d66c77eeb361b8ae86ffc34e635a0a9df7c160dbfcef8739eaf1c"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.3/LICENSES.txt", using: :nounzip
    sha256 "2b40e52148662c56b6f83c871936b1ef45fc70f96cf29381645a715e3dc996c9"
  end

  # Keep the command name stable and retain dependency notices beside the package.
  def install
    bin.install Dir["ark-#{version}-macos-*"].fetch(0) => "ark"
    chmod 0755, bin/"ark"
    generate_completions_from_executable(bin/"ark", "completions")
    resource("licenses").stage { pkgshare.install "LICENSES.txt" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ark --version")
  end
end
