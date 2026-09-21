# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.5-dev.31"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.5-dev.31/ark-0.3.5-dev.31-macos-arm64", using: :nounzip
    sha256 "f8425ff2da6626cc7dddec8c1b74450da35f09c7430395a22f7de5c3bb9d8bc9"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.5-dev.31/ark-0.3.5-dev.31-macos-amd64", using: :nounzip
    sha256 "7b873935661eb362077fe8c6d2fbcd9be9ff2d760b5e76c19884af24180873c9"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.5-dev.31/LICENSES.txt", using: :nounzip
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
