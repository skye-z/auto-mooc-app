#!/usr/bin/env bash

echo "Start packaging..."

go mod download
go mod tidy

rm -rf ./out
mkdir ./out
cp LICENSE ./out/LICENSE

build_mac(){
    wails build -clean -platform darwin/$1 -ldflags '-s -w'
    mv ./build/bin/auto-mooc.app ./out/AutoMooc.app
    cd out
    tar -zcf auto-mooc-darwin-$1.tar.gz AutoMooc.app LICENSE
    rm -rf ./AutoMooc.app
    cd ../
}

build_win(){
    wails build -clean -platform windows/$1 -ldflags '-s -w'
    mv ./build/bin/auto-mooc.exe ./out/AutoMooc.exe
    cd out
    zip -q auto-mooc-windows-$1.zip AutoMooc.exe LICENSE
    rm -rf ./auto-mooc.exe
    cd ../
}

echo "[1] MacOS from amd64"
build_mac amd64
echo "[2] MacOS from arm64"
build_mac  arm64
echo "[3] Windows from amd64"
build_win amd64
echo "[4] Windows from arm64"
build_win arm64