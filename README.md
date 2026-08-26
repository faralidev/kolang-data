# کلنگ‌دیتا (kolang-data)

مخزن داده‌های زبانی زبان برنامه‌نویسی کلنگ — **منبع حقیقی (Source of Truth)** برای داده‌های ویرایشگری زبان: متن راهنمای شناور (hover docs)، کلمات کلیدی، توابع از پیش‌تعریف‌شده، نوع‌های داده، ماژول‌ها، استثناها، فعل‌های امری و قطعه‌کدها (snippets).

این مخزن توسط ویرایشگرهای زیر مصرف می‌شود:

| مصرف‌کننده | فایل مقصد | روش همگام‌سازی |
|---|---|---|
| **kolang-web** (CodeMirror 6) | hover docs درون‌برنامه‌ای | به‌زودی (TBD) |
| **kolang-mobile** (React Native) | مستندات مرجع درون‌برنامه‌ای | به‌زودی (TBD) |
| **kolang-vscode** (TextMate/JSON) | `data/kolang-docs.json` (دسته‌بندی‌شده) | `scripts/sync-vscode.sh` |
| **kolang-vscode** (snippets) | `snippets/kolang.json` | `scripts/sync-snippets.sh` (دستی) یا `scripts/fetch-data.js` هنگام build |

> قاعدهٔ طلایی: هیچ‌وقت فایل‌های داده را مستقیماً در مخازن ویرایشگر ویرایش نکنید. هر تغییری را در این مخزن (`kolang-docs.json` و `snippets.json`) اعمال کنید و بعد اسکریپت همگام‌سازی همان‌جا را در مخازن مصرف‌کننده اجرا کنید.

---

## ساختار `kolang-docs.json`

یک فایل JSON با متادیتا و دسته‌های زیر:

```json
{
  "_comment": "داده‌های زبانی کلنگ — منبع حقیقی برای ویرایشگرها (kolang-mobile، kolang-web و kolang-vscode)",
  "_version": "0.0.1",
  "_sync": {
    "kolang-mobile": "in-app reference docs (sync TBD)",
    "kolang-web": "in-app hover docs (sync TBD)",
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

هر دسته آرایه‌ای از جفت‌های `[شناسه، متن راهنما]` است. متن راهنماها کامل و پر از جزئیات فارسی هستند.

- **`keywords`** — کلمات کلیدی زبان: کنترل جریان (`اگر`، `برای`، `بپا`)، تعریف (`تعریف`، `گونه`)، افعال ربطی (`باشد`، `نباشد`)، عملگرهای منطقی (`همچنین`، `یا`)، `خود`، `والد`، `پوشش` و…
- **`builtins`** — توابع فراخوانی‌پذیر از پیش‌تعریف‌شده: `طول`، `نوع`، `جمع`، `بازه`، `کانال`، `بازکردن` و…
- **`types`** — نوع‌های داده و سازنده‌های آن‌ها: `صحیح`، `متن`، `فهرست`، `گنجه` و…
- **`modules`** — نام ماژول‌ها: `ریاضی`، `زمان`، `جیسون`، `پایگاه‌داده` و…
- **`exceptions`** — کلاس‌های خطا: `خطا`، `خطای‌صفر`، `خطای‌مقدار` و…
- **`verbs`** — فعل‌های امری (دستورهای سطح-عبارتی): `بنویس`، `برگردان`، `بساز`، `بده`، `بگیر` و…
- **`literals`** — مقادیر ثابت: `درست`، `غلط`، `تهی`

**نکتهٔ نیم‌فاصله:** شناسه‌های ترکیبی حتماً با نیم‌فاصلهٔ (ZWNJ، `U+200C`) دقیق نگهداری شوند — مثل `خطای‌صفر`، `بسته‌است`، `حذف‌کن`، `سیستم‌عامل`. چون شناسه‌ها دقیقاً همان‌طور که در کد ظاهر می‌شوند باید مطابقت کنند.

---

## ساختار `snippets.json`

**منبع حقیقی قطعه‌کدها (snippets).** این فایل همهٔ قالب‌های کد زبان کلنگ را نگه می‌دارد و جایگزین دو منبع قدیمی و ناهم‌سو (آرایهٔ `SNIPPETS` در `kolang/docs/kolang-language.js` و `kolang-vscode/snippets/kolang.json`) شده است.

```json
{
  "_comment": "قطعه‌کدهای کانونیکال زبان کلنگ — منبع حقیقت برای ویرایشگرها",
  "_version": "0.0.1",
  "_sync": {
    "kolang-vscode": "snippets/kolang.json (fetched at build time via scripts/fetch-data.js; manual local sync via scripts/sync-snippets.sh)"
  },
  "snippets": {
    "تعریف تابع": {
      "prefix": "تعریف",
      "body": [
        "تعریف ${1:نام}(${2:خود و پارامتر}):",
        "    `${3:سلام}` بنویس"
      ],
      "description": "تعریف تابع"
    }
  }
}
```

- کلید هر قطعه‌کد، نام (title) آن است — مثل `تعریف تابع`، `گونه (کلاس)`، `برو (goroutine)`.
- قالب، همان فرمت قطعه‌کد VS Code است (`prefix` / `body` / `description`) چون رساترین فرمت موجود است؛ ویرایشگرهای دیگر می‌توانند آن را اقتباس کنند.
- در `body`، متغیرهای جابه‌جایی (tabstops) با `$1`، `$2` و… و متن پیش‌فرض با `${1:نام}` نوشته می‌شوند.
- **نیم‌فاصلهٔ (ZWNJ) دقیق** در متن‌های فارسی (مثل `خطای‌${2:صفر}`، `بازکردن`، `برگردان`) حفظ شود.

## همگام‌سازی

### به kolang-vscode (فایل `data/kolang-docs.json`)

```bash
./scripts/sync-vscode.sh
```

اسکریپت به‌صورت پیش‌فرض به `../kolang-vscode/data/kolang-docs.json` می‌نویسد (یا با آرگومان اول مسیر دلخواه بدهید). از آن‌جا که `extension.js` ویرایشگر vscode دسته‌های `keywords / functions / types / modules / exceptions / literals / snippets` را می‌خواند، اسکریپت این نگاشت را اعمال می‌کند:

```
functions = builtins + verbs
```

بخش `snippets` در فایل مقصد (اگر از قبل وجود داشته باشد) دست‌نخورده حفظ می‌شود — قطعه‌کدها جزو دادهٔ شناسه‌ها نیستند و **منبع حقیقی آن‌ها `snippets.json` است** (به بخش زیر مراجعه کنید). هنگام build، `scripts/fetch-data.js` در kolang-vscode همین `snippets.json` را می‌خواند و بخش `snippets` فایل مقصد را از آن می‌سازد.

### به kolang-vscode (فایل `snippets/kolang.json`)

قطعه‌کدها منبع حقیقی جداگانه‌ای دارند: `snippets.json`. دو روش همگام‌سازی:

```bash
# روش دستی — کپی محلی به kolang-vscode/snippets/kolang.json
./scripts/sync-snippets.sh

