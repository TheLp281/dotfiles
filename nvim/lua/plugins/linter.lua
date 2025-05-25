return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = {
          "--config",
          "/home/arch/.config/dotfiles/nvim/lua/utils/.markdownlint-cli2.yaml",
          "--"
        }
      }
    }
  }
}
