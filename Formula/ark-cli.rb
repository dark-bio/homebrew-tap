# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.0"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli-dev", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.0/ark-0.3.0-macos-arm64", using: :nounzip
    sha256 "2633fa4caea08278d043b39586aa8a5b4477d9eaa6c81e7d41367612a1d42ddc"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.0/ark-0.3.0-macos-amd64", using: :nounzip
    sha256 "785daf616ec1cc286295384dcfdc537ad60d769e4cd30415c1b4a0c0928bee2c"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.0/LICENSES.txt", using: :nounzip
    sha256 "429ad045b4655fd9d76145203a72f19bfad8da6c713b57c7cdf43141eabfc59f"
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
