# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.3-dev.23"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.3-dev.23/ark-0.3.3-dev.23-macos-arm64", using: :nounzip
    sha256 "def1787f00ffb903d111faed5643d6a4bcca8984b4bc76e8e96beeb8a2baf2b1"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.3-dev.23/ark-0.3.3-dev.23-macos-amd64", using: :nounzip
    sha256 "094b89e69a53c278b883ddd548253116035c1cfc578df6c6add996cef8535f9f"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.3-dev.23/LICENSES.txt", using: :nounzip
    sha256 "2b40e52148662c56b6f83c871936b1ef45fc70f96cf29381645a715e3dc996c9"
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
