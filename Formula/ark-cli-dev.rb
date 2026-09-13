# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.0-dev.9"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.0-dev.9/ark-0.3.0-dev.9-macos-arm64", using: :nounzip
    sha256 "8017e1a431a335507fe651691db4c11d809df01b4dda8ae20e29462a0834c614"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.0-dev.9/ark-0.3.0-dev.9-macos-amd64", using: :nounzip
    sha256 "aec28306c51d38103bc0783d739ee05e9942298206fbc53d84d6e1d7840346fb"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.0-dev.9/LICENSES.txt", using: :nounzip
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
