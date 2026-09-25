# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.6-dev.36"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.36/ark-0.3.6-dev.36-macos-arm64", using: :nounzip
    sha256 "493de3bac9ccfde224c7a606a1a34d1d753ffce88f7dba003f79eead9146824a"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.36/ark-0.3.6-dev.36-macos-amd64", using: :nounzip
    sha256 "2f9958be0ea6ba2b65a3f5b041c8e6d0ca0f0be2664abbe4b99f1a6ac86484a1"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.36/LICENSES.txt", using: :nounzip
    sha256 "969629d25d01e53cd96fa3759eebed1f38349b0174c3e148f2d1911cb188a19c"
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
