# My dotfiles

## Usage

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

## References

- [優れた dotfiles を設計して、最速で環境構築する話 - Qiita](https://qiita.com/b4b4r07/items/24872cdcbec964ce2178)
- [b4b4r07/dotfiles: A repository that gathered files starting with dot](https://github.com/b4b4r07/dotfiles)
