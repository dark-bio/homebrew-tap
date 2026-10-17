# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.5.0-dev.59"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.0-dev.59/ark-0.5.0-dev.59-macos-arm64", using: :nounzip
    sha256 "56e379b94c9c93f63266bf35248ddf09bf06e8088b70f9644ef8591f6caaa532"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.0-dev.59/ark-0.5.0-dev.59-macos-amd64", using: :nounzip
    sha256 "496b1cc2e4bbb18c655cc4f90bf2e878665168c7678a0a77b884b8beec64896b"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.0-dev.59/LICENSES.txt", using: :nounzip
    sha256 "dbdf86c7f62fd8cdc674c27899aed889a2e5d469cbf80250305bad7c3a108c5c"
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
