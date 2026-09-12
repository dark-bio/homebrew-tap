# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.1.1"
  license "BSD-3-Clause"

  depends_on :macos

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.1.1/ark-0.1.1-macos-arm64", using: :nounzip
    sha256 "f6c305638a527d0c4a3bffe00ce034e6e91a5e64ed361281391bc1251bf5ffcb"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.1.1/ark-0.1.1-macos-amd64", using: :nounzip
    sha256 "6de55c6abbfb801cf38ca0a4c57358fcf5741658824df8e59610041ba6111fd6"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.1.1/LICENSES.txt", using: :nounzip
    sha256 "129c2633b72b4ff48ddf8d0ab572bbaa3c1ece4bdf8f5418b17f810579927a21"
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
