#!/bin/bash

GO_PATH="/opt/cybertools/golang/go"
GO_VERSION="go1.22.3"
TARGET_ARCH="$(uname -m)"

if [ "$TARGET_ARCH" == "aarch64" ]; then
    FILE_ARCH="arm64"
elif [ "$TARGET_ARCH" == "armv6l" ] || [ "$TARGET_ARCH" == "armv7l" ]; then
    FILE_ARCH="armv6l"
else
    echo "$TARGET_ARCH not supported yet!"
    exit 1
fi

FILENAME="$GO_VERSION.linux-$FILE_ARCH.tar.gz"

rm -rf $GO_PATH
wget "https://go.dev/dl/$FILENAME"
tar -xvf "$FILENAME"
rm -f "$FILENAME"

$GO_PATH/bin/go env -w GOPATH="$GO_PATH/.go"
