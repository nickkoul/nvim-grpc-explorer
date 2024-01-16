print("Explorer Init!")
vim.api.nvim_create_user_command("GrpcExplore", function() require("explorer").grpcExplore() end, {})
