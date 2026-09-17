# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.4-dev.26"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4-dev.26/ark-0.3.4-dev.26-macos-arm64", using: :nounzip
    sha256 "4768d1a3443c694256b99761d0d0d9e22596416bc17bdd0ba6cc20294a3a6903"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4-dev.26/ark-0.3.4-dev.26-macos-amd64", using: :nounzip
    sha256 "da73374fa275896ef6ccf32a37045ffd39e37ca771723d508cfdd10cd4f93d50"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.4-dev.26/LICENSES.txt", using: :nounzip
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
