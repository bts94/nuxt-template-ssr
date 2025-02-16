#!/bin/bash

# Набір допустимих символів
CHARS="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
RANDOM_STR=""

# Генеруємо 7 випадкових символів
for i in {1..7}; do
  RANDOM_STR+="${CHARS:RANDOM%${#CHARS}:1}"
done


BRANCH_NAME="feature/${RANDOM_STR}"
echo "Використовуємо ім'я гілки: ${BRANCH_NAME}"

# Перевірка наявності папок components та stores у src/assets
if [ -d "src/assets/components" ] && [ -d "src/assets/stores" ]; then
    echo "Папки components та stores знайдено у src/assets. Видаляємо їх та копіюємо в src/server."
    rm -rf src/assets/components
    rm -rf src/assets/stores
    cp -r src/components src/server/
    cp -r src/stores src/server/
else
    echo "Папки components та stores НЕ знайдено у src/assets. Видаляємо їх з src/server (якщо є) та копіюємо в src/assets."
    rm -rf src/server/components
    rm -rf src/server/stores
    cp -r src/components src/assets/
    cp -r src/stores src/assets/
fi

# Робота з git
echo "Створення нової гілки: ${BRANCH_NAME}"
git checkout -b "${BRANCH_NAME}"

echo "Додаємо зміни до git..."
git add .

echo "Комітуємо зміни з повідомленням: ${RANDOM_STR}"
git commit -m "${RANDOM_STR}"

echo "Пушимо гілку на origin..."
git push origin "${BRANCH_NAME}"
