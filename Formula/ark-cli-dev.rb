# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.2-dev.21"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2-dev.21/ark-0.3.2-dev.21-macos-arm64", using: :nounzip
    sha256 "242f6657c95cfef67588e090897035f24587f8a9ae53d9bce26df794eecdfb8b"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2-dev.21/ark-0.3.2-dev.21-macos-amd64", using: :nounzip
    sha256 "e90f829edf06f77d60c757538399c3449e8d0ce29b00193391bab2a2edbdae73"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.2-dev.21/LICENSES.txt", using: :nounzip
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
