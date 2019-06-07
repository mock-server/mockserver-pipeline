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
AWS_ACCESS_KEY_ID=*** AWS_SECRET_ACCESS_KEY=*** ./deploy plan pipeline
```
#### create infrastructure
For example apply as follows:
```bash
AWS_ACCESS_KEY_ID=*** AWS_SECRET_ACCESS_KEY=*** ./deploy apply pipeline
```
#### update infrastructure
For example apply as follows:
```bash
AWS_ACCESS_KEY_ID=*** AWS_SECRET_ACCESS_KEY=*** ./deploy apply pipeline
```
#### delete infrastructure
For example apply as follows:
```bash
AWS_ACCESS_KEY_ID=*** AWS_SECRET_ACCESS_KEY=*** ./deploy plan-destroy pipeline
AWS_ACCESS_KEY_ID=*** AWS_SECRET_ACCESS_KEY=*** ./deploy destroy pipeline
```
