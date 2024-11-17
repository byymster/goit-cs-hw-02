#!/bin/bash

# Файл з URL вебсайтів
websites_file="websites.csv"

# Назва файлу логів
log_file="website_status.log"

# Очищення файлу логів перед записом нових результатів
> $log_file

# Перевірка доступності кожного сайту
while IFS= read -r website || [ -n "$website" ]
do
    # Пропуск порожніх рядків
    if [ -z "$website" ]; then
        continue
    fi
    
    response=$(curl -Ls -o /dev/null -w "%{http_code} %{url_effective}" $website)
    http_code=$(echo $response | awk '{print $1}')
    final_url=$(echo $response | awk '{print $2}')
    
    # Перевірка статус-коду відповіді
    if [ $http_code -eq 200 ]; then
        echo "$website is UP, final URL: $final_url" | tee -a $log_file
    else
        echo "$website is DOWN, final URL: $final_url" | tee -a $log_file
    fi
done < "$websites_file"

echo "Результати записано у файл $log_file"