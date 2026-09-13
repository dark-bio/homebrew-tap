# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.1-dev.12"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.12/ark-0.3.1-dev.12-macos-arm64", using: :nounzip
    sha256 "4d1fed13d11b3869eae402c06ed955897a517859c3c9cfb33bf8ed2660b5f454"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.12/ark-0.3.1-dev.12-macos-amd64", using: :nounzip
    sha256 "84a7c36ba55e6b159ba9a8b4131a30f32a1381428577e3046be4cf1c331655b3"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.12/LICENSES.txt", using: :nounzip
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
