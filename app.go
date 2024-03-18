package main

import (
	"context"
	"fmt"
	"os"

	"github.com/skye-z/auto-mooc/service"
	"github.com/skye-z/auto-mooc/util"
)

type App struct {
	ctx context.Context
}

func NewApp() *App {
	return &App{}
}

func (a *App) startup(ctx context.Context) {
	a.ctx = ctx

	util.InitConfig()
	util.Set("basic.workspace", a.UpdateConfigPath())
	router := service.InitNoPageRouter()
	service.RunRouter(router)
}

func (a *App) UpdateConfigPath() string {
	// 获取用户配置文件目录
	configDir, _ := os.UserConfigDir()
	configDir = fmt.Sprintf("%s/AutoMooc", configDir)
	// 判断应用目录是否存在
	if _, err := os.Stat(configDir); os.IsNotExist(err) {
		// 目录不存在,创建目录
		os.Mkdir(configDir, os.ModePerm)
	}
	return configDir
}
