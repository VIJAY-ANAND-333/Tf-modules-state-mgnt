resource "aws_ebs_volume" "this" {
  availability_zone = var.az
  size              = var.size
  tags              = { Name = "vj-ebs" }
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.this.id
  instance_id = var.instance_id
}