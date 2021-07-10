# Production deployment

## Add Cloud SQL Instance
gcloud beta run services update gohome-server \
--add-cloudsql-instances <INSTANCE_NAME> \
--update-secrets GOHOME_DB_HOST="<SECRET_NAME>:<SECRET_VERSION>" \
--update-secrets GOHOME_DB_PASSWORD="<SECRET_NAME>:<SECRET_VERSION>"