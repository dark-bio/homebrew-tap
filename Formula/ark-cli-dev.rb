# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.4-dev.28"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4-dev.28/ark-0.3.4-dev.28-macos-arm64", using: :nounzip
    sha256 "610796095c0f9234e5aaa28be8a6c8046e9c9d1ddcd4bb33f1f68b0e6e8d73ad"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4-dev.28/ark-0.3.4-dev.28-macos-amd64", using: :nounzip
    sha256 "5bfdd89973b901bc08502561008ad7cd9a2c26bfa066b36c98c19d6ce8f3ae3b"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4-dev.28/LICENSES.txt", using: :nounzip
    sha256 "349497d59ff7a6f22edefef0993f491a316f24b622dafcc9f32cef5851e8f91e"
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
