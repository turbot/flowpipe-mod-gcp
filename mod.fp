mod "gcp" {
  title         = "GCP"
  description   = "Run pipelines to supercharge your GCP workflows using Flowpipe."
  color         = "#ea4335"
  documentation = file("./README.md")
  icon          = "/images/mods/turbot/gcp.svg"
  categories    = ["public cloud"]

  opengraph {
    title       = "GCP"
    description = "Run pipelines to supercharge your GCP workflows using Flowpipe."
    image       = "/images/mods/turbot/gcp-social-graphic.png"
  }

  require {
    flowpipe {
      min_version = "1.0.0"
    }
  }
}
