output "address" {
  value       = aws_db_instance.example.address
  description = "Connet to the dataase at this endpoint"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "The por the database s listeing on"
}