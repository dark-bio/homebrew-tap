# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.3.1-dev.14"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.14/ark-0.3.1-dev.14-macos-arm64", using: :nounzip
    sha256 "bc8f5cf64e5ab5f74effbc3aa9e01c95ff5ed7bc1f9f4d7d77e39d815107b4c0"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.14/ark-0.3.1-dev.14-macos-amd64", using: :nounzip
    sha256 "30609fd4606011cca396b762d64a59cac33938d61abdac33666bd550b228c020"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.3.1-dev.14/LICENSES.txt", using: :nounzip
    sha256 "fcfed744f5c1917687e0bfb4741afccfc440ca8ef64277e2f197f434a1ecec63"
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
