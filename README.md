# Telebot

## Helm

1. Створення нового Helm чарту
```shell
helm create helm
```
2. Відредагувати файл `values.yaml`
```yaml
image:
  repository: acvetochka
  tag: "v1.0.0-82050c9"
  arch: amd64
secret:
  name: "telbot"
  env: "TELE_TOKEN"
  key: "token"
securityContext:
  privileged: true
```

3. Відредагувати файл `deployment.yaml`
```yaml
spec:
  template:
    spec:
      containers:
        - name: {{ .Release.Name }}
          image: {{ .Values.image.repository }}/{{ .Chart.Name }}:{{ .Values.image.tag }}-{{ .Values.image.arch | default "amd64"}}
  
# Створюємо блок для змінної середовища TELE_TOKEN із застосуванням Kubernetes secret
          env:
          - name: {{ .Values.secret.env }}
            valueFrom:
              secretKeyRef:
                key: {{ .Values.secret.key }}
                name: {{ .Values.secret.name }}
```

4. Запакування Helm

```shell
helm lint ./helm
```

5. Створення нового релізу
```shell
#перевірка версії GitHub
$ gh --version

#авторизація в GitHub
$ gh auth login  

? What account do you want to log into? => GitHub.com
? What is your preferred protocol for Git operations on this host? => HTTPS
? Authenticate Git with your GitHub credentials? => Yes
? How would you like to authenticate GitHub CLI?  => Login with a web browser
! First copy your one-time code: `49F0-D5D1`

Press Enter to open github.com in your browser... 

#створення релізу
$ gh release create

$ gh release edit v1.0.0 --draft=false

$ gh release list
```

8. Створення архіву `.tgz`

```shell
cd helm

helm package .
```

9. Додавання до релізу пакета
```shell
gh release upload v1.0.0 helm-0.1.0.tgz
```

10. Тестування чарту
```shell
$ helm install helm https://github.com/acvetochka/releases/download/v1.0.0/helm-0.1.0.tgz

$ helm ls
 ```
