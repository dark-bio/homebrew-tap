# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.4.2-dev.58"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.2-dev.58/ark-0.4.2-dev.58-macos-arm64", using: :nounzip
    sha256 "31b262338d668d4c94fda505e34188599bf3ae778a5515f8dd8209792dfd1468"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.2-dev.58/ark-0.4.2-dev.58-macos-amd64", using: :nounzip
    sha256 "667a2534fade429afc17b18ddb67b8f295ec590a3b92b10924ba31637a855ee2"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.2-dev.58/LICENSES.txt", using: :nounzip
    sha256 "e2ce701c419f4b15e530b1d7fc0e61295885fd1928589a7470be25c78823168b"
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
