# تغییرات

## 0.0.1 — ۲۰۲۶-۰۸-۲۶

نسخه اولیه

- مخزن منبع حقیقی داده‌های زبانی کلنگ ساخته شد.
- `kolang-docs.json`: همهٔ ۱۰۳ ورودی مستندات از kolang-ide (`docs.js`) با متن کامل فارسی، دسته‌بندی‌شده در `keywords`، `builtins`، `types`، `modules`، `exceptions`، `verbs` و `literals`.
- اسکریپت‌های همگام‌سازی `scripts/sync-ide.sh` و `scripts/sync-vscode.sh` اضافه شد.
- `snippets.json`: منبع حقیقی قطعه‌کدها (۲۴ قطعه‌کد) با فرمت VS Code — جایگزین منبع‌های قدیمی (آرایهٔ `SNIPPETS` در `kolang/docs/kolang-language.js` و `kolang-vscode/snippets/kolang.json`). اسکریپت دستی `scripts/sync-snippets.sh` اضافه شد؛ همگام‌سازی خودکار هنگام build در kolang-vscode (از طریق `scripts/fetch-data.js`).