# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.2.1"
  license "BSD-3-Clause"

  depends_on :macos

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.1/ark-0.2.1-macos-arm64", using: :nounzip
    sha256 "c3b4380069631c9355e5e8988ce498f16bb6dec9802cc2a3fad2ded05c38fd2f"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.1/ark-0.2.1-macos-amd64", using: :nounzip
    sha256 "544dae5e90d7aba3b8690f7b7d3bbbe71c897dfefcc7a56387c11b59af54395d"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.2.1/LICENSES.txt", using: :nounzip
    sha256 "e58f46f5c106adcf8891eb717c36fbed0a020812cefbcd246d67bc23b5891009"
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
