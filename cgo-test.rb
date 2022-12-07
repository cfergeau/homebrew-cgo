class CgoTest < Formula
  desc "Test Formula trying to build a cgo program for both arm64 and amd64"
  version "0.0.1"
  url "https://github.com/cfergeau/cgo-test.git",
      branch: "master",
      revision: "a10b5c8a38c35d729b3341ac08d6e28f9df061ea"
  license "Apache-2.0"
  head "https://github.com/cfergeau/cgo-test.git", branch: "master"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    ENV["GOOS"]="darwin"

    ENV["GOARCH"]="arm64"
    system "go", "build", "-o", "test-ok-arm64", "."
    ENV["GOARCH"]="amd64"
    system "go", "build", "-o", "test-ok-amd64", "."

    # This runs the same commands as the ones below but fails to link
    system "make", "-e"

    bin.install "test-amd64"
    bin.install "test-arm64"
  end
end

