# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.6-dev.34"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.34/ark-0.3.6-dev.34-macos-arm64", using: :nounzip
    sha256 "973873574e834f1a9b9caefd9ec2c808f66b1b1ad7494c02c79c706c32a8b605"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.34/ark-0.3.6-dev.34-macos-amd64", using: :nounzip
    sha256 "711e12062ab3922e683930723d90caf74b6247808b891030dcd84f6eddeb9fb2"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.34/LICENSES.txt", using: :nounzip
    sha256 "c116df85099070cd63a7f7386e7d0b2d9bd95a12f44f8b12e8580156ad0098cc"
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
