#!/bin/bash

GO_PATH="/usr/lib/go"
GO_VERSION="go1.22.3"
TARGET_ARCH="$(uname -m)"

if [ "$(id -u)" -ne 0 ]; then
    echo "Run this as root idiot!"
    exit 1
fi

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
mkdir -p $GO_PATH

wget "https://go.dev/dl/$FILENAME"
tar -xvf "$FILENAME" -C /usr/lib
rm -f "$FILENAME"

$GO_PATH/bin/go env -w GOPATH="$HOME/.go"
