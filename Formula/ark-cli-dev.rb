# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.6-dev.41"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.41/ark-0.3.6-dev.41-macos-arm64", using: :nounzip
    sha256 "40206468a47b86915bb62cf7280e8d3dca51704d2320753b0e3ad3066c879e8f"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.41/ark-0.3.6-dev.41-macos-amd64", using: :nounzip
    sha256 "eb087038c25c24f607d7a9fa23fd23e150ccc051541a97931977629ae4118528"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.41/LICENSES.txt", using: :nounzip
    sha256 "c9946e83587048cac7f260952f6f7ca51c50a75219721e20fda8ba798ce2cf35"
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
