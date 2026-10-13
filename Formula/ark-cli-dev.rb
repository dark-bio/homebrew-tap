# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.4.1-dev.56"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1-dev.56/ark-0.4.1-dev.56-macos-arm64", using: :nounzip
    sha256 "772e88d4063e0f7b68b764a9408ef5bb3e01b27c9d2be5d33427f524fdd4b316"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1-dev.56/ark-0.4.1-dev.56-macos-amd64", using: :nounzip
    sha256 "0efdab7e0d6fa0e2ae517eb64c7efc86c70cba5d6b38e2df18eb2c663aca84f7"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1-dev.56/LICENSES.txt", using: :nounzip
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
