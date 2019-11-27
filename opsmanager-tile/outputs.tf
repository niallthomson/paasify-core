output "blocker" {
  value = element(concat(null_resource.stage_tile.*.id, [""]), 0)
}