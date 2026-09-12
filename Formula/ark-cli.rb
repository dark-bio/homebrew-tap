class ArkCli < Formula
  desc "Command line interface to Ark enclaves"
  homepage "https://dark.bio"
  version "0.1.0"
  license "BSD-3-Clause"

  depends_on :macos

  on_arm do
    url "https://github.com/dark-bio/cli/releases/download/v#{version}/ark-#{version}-macos-arm64", using: :nounzip
    sha256 "7c9ca89a8abc080980b47f803204b492331c38e73bce4554df1fbacc6dde73d8"
  end

  on_intel do
    url "https://github.com/dark-bio/cli/releases/download/v#{version}/ark-#{version}-macos-amd64", using: :nounzip
    sha256 "79eb7b2e37b64fc19d1e750ee6ee8bb5852079a9e990c1361b9157dc5929b076"
  end

  resource "licenses" do
    url "https://github.com/dark-bio/cli/releases/download/v0.1.0/LICENSES.txt", using: :nounzip
    sha256 "459a23afe4b6c56e8b841985608b003737126cbfa6deae22a6aad3e41b0153db"
  end

  def install
    bin.install Dir["ark-#{version}-macos-*"].fetch(0) => "ark"
    chmod 0755, bin/"ark"
    resource("licenses").stage { pkgshare.install "LICENSES.txt" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ark --version")
  end
end
