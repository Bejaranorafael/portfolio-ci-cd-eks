# main.tf: Infraestructura de Directorio Activo en AWS con Terraform

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configura el proveedor AWS (asume credenciales configuradas externamente)
provider "aws" {
  region = "us-east-1" # Región de AWS
}

# Define una VPC básica
resource "aws_vpc" "vpc_ad" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC-AD-Automatizada"
  }
}

# Define una subred pública
resource "aws_subnet" "subnet_publica" {
  vpc_id            = aws_vpc.vpc_ad.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Grupo de Seguridad para permitir RDP y PowerShell Remoto (WinRM)
resource "aws_security_group" "sg_ad" {
  vpc_id = aws_vpc.vpc_ad.id
  ingress {
    from_port   = 3389 # RDP
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Idealmente, restringir a tu IP pública
  }
  ingress {
    from_port   = 5985 # WinRM (PowerShell Remoting)
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instancia EC2 con Windows Server
resource "aws_instance" "servidor_ad" {
  ami           = var.ami_windows_2019 # AMI de Windows Server 2019 Base
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.subnet_publica.id
  security_groups = [aws_security_group.sg_ad.name]
  key_name      = "tu-clave-ssh" # Reemplazar por el nombre de tu clave Key Pair en AWS

  # Ejecuta el script de PowerShell al iniciar
  user_data = file("scripts/ad-setup.ps1")

  tags = {
    Name = "Servidor-Directorio-Activo"
  }
}

# Output: Muestra la IP pública de la instancia
output "ip_publica_ad" {
  value = aws_instance.servidor_ad.public_ip
}
