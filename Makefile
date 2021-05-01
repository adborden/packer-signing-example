build:
	packer build example.pkr.hcl
	gpg --detach-sign build/SHA256SUMS.txt
	gpg --detach-sign build/manifest.json

clean:
	rm -rf build


.PHONY: build clean
