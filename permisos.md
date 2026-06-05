
# IBM Cloud — Documentación de Permisos IAM

**Service ID — Acceso mínimo necesario por servicio**  

Este documento recoge los permisos IAM asignados al Service ID utilizado para ejecutar Terraform en IBM Cloud, siguiendo el principio de mínimo privilegio. Los permisos se han ido ajustando iterativamente durante el proceso de aprovisionamiento de infraestructura.


---
## 1. VPC Infrastructure

Necesario a partir del primer ejercicio.
### Permisos asignados

| Rol      | Tipo       | Para qué sirve                                   |
| -------- | ---------- | ------------------------------------------------ |
| Editor   | Plataforma | Crear, modificar y eliminar recursos de VPC      |
| Escritor | Servicio   | Operar sobre los recursos de la instancia de VPC |

### Documentación oficial

https://cloud.ibm.com/docs/vpc?topic=vpc-iam-getting-started

---

## 2. IBM Schematics

Necesario a partir del 4 ejercicio que se empieza a usar la herramienta Schematics.
### Permisos requeridos

| Rol    | Tipo       | Para qué sirve                           |
| ------ | ---------- | ---------------------------------------- |
| Editor | Plataforma | Crear y eliminar workspaces              |
| Gestor | Servicio   | Control total: crear, ejecutar, destruir |

### Documentación oficial

https://cloud.ibm.com/docs/schematics?topic=schematics-access

---
## 3. IBM Container Registry

Necesario para el ejercicio 7.
### Permisos requeridos

| Rol          | Tipo       | Para qué sirve                       |     |
| ------------ | ---------- | ------------------------------------ | --- |
| Gestor       | Servicio   | Operaciones avanzadas sobre imágenes |     |
| Adminitrador | Plataforma | Crear y eliminar namespaces          |     |

### Documentación oficial

https://cloud.ibm.com/docs/Registry?topic=Registry-iam&interface=ui

---

## 4. Cloud Object Storage

Necesario para el ejercicio 7.
### Permisos asignados

| Rol      | Tipo       | Para qué sirve                                       |
| -------- | ---------- | ---------------------------------------------------- |
| Editor   | Plataforma | Crear y eliminar instancias de COS                   |
| Escritor | Servicio   | Crear, leer y eliminar objetos dentro de los buckets |

### Documentación oficial

https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-iam

---

## 5. IBM Cloud Monitoring (Sysdig)

Necesario para el ejercicio 8.
### Permisos requeridos

| Rol     | Tipo       | Para qué sirve                           |
| ------- | ---------- | ---------------------------------------- |
| Editor  | Plataforma | Crear y eliminar instancias del servicio |
| Gestor | Servicio   | Configuración completa de la instancia   |


### Documentación oficial

https://cloud.ibm.com/docs/monitoring?topic=monitoring-iam_grant


## 6. Kubernetes Service

Necesario para 
### Permisos requeridos

| Rol     | Tipo       | Para qué sirve                           |
| ------- | ---------- | ---------------------------------------- |
| Visor   | Plataforma |  Ver el clúster en IBM Cloud y obtener el kubeconfig |
| Lector  | Servicio   | Autenticar contra la API del clúster |

> El acceso real de despliegue se gestiona mediante RBAC. [Configuración RBAC](./README.md)

### Documentación oficial

https://cloud.ibm.com/docs/monitoring?topic=monitoring-iam_grant

---

## 7. Resumen 

| Servicio                      | Rol de Plataforma | Rol de Servicio | Scope                     |
| ----------------------------- | ----------------- | --------------- | ------------------------- |
| VPC Infrastructure            | Editor            | Escritor        | Resource Group específico |
| IBM Schematics                | Editor            | Gestor          | Resource Group específico |
| Container Registry            | Administrador     | Gestor          | Resource Group específico |
| Cloud Object Storage          | Editor            | Escritor        | Resource Group específico |
| IBM Cloud Monitoring (Sysdig) | Editor            | Gestor          | Resource Group específico |

---
### Referencia general IAM en IBM Cloud

https://cloud.ibm.com/docs/account?topic=account-userroles
