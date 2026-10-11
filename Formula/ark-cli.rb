# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.4.0"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli-dev", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0/ark-0.4.0-macos-arm64", using: :nounzip
    sha256 "6e3525a2b79a7bd5c246bd5aa9e771e155c796850d6c1bd71858d917882a6ed6"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0/ark-0.4.0-macos-amd64", using: :nounzip
    sha256 "054de65e4de55065f6129c9fb32c0c96925f67c25a1b2dab21774d79f2fd7d00"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0/LICENSES.txt", using: :nounzip
    sha256 "6dcb716ccfa241de860cb87fed1c091f75456113cf4d3082044b4c637a1532f3"
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
