# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.5.1-dev.63"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.1-dev.63/ark-0.5.1-dev.63-macos-arm64", using: :nounzip
    sha256 "a77de34626d54ba412bd303f72a83b6279cbc19917e4c2a4f2cc478f559d0e4f"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.1-dev.63/ark-0.5.1-dev.63-macos-amd64", using: :nounzip
    sha256 "1ab5a2f0357bcd834a6bfa703f18f159e3bcd77ff022b4a44bdccabc8ed89534"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.5.1-dev.63/LICENSES.txt", using: :nounzip
    sha256 "3fcaea885666b35192b3be02c23c9aef90d3df81d59ad068e377a91f62700554"
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
