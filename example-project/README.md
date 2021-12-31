## Requirements

- A UNIX system with [Nix](https://nixos.org/download.html) installed; Linux, macOS or WSL2 on Windows should work.

# Getting started

```sh
$ nix-shell
[nix-shell]$ pip install -r requirements.txt
[nix-shell]$ jupyter lab build
[nix-shell]$ jupyter lab
```

## Dependency pinning
We want to make sure that the version of all **implicit dependencies** are pinned for reproducibility.

Don't modify `requirements.txt` directly, instead modify `requirements.in`, and run
```sh
[nix-shell]$ pip-compile
[nix-shell]$ pip-sync
```

You can install things temporarily with pip if you want to test a package out, but note that pip-sync will uninstall packages which are not in requirements.txt