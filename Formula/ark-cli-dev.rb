# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.2-dev.19"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2-dev.19/ark-0.3.2-dev.19-macos-arm64", using: :nounzip
    sha256 "f521b5fd26728538a424ec65aee82929708df71f69da72474440b088bd3bc640"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2-dev.19/ark-0.3.2-dev.19-macos-amd64", using: :nounzip
    sha256 "07945ee5068777f24a55386e2faa66f0e4e36d59c9d31125c9c66e6a40307f0b"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2-dev.19/LICENSES.txt", using: :nounzip
    sha256 "e14fac20ec3de750713cf384ee55871aeac6514d4a1a5816430d68061a07b939"
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
