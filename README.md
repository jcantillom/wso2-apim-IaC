# wso2-apim-infra

Infraestructura como código (IaC) para WSO2 API Manager sobre AWS ECS Fargate.

## Estructura

- `backend/`  
  Archivos de configuración del backend remoto de Terraform (S3 + DynamoDB) por ambiente.

- `envs/`  
  Definición de stacks por ambiente (`dev`, `qa`, `pdn`). Cada ambiente referencia los módulos reutilizables.

- `modules/`  
  Módulos reutilizables (networking, security groups, ALB, ECS, ECR, Route53, observabilidad, etc.).

- `versions.tf`  
  Versión mínima de Terraform y constraints de providers.

- `global-variables.tf`  
  Espacio reservado para variables globales compartidas (actualmente vacío).

## Backend remoto

State almacenado en S3 con locking en DynamoDB:

- Bucket: `btg.dev.integration.terraform`
- Key base: `integration/btg-wso2-apim-terraform-state/`
- Tabla DynamoDB: `btg-wso2-apim-terraform-locks`

Cada ambiente define su `key` específico en `backend/<env>_backend.tfvars`.
