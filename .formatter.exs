[
  import_deps: [:ecto, :phoenix],
  plugins: [HeexFormatter],
  inputs: [
    "*.{ex,exs}",
    "*.{heex,ex,exs}",
    "{config,lib,test}/**/*.{heex,ex,exs}",
    "priv/*/seeds.exs",
    "{config,lib,test}/**/*.{ex,exs}"
  ],
  subdirectories: ["priv/*/migrations"]
]
