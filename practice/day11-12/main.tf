locals {
  formatted_project_name = lower(replace(var.project_name, " ", "-"))
}


locals {
  merged_tags = merge(var.default_tags, var.environment_tags)
}


locals {
  formatted_bucket_name = replace(
    replace(
      lower(substr(var.bucket_name, 0, 63)),
      " ", ""
    ),
    "!", ""
  )
}

locals {
  port_list = split(",", var.allowed_ports)
  
  sg_rules = [for port in local.port_list : {
    name = "port-${port}"
    port = port
    description = "Allow traffic on port ${port}"
  }]
  
  formatted_ports = join("-", [for port in local.port_list : "port-${port}"])
}

locals {
  instance_size = lookup(var.instance_sizes, var.environment, "t2.micro")
}

locals {
  all_locations    = concat(var.user_locations, var.default_locations)
  unique_locations = toset(local.all_locations)
}

locals {
  positive_costs = [for cost in var.monthly_costs : abs(cost)]
  max_cost       = max(local.positive_costs...)
  total_cost     = sum(local.positive_costs)
  avg_cost       = local.total_cost / length(local.positive_costs)
}

locals {
  current_timestamp    = timestamp()
  resource_date_suffix = formatdate("YYYYMMDD", local.current_timestamp)
  tag_date_format      = formatdate("DD-MM-YYYY", local.current_timestamp)
  timestamped_name     = "backup-${local.resource_date_suffix}"
}

locals {
  config_file_exists = fileexists("./config.json")
  config_data        = local.config_file_exists ? jsondecode(file("./config.json")) : {}
}