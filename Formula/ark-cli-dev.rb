# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.4.1-dev.54"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1-dev.54/ark-0.4.1-dev.54-macos-arm64", using: :nounzip
    sha256 "42d2f283e283e0e156f7acfb004c4c9eed67d5de3c264422c15423f00e3d8082"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1-dev.54/ark-0.4.1-dev.54-macos-amd64", using: :nounzip
    sha256 "5f99e6e91b8124239f5b6347c85ad6a7dfd9f68dfc064c96444ef601cbc6926f"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.1-dev.54/LICENSES.txt", using: :nounzip
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
