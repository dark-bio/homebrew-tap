# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.2"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli-dev", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2/ark-0.3.2-macos-arm64", using: :nounzip
    sha256 "85c844254a9162a50b24f898b7edc860aa956129dee88da527a0516f7c595cea"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2/ark-0.3.2-macos-amd64", using: :nounzip
    sha256 "58bb60cc459b5b7f2abf4390da60e9ace318553ef67dee532b6c5bc5c4d37bd8"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2/LICENSES.txt", using: :nounzip
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
