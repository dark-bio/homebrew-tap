# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.5-dev.32"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.5-dev.32/ark-0.3.5-dev.32-macos-arm64", using: :nounzip
    sha256 "876d083378bf36bdc3c56f1be8dc8309a5f4f7a734533fcefa2e83b860fe6200"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.5-dev.32/ark-0.3.5-dev.32-macos-amd64", using: :nounzip
    sha256 "46e7387cb8d5429f51c48657962f1e82598ebd3e35cd1494d0c4dc70adf4ad7a"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.5-dev.32/LICENSES.txt", using: :nounzip
    sha256 "b1d2683530d4073509837524302cd158641ba725a1941165a259b970d0f6e227"
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
