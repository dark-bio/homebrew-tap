# Release template filled with the version and downloaded artifact digests.
class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.4"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli-dev", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4/ark-0.3.4-macos-arm64", using: :nounzip
    sha256 "f6026d3803d73c72a5c374fc2438f390d736d722d5ebc91604a9425ed64e30f2"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4/ark-0.3.4-macos-amd64", using: :nounzip
    sha256 "84a2465d4ccf280f4c10edab56aa8a6a0041ba337245d9a83ef27304e790826e"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4/LICENSES.txt", using: :nounzip
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
