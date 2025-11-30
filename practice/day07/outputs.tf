output "vpc_name_from_tags" {
  value = var.instance_tags["Name"]
  description = "The VPC name from the tags map"
}

output "deployement_summary" {
  description = "Deployement summary"
  value = {
    environment = var.environment
    instance_count = var.instance_count
    Name = var.instance_tags.Name
  }
}