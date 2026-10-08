# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.4.0-dev.44"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0-dev.44/ark-0.4.0-dev.44-macos-arm64", using: :nounzip
    sha256 "532e161b138ef378017b23d6a5c46750f824a2c072e7a2dfb4b872a513be1752"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0-dev.44/ark-0.4.0-dev.44-macos-amd64", using: :nounzip
    sha256 "a85d1a85622d0b817a70f967e5b33e66e716613863cce3c835656ed6f28fd46d"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0-dev.44/LICENSES.txt", using: :nounzip
    sha256 "6dcb716ccfa241de860cb87fed1c091f75456113cf4d3082044b4c637a1532f3"
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
