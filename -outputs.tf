output "site-url" {
  description = "URL for Terraform Demo site"
  value       = "http://${var.site_host}.${var.site_root_zone}"
}
