# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.5.0-dev.61"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.0-dev.61/ark-0.5.0-dev.61-macos-arm64", using: :nounzip
    sha256 "01c7acf32877929c6f6b7a6c6c15da422ebd625ba81f43cbb1a2f5f14b0fd179"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.0-dev.61/ark-0.5.0-dev.61-macos-amd64", using: :nounzip
    sha256 "4fc837c42798fbb666bd38c6bbbd67a2cb117e6c6581d3d3ec5239d47a7786fc"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.0-dev.61/LICENSES.txt", using: :nounzip
    sha256 "f93b08e31b34c2aff9f654c0f98c43e877227e8e57365016d504b4fdfdcbbc92"
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
