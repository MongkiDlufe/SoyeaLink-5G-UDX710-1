# SoyeaLink-5G-UDX710
UDX710系列之5G手机壳开源Web正式登场
> ⭐ **如果觉得这个项目有用，请点个Star支持一下！** 辛苦肝了一周的后台，您的支持是我最大的动力！
> 本项目完全开源免费，如果你喜欢这个项目的话，也可以请我喝一杯咖啡~
> 

因为这个适配手机壳的一键刷机包

是基于黑衣大佬原破解壳刷机后进行更新glib适配和前端更新

以及小陈同学对**驱动**的开放

**所以大家打钱就打他们两就好了哈**

##  致谢

| 贡献者   | 贡献内容       | 说明                |
| -------- | -------------- | ------------------- |
| 黑衣大佬 | 手机壳基础刷机 | 黑衣剑士一桐人@酷安 |
| 小陈同学 | c驱动          | 小陈同学@酷安       |
| AI       | 前后台代码改进 | deepseek/chatgpt    |
|          |                |                     |
|          |                |                     |

## 🛡️ 一键刷机包能用就用，也算贡献者哈，各位佬们搞得不开心了。。。。

# SoyeaLink-5G-UDX710 - 5G手机壳全功能轻量化Web管理系统

![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-aarch64--linux-red)

> 一套基于Web的5G手机壳设备管理系统，专为紫光展锐UDX710/春藤510系列嵌入式Linux系统(aarch64架构)设计。

## 🚀 项目亮点

- ✅ **全中文Web界面** - 响应式设计，支持PC/手机/平板
- ✅ **20+项核心功能** - 涵盖网络、系统、电源、通信等各方面
- ✅ **一键部署** - 简化刷机流程，快速上手
- ✅ **GLIBC兼容** - 自带运行时库，无需担心系统版本
- ✅ **轻量化** - 3Mb文件总体积

## 📋 核心功能总览

| 功能模块 | 主要特性 | 适用场景 |
|---------|---------|---------|
| **🔧 系统监控** | CPU/内存占用、芯片温度、实时状态 | 系统诊断、故障排查 |
| **📶 网络管理** | 锁频锁网、运营商锁定、频段选择 | 网络优化、信号增强 |
| **📱 SIM卡管理** | 已去掉，5G手机壳没必要 |
| **🌐 流量控制** | 实时流量统计、月度报表、限额设置 | 流量管控、热点共享 |
| **🔋 电源管理** | 充电控制、电量阈值、电池保护 | 延长电池寿命 |
| **📡 WiFi管理** | SSID/密码设置、客户端管理、信道选择 | 移动热点、共享网络 |
| **💬 短信中心** | 收发短信、远程控制、套餐查询 | 运营商业务管理 |
| **⚙️ 高级功能** | AT指令终端、Web Shell、LED控制 | 开发者调试、高级玩家 |


## 🛠️ 快速开始

### 环境要求

- **设备**: 紫光展锐UDX710/春藤510系列5G手机壳
- **系统**: 嵌入式Linux (aarch64架构)
- **网络**: ADB连接或SSH访问权限

### 一键部署步骤

1. **准备工作**
   ```bash
   # 克隆项目
   git clone https://github.com/Daniel-Hwang/SoyeaLink-5G-UDX710.git
   cd SoyeaLink-5G-UDX710
   ```

3. **编译前端界面**
   ```bash
   # 返回项目根目录
   cd ..
   
   # 安装Node.js依赖
   npm install
   
   # 构建前端资源
   npm run build
   
   # 将构建文件复制到部署目录
   cp -r dist/* 44944/
   ```

4. **准备部署包**
   ```bash
   # 确保44944目录包含以下文件：
   # server         - 后端服务
   # index.html     - 前端页面
   # assets/        - 前端资源
   # libs/          - GLIBC运行时库
   # start.sh       - 启动脚本
   # vnstat/vnstatd - 流量统计工具
   ```

5. **Windows一键刷机**
   - 连接设备到电脑，确保ADB调试已开启
   - 双击运行 `20251212手机壳5G-UDX710.bat`
   - 根据菜单选择部署模式（直接选1，即可）
   - 等待设备重启完成

### 手动部署

如果您想手动部署到设备：

```bash
# 1. 推送文件到设备
adb push 44944 /home/root/

# 2. 设置权限
adb shell chmod +x /home/root/44944/start.sh
adb shell chmod +x /home/root/44944/server
adb shell chmod +x /home/root/44944/libs/ld-linux-aarch64.so.1

# 3. 修改启动脚本（可选）
# 编辑设备上的 /home/root/kk.sh 或 /home/root/loader.sh 或 x.sh 或 /etc/init.d/hostname.sh
# 添加: ./libs/ld-linux-aarch64.so.1 --library-path ./libs ./server &

# 4. 重启设备
adb shell reboot
```

## 📁 项目结构

```
SoyeaLink-5G-UDX710/
├── 44944/                    # 部署包目录
│   ├── server              # 后端服务程序
│   ├── start.sh           # 启动脚本
│   ├── index.html         # 前端入口
│   ├── assets/            # 前端资源文件
│   ├── libs/              # GLIBC运行时库
│   └── vnstat/           # 流量统计工具
├── 20251212手机壳5G-UDX710.bat           # Windows部署脚本
├── README.md           # 项目说明文档
└── LICENSE             # 开源许可证
```

## 🔧 技术架构

