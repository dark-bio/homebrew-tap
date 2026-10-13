# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.4.1"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli-dev", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1/ark-0.4.1-macos-arm64", using: :nounzip
    sha256 "914284a58fcd428815e388fe92a03f53df40b40c537ede4a9d4b87c58e9e6bf8"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1/ark-0.4.1-macos-amd64", using: :nounzip
    sha256 "81d5ab2ac3f40e7dae730ade94dbe919326e7cf8243eb71abbe0ccb851341666"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1/LICENSES.txt", using: :nounzip
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
