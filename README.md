# Infraestructura OpenShift en IBM Cloud - Terraform

## Descripción General

Este repositorio contiene la definición de infraestructura como código (IaC) para la creación y gestión de un **cluster OpenShift en IBM Cloud** utilizando **Terraform**.

La arquitectura implementa un cluster **OpenShift VPC** con red privada, subredes por zona y conectividad exterior a través de **Public Gateways**, junto con una instancia **Cloud Object Storage (COS)** para el registro de imágenes del cluster.

---

## Arquitectura

La infraestructura se despliega en IBM Cloud utilizando Terraform y se compone de los siguientes elementos:

### Componentes principales

- **Storage**
  - Buckets para estado remoto de Terraform
  - Instancia **Cloud Object Storage (COS)** para el registro de imágenes del cluster OpenShift

- **Networking**
  - VPC custom con Resource Group dedicado
  - Subredes por zona (`number_of_zones` configurable), con rango IPv4 de 256 direcciones cada una
  - **Public Gateways** por zona para permitir conectividad exterior

- **Compute**
  - Cluster **OpenShift VPC** (IBM Container VPC Cluster)
  - Versión de OpenShift configurable (por defecto, la penúltima versión estable disponible)
  - Workers configurables por zona (`workers_per_zone`)
  - Flavor de worker configurable (`worker_flavor`)

- **Container Registry**
  - Namespace en IBM Container Registry (`ibm_cr_namespace`) asociado al Resource Group

### Etiquetado

- `name` = `bootcamp-<nombre>` (definido en variables)
- `resource_group` = grupo de recursos asignado

---

## Requisitos

Herramientas necesarias:

- Terraform >= 1.x
- IBM Cloud CLI (`ibmcloud`)
- Plugin `ibmcloud oc` (OpenShift)
- `kubectl` u `oc`
- Credenciales de IBM Cloud configuradas



## Región IBM Cloud

Región actual utilizada (configurable en `terraform.tfvars`):

```
variable "region" — ejemplo: eu-es (Madrid)
```

Las zonas se generan dinámicamente como `<region>-1`, `<region>-2`, etc., según el valor de `number_of_zones`.

---

## Acceso al Cluster OpenShift

Iniciar sesión en IBM Cloud:

```bash
ibmcloud login --sso
```

Iniciar sesión en el cluster OpenShift:

```bash
ibmcloud oc cluster config --cluster <nombre-cluster>
```

Verificar conexión:

```bash
oc get nodes
```

---

## Workflows CI/CD

El flujo de Terraform corre a través de dos pipelines independientes de GitHub Actions.


###  Plan & Apply

Se activa manualmente.

#### Flujo de trabajo

```
1. Ve a Actions → IBM CLUSTER → Run workflow
      └─ Selecciona la acción: plan o apply

2. Plan
      └─ Terraform muestra los cambios que se aplicarían
         └─ Revisa el output en los logs de la ejecución

3. Apply
      └─ Terraform aplica los cambios sobre la infraestructura
```



###  Destroy

Se activa manualmente.

#### Flujo de trabajo

```
1. Ve a Actions → IBM CLUSTER · Destroy → Run workflow
      └─ Terraform destruye toda la infraestructura aprovisionada
```
---

La infraestructura y los despliegues Kubernetes se gestionan mediante **GitHub Actions**.

### Deploy Namespaces OpenShift

- Ejecución manual
- Configura credenciales IBM Cloud
- Actualiza `kubeconfig`
- Aplica automáticamente todos los manifiestos Kubernetes ubicados en:

  ```
  k8s/*/*.yaml
  ```

  Mediante: `kubectl apply -f <manifest>`

### Generate K8s User Manifests

- Ejecución manual (`workflow_dispatch`)
- Recibe un parámetro `usernames` con nombres de usuario separados por coma (`rgonzalez,icasado`)
- Genera automáticamente los **namespaces y recursos Kubernetes** desde plantillas en `namespace_templates/` para todos los usuarios indicados
- Reemplaza dinámicamente en los templates:
  - `__NAME__` → nombre del usuario
  - `__EMAIL__` → email del usuario
- Los archivos generados mantienen el patrón `<tipo>.yaml` dentro de `k8s_namespaces/<usuario>/`
- Publica todos los manifests como artefacto `k8s_user_manifests`, listo para aplicar en el cluster

---

## Gestión de Credenciales

Los workflows utilizan credenciales de IBM Cloud almacenadas como **GitHub Secrets**:

- `IBMCLOUD_API_KEY`

Estas credenciales son utilizadas tanto por Terraform como por `kubectl`/`oc` para interactuar con el cluster OpenShift.

---

## Variables principales

| Variable | Descripción | Valor por defecto |
|---|---|---|
| `name` | Nombre base de los recursos | — |
| `region` | Región IBM Cloud | — |
| `resource_group` | Nombre del Resource Group | — |
| `number_of_zones` | Número de zonas (subredes y gateways) | — |
| `worker_flavor` | Flavor de los nodos worker | — |
| `workers_per_zone` | Número de workers por zona | — |
| `kube_version` | Versión de OpenShift (null = penúltima disponible) | `null` |
| `public_service_endpoint_disabled` | Deshabilitar endpoint público del cluster | — |
| `disable_outbound_traffic_protection` | Deshabilitar protección de tráfico saliente | — |
| `service_offering` | Tipo de servicio COS | — |
| `plan` | Plan de la instancia COS | — |
