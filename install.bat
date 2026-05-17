@echo off
chcp 65001 >nul
echo ==========================================
echo   CowAgent 自定义主题安装脚本
echo ==========================================
echo.

set "COW_PATH=C:\Users\19521\chatgpt-on-wechat"
set "BACKUP_DIR=%COW_PATH%\custom_backup"

:: 检查目录是否存在
if not exist "%COW_PATH%" (
    echo [错误] 未找到 CowAgent 目录: %COW_PATH%
    echo 请确保已正确安装 CowAgent。
    pause
    exit /b 1
)

echo [1/4] 正在备份原始文件...
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: 备份原始文件
if exist "%COW_PATH%\channel\web\chat.html" (
    copy "%COW_PATH%\channel\web\chat.html" "%BACKUP_DIR%\chat.html.bak" /Y >nul
    echo   ✓ 已备份 chat.html
)
if exist "%COW_PATH%\channel\web\static\css\console.css" (
    copy "%COW_PATH%\channel\web\static\css\console.css" "%BACKUP_DIR%\console.css.bak" /Y >nul
    echo   ✓ 已备份 console.css
)

echo.
echo [2/4] 正在下载自定义主题文件...

:: 使用 PowerShell 下载文件
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/yzl-eng/yzl-eng/main/cow-theme/chat.html' -OutFile '%COW_PATH%\channel\web\chat.html' -UseBasicParsing" 2>nul
if %errorlevel% neq 0 (
    echo [错误] 下载 chat.html 失败，请检查网络连接。
    pause
    exit /b 1
)
echo   ✓ 已下载 chat.html

powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/yzl-eng/yzl-eng/main/cow-theme/console.css' -OutFile '%COW_PATH%\channel\web\static\css\console.css' -UseBasicParsing" 2>nul
if %errorlevel% neq 0 (
    echo [错误] 下载 console.css 失败，请检查网络连接。
    pause
    exit /b 1
)
echo   ✓ 已下载 console.css

echo.
echo [3/4] 正在下载背景图片和头像...

:: 创建静态资源目录
if not exist "%COW_PATH%\channel\web\static" mkdir "%COW_PATH%\channel\web\static"

:: 下载背景图片
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/yzl-eng/yzl-eng/main/cow-theme/chat-bg.jpg' -OutFile '%COW_PATH%\channel\web\static\chat-bg.jpg' -UseBasicParsing" 2>nul
if %errorlevel% equ 0 (
    echo   ✓ 已下载聊天背景图片
) else (
    echo   ! 背景图片下载失败（可选）
)

:: 下载头像
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/yzl-eng/yzl-eng/main/cow-theme/logo.jpg' -OutFile '%COW_PATH%\channel\web\static\logo.jpg' -UseBasicParsing" 2>nul
if %errorlevel% equ 0 (
    echo   ✓ 已下载头像图片
) else (
    echo   ! 头像图片下载失败（可选）
)

echo.
echo [4/4] 安装完成！
echo.
echo ==========================================
echo   ✨ 主题安装成功！
echo ==========================================
echo.
echo 功能特性：
echo   • 左侧边栏白色主题
echo   • 聊天界面背景图片
echo   • 自定义头像
echo   • 支持亮色/暗色模式切换
echo.
echo 备份文件保存在: %BACKUP_DIR%
echo.
echo 请刷新浏览器页面查看效果。
echo.
pause
