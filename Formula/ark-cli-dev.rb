# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.4.0-dev.47"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0-dev.47/ark-0.4.0-dev.47-macos-arm64", using: :nounzip
    sha256 "804693dd3ea0ddcb4222b2321af021aa6c0607717520ba8a8651aa87f2a8b650"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0-dev.47/ark-0.4.0-dev.47-macos-amd64", using: :nounzip
    sha256 "3d3a8479a163e72e91122245f855f61b3d212378d86b97cec64a6ee228b4f835"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0-dev.47/LICENSES.txt", using: :nounzip
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
