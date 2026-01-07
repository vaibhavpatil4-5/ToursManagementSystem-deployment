resource "aws_route_table_association" "public" {
  for_each       = var.subnet_ids
  subnet_id      = each.value
  route_table_id = var.pv_rt
}
