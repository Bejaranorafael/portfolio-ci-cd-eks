# 🚀 Proyecto de Portfolio: Pipeline CI/CD Automatizado en AWS EKS

Demostración práctica de un flujo de trabajo DevOps completo, desde la infraestructura como código (IaC) hasta el despliegue continuo de una aplicación en un clúster de Kubernetes en la nube de AWS.

## 🎯 Objetivo del Proyecto

El objetivo de este proyecto es simular un entorno de producción donde la **automatización** reduce los tiempos de despliegue y mejora la fiabilidad. Se automatiza la creación de la infraestructura, el build de la aplicación y su despliegue en un entorno contenerizado.

## 💡 Tecnologías Utilizadas

Categoría	Herramienta	Uso en el proyecto
Cloud	AWS	Alojamiento de la infraestructura (VPC, EKS Cluster, S3).
IaC	Terraform	Aprovisionamiento y gestión de la VPC y el clúster EKS.
Contenedores	Docker	Empaquetado de la aplicación en una imagen estandarizada.
CI/CD	GitLab CI/CD	Automatización del build, test y despliegue del pipeline.
Orquestación	Kubernetes (EKS)	Orquestación de contenedores y alta disponibilidad.
Lenguaje App	Node.js	Aplicación de ejemplo simple.

## 🔒 Fase 2: Hardening y Observabilidad (Nivel Producción)

En esta fase, el proyecto evoluciona de un despliegue básico a una arquitectura robusta preparada para auditorías de seguridad y monitoreo en tiempo real.

### 🛡️ Seguridad (Hardening)
*   **Estándares de Seguridad de Pods (PSS):** Implementación del perfil `restricted` en el namespace de producción para mitigar riesgos de ejecución.
*   **Contexto de Seguridad:** Configuración de contenedores para ejecución "No-Root", evitando que procesos internos ganen control del nodo.
*   **Políticas de Red (Network Policies):** Aplicación de reglas de aislamiento para permitir únicamente el tráfico necesario, siguiendo el principio de "Privilegio Mínimo".

### 📊 Observabilidad y Monitoreo
*   **Stack Prometheus & Grafana:** Configuración de la infraestructura para la recolección automática de métricas del clúster y la aplicación.
*   **Gestión de Recursos:** Implementación de `Requests` y `Limits` de CPU/Memoria para garantizar la estabilidad y prevenir el agotamiento de recursos (OOM Kill).
*   **Persistencia de Datos:** Configuración de volúmenes persistentes para que las métricas no se pierdan al reiniciar los servicios.

### 🚀 Impacto Profesional
Esta fase demuestra la capacidad de gestionar entornos críticos donde la **seguridad** no es opcional y la **visibilidad** del sistema es clave para la toma de decisiones técnicas.

Flujo de Trabajo:
Código: El desarrollador hace un git push al repositorio.
CI/CD (GitLab CI): El pipeline se dispara automáticamente.
Build: Se construye la imagen Docker y se sube a Docker Hub.
IaC Deploy: Terraform aprovisiona o actualiza la infraestructura en AWS (VPC, EKS).
App Deploy: kubectl despliega la nueva imagen en los pods de Kubernetes.
Acceso: El usuario accede a la aplicación a través del Load Balancer de AWS.
⚙️ Instrucciones de Uso (Manual)
Requisitos Previos:
Terraform instalado y configurado con credenciales de AWS.
Docker instalado.
kubectl instalado y configurado.
Despliegue de Infraestructura:
bash
cd infra
terraform init
terraform plan
terraform apply --auto-approve
Usa el código con precaución.

Ejecución Local de la Aplicación:
bash
cd app
docker build -t tu_docker_id/portfolio-app-eks:latest .
docker run -p 3000:3000 tu_docker_id/portfolio-app-eks:latest
Usa el código con precaución.

⭐ Métrica de Éxito (Impacto Profesional)
Reducción del Tiempo de Despliegue: La implementación de este pipeline reduce el tiempo desde el commit del código hasta el despliegue en producción de horas a minutos (ej: 80% de reducción).
Fiabilidad: Eliminación de errores manuales de configuración gracias al uso de Terraform e Infraestructura como Código.
