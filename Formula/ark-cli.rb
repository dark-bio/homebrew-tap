# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.2.0"
  license "BSD-3-Clause"

  depends_on :macos

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.0/ark-0.2.0-macos-arm64", using: :nounzip
    sha256 "3a2518aec436fa2c7d9fcd0b97dd61694d205121cd45d9d31b975bc9e6d25421"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.0/ark-0.2.0-macos-amd64", using: :nounzip
    sha256 "6bf38b4e94b781ccbc7068322f0d17f3c07be130a7434a0fc538d4acf95ee7b9"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.0/LICENSES.txt", using: :nounzip
    sha256 "4971a71ca658b8884b9ac77f51126449b00e96daf728cfa7213047ef3314a30c"
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
