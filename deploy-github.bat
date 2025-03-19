@echo off
echo ========================================
echo Подготовка к загрузке на GitHub...
echo ========================================
echo.

:: Проверка наличия Git
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ОШИБКА: Git не установлен!
    echo Пожалуйста, установите Git с сайта https://git-scm.com/
    echo.
    pause
    exit /b 1
)

:: Проверка наличия Node.js
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ОШИБКА: Node.js не установлен!
    echo Пожалуйста, установите Node.js с сайта https://nodejs.org/
    echo.
    pause
    exit /b 1
)

:: Сборка проекта
echo Сборка проекта...
call npm run build
if %ERRORLEVEL% neq 0 (
    echo ОШИБКА: Не удалось собрать проект!
    echo.
    pause
    exit /b 1
)
echo.
echo Проект успешно собран!
echo.

:: Инициализация Git (если еще не инициализирован)
if not exist .git (
    echo Инициализация Git репозитория...
    git init
    echo.
)

:: Добавление всех файлов
echo Добавление файлов в Git...
git add .
echo.

:: Создание коммита
echo Создание коммита...
git commit -m "Обновление сайта"
echo.

:: Запрос URL репозитория
set /p REPO_URL=Введите URL вашего GitHub репозитория (например, https://github.com/username/repo.git): 

:: Добавление удаленного репозитория (если еще не добавлен)
git remote -v | findstr "%REPO_URL%" >nul
if %ERRORLEVEL% neq 0 (
    git remote add origin %REPO_URL%
)

:: Отправка изменений
echo Отправка изменений на GitHub...
git push -u origin main
if %ERRORLEVEL% neq 0 (
    echo ОШИБКА: Не удалось отправить изменения на GitHub!
    echo Проверьте:
    echo 1. Правильность URL репозитория
    echo 2. Наличие доступа к репозиторию
    echo 3. Настройки GitHub Pages в настройках репозитория
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo Инструкции по настройке GitHub Pages:
echo ========================================
echo.
echo 1. Перейдите в настройки вашего репозитория на GitHub
echo 2. Найдите раздел "Pages" в левом меню
echo 3. В разделе "Source" выберите "GitHub Actions"
echo 4. Дождитесь завершения автоматического развертывания
echo 5. Ваш сайт будет доступен по адресу:
echo    https://[ваш-username].github.io/[имя-репозитория]
echo.
echo ========================================
echo Готово! Сайт будет автоматически развернут на GitHub Pages
echo ========================================
echo.
pause 