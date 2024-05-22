
create GithubRepository manifest
```shell
flux create source git telbot \
   --url=https://github.com/acvetochka/telbot \
   --branch=main \
   --namespace=demo \
   --export > demo/telbot-gr.yaml
```

create Helm manifest
```shell
flux create helmrelease telbot \
    --namespace=demo \
    --source=GitRepository/telbot \
    --chart="./helm" \
    --interval=1m \
    --export > demo/telbot-hr.yaml
```


flux create source git telbot \
    --url=https://github.com/acvetochka/telbot \
    --branch=main \
    --namespace=demo \
    --export > telbot-gr.yaml 

    ---
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: telbot
  namespace: demo
spec:
  interval: 1m0s
  ref:
    branch: main
  url: https://github.com/acvetochka/telbot

flux create helmrelease telbot \
    --namespace=demo \
    --source=GitRepository/telbot \
    --chart="./helm" \
    --interval=1m \
    --export > telbot-hr.yaml 