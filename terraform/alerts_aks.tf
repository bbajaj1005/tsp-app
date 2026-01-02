# Action Group for AKS Alerts (reuse the webapp action group)
# Using the same action group for consistency

# Alert: Node CPU Usage
resource "azurerm_monitor_metric_alert" "aks_node_cpu" {
  name                = "aks-node-cpu-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when AKS node CPU usage exceeds threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 50 # 80% CPU
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Node Memory Usage
resource "azurerm_monitor_metric_alert" "aks_node_memory" {
  name                = "aks-node-memory-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when AKS node memory usage exceeds threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_memory_working_set_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 50 # 80% Memory
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Pod CPU Usage
resource "azurerm_monitor_metric_alert" "aks_pod_cpu" {
  name                = "aks-pod-cpu-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when AKS pod CPU usage exceeds threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "pod_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80 # 80% CPU
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Pod Memory Usage
resource "azurerm_monitor_metric_alert" "aks_pod_memory" {
  name                = "aks-pod-memory-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when AKS pod memory usage exceeds threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "pod_memory_working_set_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80 # 80% Memory
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Failed Pods
resource "azurerm_monitor_metric_alert" "aks_failed_pods" {
  name                = "aks-failed-pods-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when number of failed pods exceeds threshold"
  severity            = 1
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_pod_status_phase"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 0 # Any failed pods
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Container Restarts
resource "azurerm_monitor_metric_alert" "aks_container_restarts" {
  name                = "aks-container-restarts-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when container restarts exceed threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_pod_container_status_restarts_total"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 2 # More than 5 restarts
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Node Not Ready
resource "azurerm_monitor_metric_alert" "aks_node_not_ready" {
  name                = "aks-node-not-ready-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when AKS nodes are not ready"
  severity            = 1
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_node_status_condition"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 0 # Any node not ready
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Disk Usage
resource "azurerm_monitor_metric_alert" "aks_disk_usage" {
  name                = "aks-disk-usage-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when AKS node disk usage exceeds threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_disk_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 20 # 85% disk usage
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Network Errors
resource "azurerm_monitor_metric_alert" "aks_network_errors" {
  name                = "aks-network-errors-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when AKS network errors exceed threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_network_in_errors_total"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 10 # More than 10 network errors
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Kubelet Errors
resource "azurerm_monitor_metric_alert" "aks_kubelet_errors" {
  name                = "aks-kubelet-errors-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when kubelet errors occur"
  severity            = 1
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kubelet_runtime_operations_errors_total"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 1 # Any kubelet errors
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: API Server Latency
resource "azurerm_monitor_metric_alert" "aks_api_server_latency" {
  name                = "aks-api-server-latency-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when Kubernetes API server latency is high"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "apiserver_request_duration_seconds"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 1 # 1 second latency
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Pending Pods
resource "azurerm_monitor_metric_alert" "aks_pending_pods" {
  name                = "aks-pending-pods-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when pods are stuck in pending state"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_pod_status_phase"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 0 # Any pending pods for more than 15 minutes
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: OOM Killed Containers
resource "azurerm_monitor_metric_alert" "aks_oom_killed" {
  name                = "aks-oom-killed-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.main.id]
  description         = "Alert when containers are killed due to OOM (Out of Memory)"
  severity            = 1
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "container_oom_events_total"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 0 # Any OOM kills
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

