build:
	packer build -var build_id=$(shell git rev-parse HEAD) example.pkr.hcl
	gpg --detach-sign build/SHA256SUMS.txt
	gpg --detach-sign build/manifest.json

clean:
	rm -rf build


.PHONY: build clean
