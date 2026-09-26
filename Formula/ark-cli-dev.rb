# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.6-dev.38"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.38/ark-0.3.6-dev.38-macos-arm64", using: :nounzip
    sha256 "3481826d6d6c4f787b52cabfdb5ba48913b3914e1f21f2efe2c07c5d30523994"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.38/ark-0.3.6-dev.38-macos-amd64", using: :nounzip
    sha256 "283d2ea14e6c79ccd759deffbde613abac84e51d3b170c80d109d248303a97a9"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.38/LICENSES.txt", using: :nounzip
    sha256 "f52ce81873c0f21551ebda77d267de56ddee658b65468f98d029546bafc091d9"
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
