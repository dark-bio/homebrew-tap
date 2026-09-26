# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.6-dev.37"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.37/ark-0.3.6-dev.37-macos-arm64", using: :nounzip
    sha256 "32dda9c2d638dfc5417887f58d1f20719a269cbcdd329a29cfb1f91f2f228b0f"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.37/ark-0.3.6-dev.37-macos-amd64", using: :nounzip
    sha256 "af0c232d6e865d56de9330f5611750e9fb70b5bdb2ddbedc34af0d0e535d1bdf"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.6-dev.37/LICENSES.txt", using: :nounzip
    sha256 "f52ce81873c0f21551ebda77d267de56ddee658b65468f98d029546bafc091d9"
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
