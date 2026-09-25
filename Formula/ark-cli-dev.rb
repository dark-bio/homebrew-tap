# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.6-dev.35"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.35/ark-0.3.6-dev.35-macos-arm64", using: :nounzip
    sha256 "0d3295e748d5753edba985f36b3ed31dddc6d9058a518bde82bd37e3c4342a11"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.35/ark-0.3.6-dev.35-macos-amd64", using: :nounzip
    sha256 "259207bc52d9b64723019b3b29175b9ef5e40e4f7b33d38a6ca3b48966af0878"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.35/LICENSES.txt", using: :nounzip
    sha256 "969629d25d01e53cd96fa3759eebed1f38349b0174c3e148f2d1911cb188a19c"
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
