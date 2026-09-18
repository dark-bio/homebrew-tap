# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.4-dev.27"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4-dev.27/ark-0.3.4-dev.27-macos-arm64", using: :nounzip
    sha256 "f422eebc99cc7d137be263cd4e4c23b7915d395449e9ee37bfebdbfb5032e331"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4-dev.27/ark-0.3.4-dev.27-macos-amd64", using: :nounzip
    sha256 "d075b39449df103dea93088fd64d5c3256feb4642316a4b678d6336b8746453a"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4-dev.27/LICENSES.txt", using: :nounzip
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
