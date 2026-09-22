# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.5"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli-dev", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.5/ark-0.3.5-macos-arm64", using: :nounzip
    sha256 "7eaf7aff6a83bed6ae8d655a8fc141020c3dcf5cebefb6006522f9c3986df616"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.5/ark-0.3.5-macos-amd64", using: :nounzip
    sha256 "fc56d7143c4c04c142808648a2e0218d7f021449d83386c6c95e8b11729ecf46"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.5/LICENSES.txt", using: :nounzip
    sha256 "b1d2683530d4073509837524302cd158641ba725a1941165a259b970d0f6e227"
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
