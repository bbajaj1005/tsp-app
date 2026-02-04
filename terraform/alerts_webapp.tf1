# Action Group for Web App Alerts
resource "azurerm_monitor_action_group" "webapp_alerts" {
  name                = "ag-webapp-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "webapp"

  email_receiver {
    name          = "kapil-dev"
    email_address = "kapil.dev@rsystems.com"
  }

  tags = {
    environment = var.environment
  }
}

# Alert: HTTP Server Errors (5xx)
resource "azurerm_monitor_metric_alert" "webapp_http_server_errors" {
  name                = "webapp-http-server-errors-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_web_app.main.id]
  description         = "Alert when HTTP 5xx server errors exceed threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 1
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: HTTP Client Errors (4xx)
resource "azurerm_monitor_metric_alert" "webapp_http_client_errors" {
  name                = "webapp-http-client-errors-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_web_app.main.id]
  description         = "Alert when HTTP 4xx client errors exceed threshold"
  severity            = 3
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http4xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 10
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: High Response Time
resource "azurerm_monitor_metric_alert" "webapp_response_time" {
  name                = "webapp-response-time-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_web_app.main.id]
  description         = "Alert when average response time exceeds threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "AverageResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 2000 # 2 seconds in milliseconds
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: High CPU Usage
resource "azurerm_monitor_metric_alert" "webapp_cpu_usage" {
  name                = "webapp-cpu-usage-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_service_plan.main.id]
  description         = "Alert when CPU usage exceeds threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name      = "CpuPercentage"
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

# Alert: High Memory Usage
resource "azurerm_monitor_metric_alert" "webapp_memory_usage" {
  name                = "webapp-memory-usage-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_service_plan.main.id]
  description         = "Alert when memory usage exceeds threshold"
  severity            = 2
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name      = "MemoryPercentage"
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

# Alert: Low HTTP Requests (Possible Downtime)
resource "azurerm_monitor_metric_alert" "webapp_low_requests" {
  name                = "webapp-low-requests-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_web_app.main.id]
  description         = "Alert when HTTP requests drop significantly (possible downtime)"
  severity            = 1
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Requests"
    aggregation      = "Total"
    operator         = "LessThan"
    threshold        = 1 # Less than 1 request in 15 minutes
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: App Service Plan Health
resource "azurerm_monitor_metric_alert" "webapp_health_check" {
  name                = "webapp-health-check-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_web_app.main.id]
  description         = "Alert when app is unhealthy or unavailable"
  severity            = 1
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 1 # Health check status < 1 indicates unhealthy
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Data In (Bandwidth)
resource "azurerm_monitor_metric_alert" "webapp_data_in" {
  name                = "webapp-data-in-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_web_app.main.id]
  description         = "Alert when data in exceeds threshold"
  severity            = 3
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "BytesReceived"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 104857600 # 100 MB in bytes
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

# Alert: Data Out (Bandwidth)
resource "azurerm_monitor_metric_alert" "webapp_data_out" {
  name                = "webapp-data-out-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_web_app.main.id]
  description         = "Alert when data out exceeds threshold"
  severity            = 3
  enabled             = true
  auto_mitigate       = true
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "BytesSent"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 104857600 # 100 MB in bytes
  }

  action {
    action_group_id = azurerm_monitor_action_group.webapp_alerts.id
  }

  tags = {
    environment = var.environment
  }
}

