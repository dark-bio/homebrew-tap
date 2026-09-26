# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.6-dev.39"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.39/ark-0.3.6-dev.39-macos-arm64", using: :nounzip
    sha256 "04aa0a2561f09fb3a50a5b7ed85841e032cbd2ead2e29798a779ed00ce83b490"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.39/ark-0.3.6-dev.39-macos-amd64", using: :nounzip
    sha256 "b57bdb2c0ba4cea50ff5319800ab086326f11a3f5a8dc9312d307406b2b0ff7f"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.39/LICENSES.txt", using: :nounzip
    sha256 "c0601c80b3c9d2dfca4c8fd9266bf73b8a72a69ec0669c522b4212a05441f53d"
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
