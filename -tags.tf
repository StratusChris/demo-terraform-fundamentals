locals {
  common_tags = {
    Developer  = "Chris Hurst"
    Terraform  = "true"
    CostCenter = "My Pocket :'("
  }
}

#You can merge the common tags into custom tags on an object by defining tags like so:
#tags = "${merge(local.common_tags,
#    map(
#      "Name", "${var.name_prefix}-${var.plant_id}-live-data"
#    )
#  )}"