output "blocker" {
  value = var.auto_apply ? null_resource.apply_changes[0].id : "nil"
}