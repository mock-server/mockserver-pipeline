#### decrypt credentials
AWS_ACCESS_KEY_ID=*** AWS_SECRET_ACCESS_KEY=*** ./decrypt-terraform-credentials.sh 
#### Terraform Wrapper Script
```
Usage: ./deploy [-v|t] [ACTION] [ENVIRONMENT]
 ./deploy [plan|plan-destroy|apply|destroy] [pipeline]
      -v Verbose Mode
      -t Trace Mode
      -h Help
```
#### build execution plan
For example build plan as follows:
```bash
./deploy plan pipeline
```
#### create infrastructure
For example apply as follows:
```bash
./deploy apply pipeline
```
#### update infrastructure
For example apply as follows:
```bash
./deploy apply pipeline
```
#### delete infrastructure
For example apply as follows:
```bash
./deploy plan-destroy pipeline
./deploy destroy pipeline
```
### configure kubectl
```bash
./configure-kubectl.sh
```
### authorise nodes to join kubernetes cluster
```bash
./deploy worker_nodes_role pipeline
./kubectl.sh "apply -f config_map_aws_auth.yaml"
./kubectl.sh "get nodes --watch"
```