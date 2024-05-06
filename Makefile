APP=$(shell basename $(shell git remote get-url origin))
REGESTRY := ghcr.io/acvetochka
# VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
# VERSION=1.0.0
VERSION=$(shell git describe --tags --abbrev=0 --always)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64
# $(shell dpkg --print-archetecture)

format: 
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

build: format get
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=amd64 go build -v -o telbot -ldflags "-X="github.com/acvetochka/telbot/cmd.appVersion=${VERSION}

linux:
	GOOS=linux GOARCH=amd64 go build -v -o telbot -ldflags "-X="github.com/acvetochka/telbot/cmd.appVersion=${VERSION}

arm:
	GOOS=linux GOARCH=arm64 go build -v -o telbot -ldflags "-X="github.com/acvetochka/telbot/cmd.appVersion=${VERSION}

macos:
	GOOS=darwin GOARCH=amd64 go build -v -o telbot -ldflags "-X="github.com/acvetochka/telbot/cmd.appVersion=${VERSION}

windows:
	GOOS=windows GOARCH=amd64 go build -v -o telbot -ldflags "-X="github.com/acvetochka/telbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGESTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGESTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	@rm -f telbot