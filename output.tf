output "ec2_public_ip" {
    value = module.foxapp-server.instance.public_ip
}