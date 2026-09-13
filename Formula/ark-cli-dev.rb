# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.2.2-dev.7"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.2-dev.7/ark-0.2.2-dev.7-macos-arm64", using: :nounzip
    sha256 "f0042f6deab8ddac327b2cd1d87843dffc36116b5501df3443aad452a72fd074"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.2-dev.7/ark-0.2.2-dev.7-macos-amd64", using: :nounzip
    sha256 "e99c88b8f63e37bb15fa4d464382e1b6b66fb3398430bfa1b7d4b4c6528a07c2"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.2-dev.7/LICENSES.txt", using: :nounzip
    sha256 "4c2b275b103e247f098f97241de720aea2a937f5f6e6637287d80a8b36b31c9f"
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
