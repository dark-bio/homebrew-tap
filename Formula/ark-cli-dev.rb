# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.4.1-dev.55"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1-dev.55/ark-0.4.1-dev.55-macos-arm64", using: :nounzip
    sha256 "51c91f0121dcd0f9e9654bceffcd1c8bb212dfce0c20aa840eaf10e46308cdd8"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1-dev.55/ark-0.4.1-dev.55-macos-amd64", using: :nounzip
    sha256 "9eabb8f01e6ebe2e05dfd65fdc19afd6ff72ec43806aee2314f219a45a33f936"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1-dev.55/LICENSES.txt", using: :nounzip
    sha256 "d289ec21bec29de95e1c73ad6838db13e74af56e7917482c330dab9497fc4222"
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
