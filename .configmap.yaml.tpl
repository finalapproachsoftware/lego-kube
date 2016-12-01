apiVersion: v1
kind: ConfigMap
metadata:
  name: lego-config
  namespace: kube-lego
data:
  # modify this to specify your address
  lego.email: "cert@example.com"
  # configre letencrypt's production api
  lego.url: "https://acme-v01.api.letsencrypt.org/directory"
