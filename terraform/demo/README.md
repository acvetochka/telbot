
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