# روش خودکار — هنگام build در kolang-vscode (prepackage):
#   scripts/fetch-data.js → kolang-docs.json و snippets.json را می‌گیرد و
#   قطعه‌کدها را در snippets/kolang.json می‌نویسد
```

اسکریپت `sync-snippets.sh` بخش `snippets` فایل کانونیکال را همان‌طور که هست (فرمت VS Code: `prefix` / `body` / `description`) به `../kolang-vscode/snippets/kolang.json` می‌کپی می‌کند (یا با آرگومان اول مسیر دلخواه). روش اصلی، دریافت هنگام build توسط `fetch-data.js` است؛ اسکریپت دستی فقط برای توسعهٔ محلی است.

## افزودن کلمه کلیدی یا تابع جدید

۱. `kolang-docs.json` را ویرایش کنید: شناسه و متن راهنمای فارسی کامل را به دستهٔ درست اضافه کنید.
۲. همگام‌سازی را در مخازن مصرف‌کننده اجرا کنید:

```bash
./scripts/sync-vscode.sh
```

> اسکریپت‌های همگام‌سازی برای `kolang-mobile` و `kolang-web` هنوز فراهم نشده‌اند (به‌زودی).

۳. در مخزن kolang-data تغییر را commit کنید و بعد (در صورت نیاز) در مخازن ویرایشگر هم.

### افزودن قطعه‌کد جدید

۱. `snippets.json` را ویرایش کنید: زیر کلید `snippets` یک ورودی با کلیدِ نام قطعه‌کد و قالب VS Code (`prefix` / `body` / `description`) اضافه کنید.
۲. همگام‌سازی کنید:

```bash
./scripts/sync-snippets.sh        # توسعهٔ محلی
# یا هنگام build — scripts/fetch-data.js در kolang-vscode خودش آن را می‌گیرد
```

> قاعدهٔ نیم‌فاصله در `snippets.json` هم برقرار است؛ متن‌های فارسی داخل `body` و `description` را با ZWNJ دقیق بنویسید.

## نسخه

**0.0.1** — تغییرات در [CHANGELOG.md](CHANGELOG.md).

## مجوز

[MIT](LICENSE) — © ۲۰۲۶ FaraliDev و مشارکت‌کنندگان.

---

## English Summary

**kolang-data** is the canonical source-of-truth repo for Kolang language editor data (hover docs, keywords, builtins, types, modules, exceptions, verbs, **and snippets**). It is consumed by the following editors:

- **kolang-web** (CodeMirror 6): in-app hover docs — sync mechanism TBD.
- **kolang-mobile** (React Native): in-app reference docs — sync mechanism TBD.
- **kolang-vscode** (TextMate/JSON):
  - run `scripts/sync-vscode.sh` to refresh `data/kolang-docs.json` (the script maps canonical `builtins`+`verbs` → vscode `functions` and preserves existing `snippets`);
  - run `scripts/sync-snippets.sh` to refresh `snippets/kolang.json` from the canonical `snippets.json` (manual local option). The primary mechanism is fetch-at-build: `scripts/fetch-data.js` in kolang-vscode fetches BOTH `kolang-docs.json` and `snippets.json` during packaging and writes `data/kolang-docs.json` + `snippets/kolang.json`.

Edit `kolang-docs.json` and `snippets.json` only; never edit generated data inside the editor repos. Keep ZWNJ (`U+200C`) intact in compound identifiers and Persian snippet text (e.g. `خطای‌صفر`, `بسته‌است`). Version: **0.0.1**. License: **MIT**.