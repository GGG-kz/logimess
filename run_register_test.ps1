# === Конфигурация ===
$phone = "77001112236"
$name = "Азамат"
$password = "123456"
$registerUrl = "http://127.0.0.1:8000/register"
$loginUrl = "http://127.0.0.1:8000/login"
$meUrl = "http://127.0.0.1:8000/me"

# === Шаг 1: Регистрация ===
$bodyRegister = @{
    phone = $phone
    name = $name
    password = $password
} | ConvertTo-Json -Depth 2 -Compress

Write-Host "🔄 Регистрируем пользователя..."
try {
    $response = Invoke-RestMethod -Uri $registerUrl -Method POST -Body $bodyRegister -ContentType "application/json"
    Write-Host "✅ Успешно зарегистрирован: $($response.name)"
} catch {
    Write-Warning "⚠️ Ошибка при регистрации: $($_.Exception.Response.StatusCode)"
    return
}

# === Шаг 2: Логин ===
$bodyLogin = @{
    phone = $phone
    password = $password
} | ConvertTo-Json -Compress

Write-Host "`n🔐 Логинимся..."
try {
    $loginResp = Invoke-RestMethod -Uri $loginUrl -Method POST -Body $bodyLogin -ContentType "application/json"
    $token = $loginResp.access_token
    Write-Host "✅ Токен получен: $($token.Substring(0, 20))..."
} catch {
    Write-Error "❌ Ошибка при логине"
    return
}

# === Шаг 3: Получение информации о пользователе ===
$headers = @{
    Authorization = "Bearer $token"
}

Write-Host "`n🔎 Получаем информацию о пользователе..."
try {
    $user = Invoke-RestMethod -Uri $meUrl -Method GET -Headers $headers
    Write-Host "👤 Пользователь: $($user.name) — $($user.phone) — роль: $($user.role)"
} catch {
    Write-Error "❌ Ошибка при получении информации о пользователе"
}