output "server_public_ip" {
  description = "The public IP of the Minecraft server"
  value       = aws_instance.minecraft_server.public_ip
}

output "backup_bucket_name" {
  value = aws_s3_bucket.minecraft_backups.bucket
}
