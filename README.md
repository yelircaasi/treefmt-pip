# treefmt-pip

This is a thin wrapper to make [treefmt](https://github.com/numtide/treefmt) installable via Python's pip (and thus via uv, poetry, pdm, etc.). Nix remains the best way to install treefmt, but for projects where dependencies must be installed via Python or Nix is unavailable, this will do the trick.

This project was inspired by [justin-yan's take](https://github.com/justin-yan/pybin) on how [Maturin packages rust binaries](https://www.maturin.rs/bindings#bin).  The key observation is that in the wheel format, the [distribution-1.0.data/scripts/ directory is copied to bin](https://packaging.python.org/en/latest/specifications/binary-distribution-format/#installing-a-wheel-distribution-1-0-py32-none-any-whl), which means we can leverage this to seamlessly copy binaries into a user's PATH.

Combined with Python's platform-specific wheels, this allows us to use pip as a "cross-platform package manager" for distributing single-binary CLI applications.
