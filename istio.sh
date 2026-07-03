#install istio
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.30.2
export PATH=$PWD/bin:$PATH

#Enable default ns for injecting envoy containers
kubectl label namespace default istio-injection=enabled

#Using demo profile
istioctl install --set profile=demo -y
istioctl install --set profile=deafult -y #prod usecase no Egress Gateway
istioctl install --set profile=empty -y #complete customization enable based on need

#Enable egress
istioctl install --set profile=default \
  --set components.egressGateways[0].name=istio-egressgateway \
  --set components.egressGateways[0].enabled=true -y

#deploy bookinfo app
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

#Expose svc's
kubectl patch svc productpage -p '{"spec": {"type": "LoadBalancer"}}'
#Note: url:9080/productpage to view page

#Addons
kubectl apply -f samples/addons
# Expose Kiali Dashboard
kubectl patch svc kiali -n istio-system -p '{"spec": {"type": "LoadBalancer"}}'
# Expose Grafana Dashboard
kubectl patch svc grafana -n istio-system -p '{"spec": {"type": "LoadBalancer"}}'
# Expose Prometheus Metrics
kubectl patch svc prometheus -n istio-system -p '{"spec": {"type": "LoadBalancer"}}'
# Expose Jaeger Tracing (via "tracing" service)
kubectl patch svc tracing -n istio-system -p '{"spec": {"type": "LoadBalancer"}}'
