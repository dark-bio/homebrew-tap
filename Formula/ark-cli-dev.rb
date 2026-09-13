# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.2.2-dev.6"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.2-dev.6/ark-0.2.2-dev.6-macos-arm64", using: :nounzip
    sha256 "d0349e7adfb26cc0c3dc43737560241a7459f2cfc0f42bd55f7f4a9b4e3915bb"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.2-dev.6/ark-0.2.2-dev.6-macos-amd64", using: :nounzip
    sha256 "8520791b567219e8d7c94866111d9a05de31d9eb70cd245a45bccf84c0e7dafb"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.2-dev.6/LICENSES.txt", using: :nounzip
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
