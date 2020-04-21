![CI](https://github.com/magurotuna/dotfiles/workflows/CI/badge.svg)

# My dotfiles

The core concepts of this dotfiles are **Portability** (*可搬性*) and **Idempotency** (*冪等性*).

## Usage

### Deploy & Init

1. Run the following command to fetch this repo and to install basic dependencies.

```bash
$ curl https://raw.githubusercontent.com/magurotuna/dotfiles/master/install.sh | bash
```

2. Make symlinks of dotfiles to home directory. (This step is called **Deploy**)

```bash
$ cd ~/dotfiles
$ make deploy
```

3. Execute initialize script. (This step is called **Initialize**)

```bash
$ make init
```

### After deploy & init

#### macOS

Some apps cannot be installed via Homebrew, so install them manually.

- [HotKey App](https://apps.apple.com/jp/app/hotkey-app/id975890633?mt=12)
  - Make alacritty togglable.
- [GIPHY Capture. The GIF Maker](https://apps.apple.com/jp/app/giphy-capture-the-gif-maker/id668208984?mt=12)
  - Capture utility. Easily make gif movie

#### Linux

WIP

## References

- [優れた dotfiles を設計して、最速で環境構築する話 - Qiita](https://qiita.com/b4b4r07/items/24872cdcbec964ce2178)
- [b4b4r07/dotfiles: A repository that gathered files starting with dot](https://github.com/b4b4r07/dotfiles)

