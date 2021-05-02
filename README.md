# packer signing example

Example showing how to sign and publish packer artifacts.

Example shows two builds (each producing a single text file). Using
post-processors, we compress each artifact, record checksums and a manifest, and
then sign the resulting files.

## Usage

### Prerequisites

- [Packer](https://www.packer.io/) 1.6+
- [GNU make](https://www.gnu.org/software/make/)


### Build

Build the example.

    $ make build

The build directory produces these files.

```
$ tree build/
build/
├── example1_file.gz
├── example2_file.gz
├── manifest.json
├── manifest.json.sig
├── SHA256SUMS.txt
└── SHA256SUMS.txt.sig
```


## Notes

**Why not sign the checksum and manifest as post-processors?**

Post-processors run once for every build. In this case, each example file is
a separate build. The checksum and manifest post-processors are smart enough to
append to the same output, but the shell-local+gpg are not and would end up
overwriting the signature files. You could write a script to handle this, but
I think handling this as a post-build step feels simpler. Feel free to open an
issue.
