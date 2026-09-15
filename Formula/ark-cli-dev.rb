# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.2-dev.18"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2-dev.18/ark-0.3.2-dev.18-macos-arm64", using: :nounzip
    sha256 "3207ec4313dd65f835f6f81c7feec8d14ed7999410b426b60a931be3bf192daa"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2-dev.18/ark-0.3.2-dev.18-macos-amd64", using: :nounzip
    sha256 "26c1bdd1ee1119b4b0909d91fab94873b8b323664f841a97838390b8aa7b8cb6"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2-dev.18/LICENSES.txt", using: :nounzip
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
