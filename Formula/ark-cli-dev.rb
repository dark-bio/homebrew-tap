# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.1-dev.15"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.15/ark-0.3.1-dev.15-macos-arm64", using: :nounzip
    sha256 "be3d4cfa159e61fc6cc2aea97ab12854377b5a89edb7fc4f1a172b25e9c689ca"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.15/ark-0.3.1-dev.15-macos-amd64", using: :nounzip
    sha256 "2d10f047a35f6624798ac781cf9c6e9bcd72aa8d3edce7ec526816c2c6f3775e"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.15/LICENSES.txt", using: :nounzip
    sha256 "fcfed744f5c1917687e0bfb4741afccfc440ca8ef64277e2f197f434a1ecec63"
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
