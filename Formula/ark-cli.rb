# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.1"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli-dev", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1/ark-0.3.1-macos-arm64", using: :nounzip
    sha256 "813adb41e5c78e520baed4c46341cb634a1c041329f6c6b5f4e02c9c380af0d4"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1/ark-0.3.1-macos-amd64", using: :nounzip
    sha256 "6ba5a121b895d21dc16aafb3e2c9e56b9ce85915d71a212bd6bcd3c8590e54d6"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1/LICENSES.txt", using: :nounzip
    sha256 "fcfed744f5c1917687e0bfb4741afccfc440ca8ef64277e2f197f434a1ecec63"
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
