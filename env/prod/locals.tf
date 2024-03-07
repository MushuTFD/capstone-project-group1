locals {
  name_prefix = "sctp-ce4-group1"
  frontend_service = "react-1-prod"
  backend_service = "flask-prod"

  #Must've created le
  frontend_repository = "richie-react-app"
  backend_repository = "richie-flask-app"
}