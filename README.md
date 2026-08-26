# کلنگ‌دیتا (kolang-data)

مخزن داده‌های زبانی زبان برنامه‌نویسی کلنگ — **منبع حقیقی (Source of Truth)** برای داده‌های ویرایشگری زبان: متن راهنمای شناور (hover docs)، کلمات کلیدی، توابع از پیش‌تعریف‌شده، نوع‌های داده، ماژول‌ها، استثناها و فعل‌های امری.

این مخزن توسط هر دو ویرایشگر مصرف می‌شود:

| مصرف‌کننده | فایل مقصد | روش همگام‌سازی |
|---|---|---|
| **kolang-ide** (CodeMirror) | `languages/kolang/docs.js` (یک `Map` از شناسه → متن راهنما) | `scripts/sync-ide.sh` |
| **kolang-vscode** (TextMate/JSON) | `data/kolang-docs.json` (دسته‌بندی‌شده) | `scripts/sync-vscode.sh` |

> قاعدهٔ طلایی: هیچ‌وقت فایل‌های داده را مستقیماً در مخازن ویرایشگر ویرایش نکنید. هر تغییری را در این مخزن (`kolang-docs.json`) اعمال کنید و بعد اسکریپت همگام‌سازی همان‌جا را در هر دو مخزن اجرا کنید.

---

## ساختار `kolang-docs.json`

یک فایل JSON با متادیتا و دسته‌های زیر:

```json
{
  "_comment": "داده‌های زبانی کلنگ — منبع حقیقی برای ویرایشگرها (kolang-ide و kolang-vscode)",
  "_version": "0.0.1",
  "_sync": {
    "kolang-ide": "languages/kolang/docs.js (CodeMirror Map)",
    "kolang-vscode": "data/kolang-docs.json (TextMate/JSON)"
  },
  "keywords":   [["اگر", "دستور شرطی. ..."]],
  "builtins":   [["بنویس", "چاپ مقادیر به خروجی استاندارد. ..."]],
  "types":      [["صحیح", "نوع دادهٔ عدد صحیح و تابع تبدیل به آن. ..."]],
  "modules":    [["ریاضی", "ماژول ریاضی. ..."]],
  "exceptions": [["خطای‌صفر", "خطای تقسیم بر صفر (ZeroDivisionError). ..."]],
  "verbs":      [["برگردان", "بازگشت از تابع. ..."]],
  "literals":   [["درست", "مقدار بولی درست (True)."]]
}
```

هر دسته آرایه‌ای از جفت‌های `[شناسه، متن راهنما]` است. متن راهنماها کامل و پر از جزئیات فارسی هستند و از `docs.js` ویرایشگر kolang-ide گرفته شده‌اند.

- **`keywords`** — کلمات کلیدی زبان: کنترل جریان (`اگر`، `برای`، `بپا`)، تعریف (`تعریف`، `گونه`)، افعال ربطی (`باشد`، `نباشد`)، عملگرهای منطقی (`همچنین`، `یا`)، `خود`، `والد`، `پوشش` و…
- **`builtins`** — توابع فراخوانی‌پذیر از پیش‌تعریف‌شده: `طول`، `نوع`، `جمع`، `بازه`، `کانال`، `بازکردن` و…
- **`types`** — نوع‌های داده و سازنده‌های آن‌ها: `صحیح`، `متن`، `فهرست`، `گنجه` و…
- **`modules`** — نام ماژول‌ها: `ریاضی`، `زمان`، `جیسون`، `پایگاه‌داده` و…
- **`exceptions`** — کلاس‌های خطا: `خطا`، `خطای‌صفر`، `خطای‌مقدار` و…
- **`verbs`** — فعل‌های امری (دستورهای سطح-عبارتی): `بنویس`، `برگردان`، `بساز`، `بده`، `بگیر` و…
- **`literals`** — مقادیر ثابت: `درست`، `غلط`، `تهی`

**نکتهٔ نیم‌فاصله:** شناسه‌های ترکیبی حتماً با نیم‌فاصلهٔ (ZWNJ، `U+200C`) دقیق نگهداری شوند — مثل `خطای‌صفر`، `بسته‌است`، `حذف‌کن`، `سیستم‌عامل`. چون شناسه‌ها دقیقاً همان‌طور که در کد ظاهر می‌شوند باید مطابقت کنند.

## همگام‌سازی

### به kolang-ide (فایل `docs.js`)

```bash
./scripts/sync-ide.sh > ../kolang-ide/languages/kolang/docs.js
```

اسکریپت `kolang-docs.json` را می‌خواند و یک ماژول ES با `export const kolangDocs = new Map([…])` به خروجی استاندارد می‌فرستد؛ خروجی دقیقاً با قالب موجود در kolang-ide هم‌خوانی دارد.

### به kolang-vscode (فایل `data/kolang-docs.json`)

```bash
./scripts/sync-vscode.sh
```

اسکریپت به‌صورت پیش‌فرض به `../kolang-vscode/data/kolang-docs.json` می‌نویسد (یا با آرگومان اول مسیر دلخواه بدهید). از آن‌جا که `extension.js` ویرایشگر vscode دسته‌های `keywords / functions / types / modules / exceptions / literals / snippets` را می‌خواند، اسکریپت این نگاشت را اعمال می‌کند:

```
functions = builtins + verbs
```

بخش `snippets` در فایل مقصد (اگر از قبل وجود داشته باشد) دست‌نخورده حفظ می‌شود، چون قالب‌های کد جزو دادهٔ شناسه‌ها نیستند.

## افزودن کلمه کلیدی یا تابع جدید

۱. `kolang-docs.json` را ویرایش کنید: شناسه و متن راهنمای فارسی کامل را به دستهٔ درست اضافه کنید.
۲. همگام‌سازی را در هر دو مخزن اجرا کنید:

```bash
./scripts/sync-ide.sh > ../kolang-ide/languages/kolang/docs.js
./scripts/sync-vscode.sh
```

۳. در مخزن kolang-data تغییر را commit کنید و بعد (در صورت نیاز) در مخازن ویرایشگر هم.

## نسخه

**0.0.1** — تغییرات در [CHANGELOG.md](CHANGELOG.md).

## مجوز

[MIT](LICENSE) — © ۲۰۲۶ FaraliDev و مشارکت‌کنندگان.

---

## English Summary

**kolang-data** is the canonical source-of-truth repo for Kolang language editor data (hover docs, keywords, builtins, types, modules, exceptions, verbs). It is consumed by both editors:

- **kolang-ide** (CodeMirror): run `scripts/sync-ide.sh > ../kolang-ide/languages/kolang/docs.js` to regenerate the `kolangDocs` `Map` module.
- **kolang-vscode** (TextMate/JSON): run `scripts/sync-vscode.sh` to refresh `data/kolang-docs.json` (the script maps canonical `builtins`+`verbs` → vscode `functions` and preserves existing `snippets`).

Edit `kolang-docs.json` only; never edit generated data inside the editor repos. Keep ZWNJ (`U+200C`) intact in compound identifiers (e.g. `خطای‌صفر`, `بسته‌است`). Version: **0.0.1**. License: **MIT**.