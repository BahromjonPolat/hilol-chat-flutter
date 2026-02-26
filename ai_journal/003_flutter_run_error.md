# Flutter Run Xatoligi

## Sana: 2025-11-29

## Xatolik Tavsifi

`example` papkasida `flutter run -d chrome` buyrug'ini ishga tushirganda quyidagi xatolik yuz berdi:

## Xatolik Detallari

**Fayl:**
```
~/.pub-cache/git/fcrm_chat_sdk-9a22c4e630e0fdfdf198f8a56efac80a6c10ce6f/lib/src/services/chat_api_service.dart
```

**Qator:** 214:26

**Xatolik Matni:**
```
Error: A value of type 'Map<String, dynamic>' can't be assigned to a variable of type 'String?'.
 - 'Map' is from 'dart:core'.
      body['metadata'] = metadata;
                         ^
```

## Sabab

`fcrm_chat_sdk` git dependency'sida type error mavjud:
- `metadata` o'zgaruvchisi `Map<String, dynamic>` tipida
- Lekin `body['metadata']` `String?` tipini kutmoqda
- Dart type system bu assignmentni qabul qilmaydi

## Dependency Ma'lumotlari

**Package:** fcrm_chat_sdk
**Manbaa:** Git repository
**URL:** https://github.com/ipchi/fcrm_chat_sdk.git
**Branch:** main
**Commit:** 9a22c4e630e0fdfdf198f8a56efac80a6c10ce6f

## Yechim Variantlari

1. **Git package'ni tuzatish:**
   - GitHub repository'ga borib pull request yaratish
   - `metadata` ni to'g'ri tipga o'zgartirish yoki serialize qilish

2. **Local dependency'ga o'tkazish:**
   - `fcrm_chat_sdk` ni local clone qilish
   - `pubspec.yaml` da git dependency'ni path dependency'ga o'zgartirish
   - Xatolikni local'da tuzatish

3. **Fork yaratish:**
   - Repository'ni fork qilish
   - Xatolikni tuzatish
   - O'z fork'imizdan foydalanish

## Kerakli Amallar

1. `chat_api_service.dart` faylining 214-qatori atrofidagi kodni ko'rish
2. `metadata` qanday tipda ekanligini aniqlash
3. To'g'ri tuzatish yo'lini tanlash
4. Tuzatishni amalga oshirish
