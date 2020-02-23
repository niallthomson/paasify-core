resource "google_service_account" "ops_manager" {
  account_id   = "${var.environment_name}-ops-manager"
  display_name = "${var.environment_name} Ops Manager VM Service Account"
}

resource "google_service_account_key" "ops_manager" {
  service_account_id = google_service_account.ops_manager.id
}

resource "google_project_iam_member" "iam_service_account_user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.ops_manager.email}"
}

resource "google_project_iam_member" "iam_service_account_token_creator" {
  project = var.project
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.ops_manager.email}"
}

resource "google_project_iam_member" "compute-instance-admin-v1" {
  project = var.project
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.ops_manager.email}"
}

resource "google_project_iam_member" "compute_network_admin" {
  project = var.project
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.ops_manager.email}"
}

resource "google_project_iam_member" "compute_storage_admin" {
  project = var.project
  role    = "roles/compute.storageAdmin"
  member  = "serviceAccount:${google_service_account.ops_manager.email}"
}

resource "google_project_iam_member" "storage_admin" {
  project = var.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.ops_manager.email}"
}