batch
@echo off
setlocal enabledelayedexpansion

:: ============================================
:: UDX710 服务部署工具
:: 作者: 酷安 不知道是谁 可能是外星人 感谢小陈和minikano，招AI操作师
:: 版本: 1.2
:: ============================================

:MAIN_MENU
cls
echo ============================================
echo    UDX710 服务部署工具
echo ============================================
echo.

:: 检测ADB连接
call :CHECK_ADB
if "%ADB_STATUS%"=="DISCONNECTED" (
    echo [错误] 未检测到ADB设备连接！
    echo.
    echo 请确保：
    echo 1. 设备已通过USB连接
    echo 2. USB调试已启用
    echo 3. 设备已授权此计算机
    echo.
    pause
    goto MAIN_MENU
)

echo [状态] 设备已连接
echo.

:: 显示选项菜单
echo 请选择部署模式：
echo.
echo  1. 保留9527后台，添加44944服务（推荐）
echo  2. 清理旧服务，重新部署44944服务
echo  3. 仅推送文件，不修改启动脚本
echo  4. 退出
echo.
echo ============================================

choice /c 1234 /n /m "请选择 (1-4): "
set "SELECTION=%ERRORLEVEL%"

if "%SELECTION%"=="1" goto DEPLOY_WITH_9527
if "%SELECTION%"=="2" goto DEPLOY_WITHOUT_9527
if "%SELECTION%"=="3" goto DEPLOY_FILES_ONLY
if "%SELECTION%"=="4" exit /b 0
goto:home

:: ============================================
:: 功能模块
:: ============================================

:CHECK_ADB
:: 检测ADB设备连接
adb devices | findstr "device$" > nul
if %ERRORLEVEL% equ 0 (
    set "ADB_STATUS=CONNECTED"
) else (
    set "ADB_STATUS=DISCONNECTED"
)
exit /b 0

:VERIFY_PUSH
:: 验证文件推送是否成功
echo [信息] 验证文件推送...
adb shell "find /home/root/44944/start.sh" > nul
if %ERRORLEVEL% neq 0 (
    echo [成功] 文件推送验证通过
) else (
    echo [错误] 文件推送失败！
    pause
    exit /b 1
)
exit /b 0

:SET_PERMISSIONS
:: 设置合理的文件权限
echo [信息] 设置文件权限...
adb shell "chmod 755 /home/root/44944/start.sh"
adb shell "chmod 755 /home/root/44944/server"
adb shell "chmod 755 /home/root/44944/vnstat"
adb shell "chmod 755 /home/root/44944/vnstatd"
adb shell "chmod 755 /home/root/44944/vnstatd.conf"
adb shell "chmod 755 /home/root/44944/dist/index.html"
:: adb shell "find /home/root/44944/assets -type f -exec chmod 755 {} \; 2>/dev/null || true"
echo [成功] 权限设置完成
exit /b 0

:: ============================================
:: 部署选项
:: ============================================

:DEPLOY_WITH_9527
echo.
echo [信息] 模式：保留9527后台，添加44944服务
echo.

:: 1. 重新挂载为读写
echo [步骤1] 重新挂载根目录为读写
adb shell "mount -o remount,rw /" || (
    echo [错误] 挂载失败！请检查root权限
    pause
    goto MAIN_MENU
)

:: 2. 推送44944文件夹
echo [步骤2] 推送44944文件夹到设备
adb push .\44944 /home/root/ || (
    echo [错误] 文件推送失败！
    pause
    goto MAIN_MENU
)

:: 3. 验证推送
:: call :VERIFY_PUSH

:: 4. 修改hostname.sh启动脚本（更安全的方式）备份，查找启动，添加
echo [步骤3] 修改启动脚本hostname.sh
adb shell "cp /etc/init.d/hostname.sh /etc/init.d/hostname.sh.bak 2>/dev/null || true"

:: 检查是否已hostname.sh存在44944启动命令
::先删除可能存在的旧命令（避免重复）
adb shell "sed -i '/\/home\/root\/44944\/start\.sh/d' /etc/init.d/hostname.sh 2>/dev/null"
adb shell "sed -i '/\/home\/root\/6677\/start\.sh/d' /etc/init.d/hostname.sh 2>/dev/null"
adb shell "echo '' >> /etc/init.d/hostname.sh"
adb shell "echo '# 44944服务 - 添加时间: $(date)' >> /etc/init.d/hostname.sh"
adb shell "echo '/home/root/44944/start.sh &' >> /etc/init.d/hostname.sh"

:: 5. 设置权限
call :SET_PERMISSIONS

:: 6. 询问是否重启
echo.S
choice /c YN /n /m "是否立即重启设备？(Y/N): "
if %ERRORLEVEL% equ 1 (
    echo [信息] 正在重启设备...
    adb shell reboot
    echo [成功] 设备重启中，请等待...
) else (
    echo [信息] 跳过重启，请手动重启使更改生效
)

pause
goto MAIN_MENU




:without9527
adb shell mount -o remount,rw /
adb shell rm -rf /home/root/9527
adb shell rm -rf /home/root/51886
adb shell rm -rf /home/root/51887
adb shell rm -rf /home/root/51888
adb shell rm -rf /home/root/8080
adb shell rm -rf /home/root/ShellCrash

adb push .\44944 /home/root/
adb shell "sed -i '/^[[:space:]]*fi[[:space:]]*$/,/^[[:space:]]*sleep 22[[:space:]]*$/ { /^[[:space:]]*fi[[:space:]]*$/!{ /^[[:space:]]*sleep 22[[:space:]]*$/!d; }; }' /home/root/loader.sh"
adb shell "sed -i '/sleep 22/i /home/root/busybox-aarch64 crond -b -l 0 -L /tmp/crond.log \&' /home/root/loader.sh"
adb shell "sed -i '/sleep 22/i /home/root/44944/start.sh \&' /home/root/loader.sh"
adb shell "sed -i '/sleep 22/i /home/root/ttyd/start.sh \&' /home/root/loader.sh"
adb shell "find /home/root -name '*.sh' -type f -exec chmod 777 {} +"
adb shell reboot
echo ok
pause
goto:home
