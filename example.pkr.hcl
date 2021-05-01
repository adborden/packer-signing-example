variable "build_dir" {
  default = "build"
  description = "Output directory for artifacts."
}

variable "build_id" {
  default     = ""
  description = "Identifier for this build."
}

locals {
  build_id = var.build_id != "" ? var.build_id : formatdate("YYYYMMDDhhmmss", timestamp())
}

source "file" "example1" {
    content = "example1 content"
    target = "${var.build_dir}/test_example1.txt"
}

source "file" "example2" {
    content = "example2 content"
    target = "${var.build_dir}/test_example2.txt"
}


build {
  name = "example"
  sources = [
    "source.file.example1",
    "source.file.example2",
  ]

  post-processors {
    # compress each artifact
    post-processor "compress" {
      output = "${var.build_dir}/{{.BuildName }}_{{.BuilderType}}.gz"
    }

    # append the gzipped artifact's SHA to checksum file
    post-processor "checksum" {
      checksum_types = ["sha256"]
      output = "${var.build_dir}/SHA256SUMS.txt"
    }

    # append the gzipped artifact to the manifest file
    post-processor "manifest" {
      output = "${var.build_dir}/manifest.json"
      custom_data = {
        build_id = local.build_id
      }
    }
  }
}
