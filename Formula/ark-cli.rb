# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.5.0"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli-dev", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.0/ark-0.5.0-macos-arm64", using: :nounzip
    sha256 "faed989dc40a08cd8119c9ce30792b95a23ba09f27a63d2e1a34c6015f995a68"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.0/ark-0.5.0-macos-amd64", using: :nounzip
    sha256 "1e133db2343c9266dce50c76ac7d2ac73b900eda4d05b6c2943e38831046f49b"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.0/LICENSES.txt", using: :nounzip
    sha256 "f93b08e31b34c2aff9f654c0f98c43e877227e8e57365016d504b4fdfdcbbc92"
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
