# Release template filled with the version and downloaded artifact digests.
class ArkCliDev < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.4.0-dev.49"
  license "BSD-3-Clause"

  depends_on :macos
  conflicts_with "ark-cli", because: "both install the ark command"

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0-dev.49/ark-0.4.0-dev.49-macos-arm64", using: :nounzip
    sha256 "e44ac9c9140ec44b313378a706ebe67627184fab5907bd50f6f25ecf0ed3018f"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0-dev.49/ark-0.4.0-dev.49-macos-amd64", using: :nounzip
    sha256 "ba53ea7de7897bf893202b94eb1b9475096d504592748666a4c24afefcd6bd4d"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.4.0-dev.49/LICENSES.txt", using: :nounzip
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