### 后端架构
- **语言**: C语言
- **Web服务器**: Mongoose嵌入式HTTP服务器
- **通信协议**: HTTP RESTful API + WebSocket
- **系统接口**: D-Bus通信、ioctl系统调用、AT指令
- **编译方式**: 交叉编译 (aarch64-linux-gnu-gcc)
- **GLIBC兼容**: 自带运行时库，版本无关

### 前端架构
- **框架**: Vue 3 + TypeScript
- **构建工具**: Vite
- **UI组件**: Element Plus
- **图表库**: ECharts
- **网络请求**: Axios
- **样式**: SCSS + CSS变量

### 通信流程
```
前端(Vue) <--HTTP/WebSocket--> 后端(C) <--D-Bus/AT命令--> 系统服务
                        ↳ 数据库(sqlite)   ↳ 网络配置
                        ↳ 配置文件         ↳ 硬件控制
```

## 🌐 访问方式

部署完成后，通过以下方式访问：

1. **局域网访问**:
   ```
   http://设备IP:44944
   ```

2. **默认凭证**:

3. **支持的浏览器**:
   - Chrome 90+
   - Firefox 88+
   - Edge 90+
   - Safari 14+

## 🔄 开发指南

### 后端开发
```bash
# 1. 修改源代码
cd src

# 2. 编译测试
make clean && make

# 3. 本地测试（需要qemu-aarch64）
qemu-aarch64 -L ./libs build/ofono-server
```

### 前端开发
```bash
# 1. 安装依赖
cd web
npm install
npm build
```

### API文档
后端提供以下主要API接口：

```http
GET    /api/system/info      # 系统信息
GET    /api/network/status   # 网络状态
POST   /api/network/lock     # 锁频锁网
GET    /api/sms/list         # 短信列表
POST   /api/sms/send         # 发送短信
GET    /api/charge/status    # 充电状态
POST   /api/charge/set       # 充电设置
```

详细API

## 🤝 贡献指南

欢迎提交Issue和Pull Request！参与贡献前请阅读：

1. **代码规范**
   - C语言遵循Linux内核编码风格
   - JavaScript/TypeScript使用ESLint规范
   - 提交前请运行代码检查

2. **提交信息格式**
   ```
   type(scope): description
   [body]
   ```
   - type: feat/fix/docs/style/refactor/test
   - scope: frontend/backend/docs

3. **开发流程**
   ```bash
   # 1. Fork项目
   # 2. 创建特性分支
   git checkout -b feature/your-feature
   # 3. 提交更改
   git commit -m "feat(backend): add new feature"
   # 4. 推送到分支
   git push origin feature/your-feature
   # 5. 创建Pull Request
   ```

## 📊 性能指标

| 指标 | 数值 | 说明 |
|------|------|------|
| 启动时间 | < 30s | 从执行到服务可用 |
| 内存占用 | ~15MB | 常驻内存大小 |
| CPU占用 | < 1% | 空闲状态下 |
| 响应时间 | < 50ms | API平均响应 |
| 并发连接 | 100+ | 支持同时在线 |

## 🛡️ 安全说明

### 已实施的安全措施
- ✅ HTTP支持
- ✅ 会话管理
- ✅ API请求验证?
- ✅ SQL注入防护?
- ✅ XSS攻击防护?
- ✅ CSRF令牌保护?

### 安全建议
1. **修改默认密码**
2.  **定期更新** - 关注安全更新
3. **网络隔离** - 避免暴露到公网

## 📝 更新日志

### v1.0.0 (2025-11)
- ✅ 初始版本发布
- ✅ 20+项核心功能
- ✅ 完整的前后端代码
- ✅ 一键部署脚本
- ✅ 详细使用文档

### 计划中的功能
- 🔄 自动基站优化
- 🔄 信号热图展示
- 🔄 多设备协同管理
- 🔄 插件系统支持
- 🔄 更多语言支持

## ❓ 常见问题

### Q1: 设备连接不上怎么办？
**A**: 检查以下事项：
1. 设备ADB调试是否开启
2. USB线是否正常
3. 驱动程序是否正确安装
4. 设备是否已root

### Q2: 编译失败怎么解决？
**A**: 确保已安装交叉编译工具链：
```bash
sudo apt install gcc-aarch64-linux-gnu
```

### Q3: 服务启动后无法访问？
**A**: 
1. 检查端口是否被占用：`netstat -tlnp | grep 44944`
2. 查看日志文件：
3. 确认防火墙设置

## 📞 技术支持

- **GitHub Issues**: [提交问题](https://github.com/Daniel-Hwang/SoyeaLink-5G-UDX710/issues)
- **讨论区**: [GitHub Discussions](https://github.com/Daniel-Hwang/SoyeaLink-5G-UDX710/discussions)
- **邮箱**: 请通过GitHub Issues联系

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者、测试者和用户！

特别感谢：
- **酷安小陈** 
- **酷安水遍** 
- **所有Star本项目的朋友** - 你们的支持是继续开发的动力！

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## ⭐ 支持项目

如果这个项目对您有帮助，请考虑：

1. **给个Star** ⭐ - 让更多人看到这个项目
2. **分享给朋友** 👥 - 帮助更多5G壳用户
3. **提交反馈** 💡 - 帮助我们改进
4. **参与开发** 🔧 - 一起完善功能

---

**注意**: 本项目为开源项目，作者不对使用本软件造成的任何损失负责。请遵守当地法律法规，合法使用网络设备。

*UDX710系列开源web代码终结了这场紫光展锐UDX710/紫藤510等各种藤竞赛*
*让我们一起打造最强大的5G手机壳管理平台！* 🚀
