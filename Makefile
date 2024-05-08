REGISTRY := ghcr.io/acvetochka
VERSION := $($(shell git describe --tags --abbrev=0 --always)-$(shell git rev-parse --short HEAD))
ifndef VERSION
    VERSION := 1.0.1
endif

APP := $(notdir $(REPO))

TARGETOS := $(OS)
TARGETARCH := $(ARCH)

format: 
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

build: format get
	echo "Building binary for platform $(TARGETOS) on $(TARGETARCH)"
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o telbot -ldflags "-X=github.com/acvetochka/telbot/cmd.appVersion=${VERSION}"

linux:
	echo "Building binary for Linux on amd64"
	GOOS=linux GOARCH=amd64 go build -v -o telbot -ldflags "-X=github.com/acvetochka/telbot/cmd.appVersion=${VERSION}"

arm:
	echo "Building binary for Linux on arm64"
	GOOS=linux GOARCH=arm64 go build -v -o telbot -ldflags "-X=github.com/acvetochka/telbot/cmd.appVersion=${VERSION}"

macos:
	echo "Building binary for macOS on amd64"
	GOOS=darwin GOARCH=amd64 go build -v -o telbot -ldflags "-X=github.com/acvetochka/telbot/cmd.appVersion=${VERSION}"

windows:
	echo "Building binary for Windows on amd64"
	GOOS=windows GOARCH=amd64 go build -v -o telbot -ldflags "-X=github.com/acvetochka/telbot/cmd.appVersion=${VERSION}"

image:
	echo "Building Docker image for platform $(TARGETOS) on $(TARGETARCH)"
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

push:
	echo "Pushing Docker image for platform $(TARGETOS) on $(TARGETARCH)"
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

clean:
	@rm -f telbot
