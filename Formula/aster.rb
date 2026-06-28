class Aster < Formula
  desc "Symbol-aware codebase navigation and code-change daemon"
  homepage "https://github.com/iw2rmb/aster"
  url "https://github.com/iw2rmb/aster.git",
      tag:      "v0.1.0",
      revision: "8275fa30c608e8de07f3075b37998fc0d0956443"
  license :cannot_represent
  head "https://github.com/iw2rmb/aster.git", branch: "main"

  depends_on "go" => :build
  depends_on "gongd"

  def install
    ENV["GONOSUMDB"] = "github.com/iw2rmb/gongd/*"

    system "go", "build", *std_go_args(output: bin/"aster"), "./cmd/aster"
    system "go", "build", *std_go_args(output: bin/"asterd"), "./cmd/asterd"
  end

  service do
    run [opt_bin/"asterd"]
    keep_alive true
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_path_exists bin/"asterd"
    assert_match "go.symbol.rename", shell_output("#{bin}/aster op ls")
  end
end
