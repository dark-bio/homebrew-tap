# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.1-dev.11"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.11/ark-0.3.1-dev.11-macos-arm64", using: :nounzip
    sha256 "f1bd5ada34ff8f73bc969050b95549c0f0204aff95bd1b7ed6fb739a6d2f0734"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.11/ark-0.3.1-dev.11-macos-amd64", using: :nounzip
    sha256 "2165ff27d810f115103f233add731595d1cba10ee90634c6fe1cf8da8f6c4eef"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.11/LICENSES.txt", using: :nounzip
    sha256 "0adf85b15854b6fdaa3bcbd50cc32225a54870ded6c442ceb240fad81a3f3eae"
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
