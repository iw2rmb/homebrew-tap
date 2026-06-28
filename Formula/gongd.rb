class Gongd < Formula
  desc "Git-aware local filesystem event daemon over Unix sockets"
  homepage "https://github.com/iw2rmb/gongd"
  url "https://github.com/iw2rmb/gongd.git",
      tag:      "v0.1.4",
      revision: "6947ba5824178b75323f2aa229de53a2a4ae6f78"
  license "MIT"
  head "https://github.com/iw2rmb/gongd.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  service do
    run [opt_bin/"gongd"]
    keep_alive true
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gongd --version")
  end
end
