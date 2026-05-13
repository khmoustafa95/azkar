# Admin instructions slideshow images

Drop the 16 portrait instruction JPEGs (or WebPs) here using slugified ASCII
filenames. The exact filenames the app expects are listed in
`lib/features/admin_instructions/data/admin_instructions_data.dart`.

Expected names (rename as you copy from your source folder):

- `01_before_travel.jpg`           — تعليمات قبل السفر
- `02_to_airport.jpg`              — تعليمات الوصول للمطار
- `03_to_jeddah_airport.jpg`       — تعليمات الوصول إلى مطار جدة
- `04_inside_plane.jpg`            — تعليمات داخل الطائرة وعقد النية
- `05_to_hotel.jpg`                — تعليمات الوصول إلى الفندق
- `06_mosque.jpg`                  — تعليمات المسجد
- `07_restaurant.jpg`              — تعليمات المطعم
- `08_laundry_floor.jpg`           — تعليمات طابق الغسيل
- `09_arafat_mina_camps.jpg`       — تعليمات مخيمات عرفات ومنى
- `10_group_umrah_march.jpg`       — تعليمات المسير أثناء العمرة الجماعية
- `11_assistant.jpg`               — تعليمات المساعد
- `12_lost_and_signal_points.jpg`  — تعليمات حالات الضياع ونقاط العلام
- `13_medina_departure.jpg`        — تعليمات المغادرة من المدينة
- `14_to_from_medina_airport.jpg`  — تعليمات العودة والذهاب لمطار المدينة
- `15_helper.jpg`                  — تعليمات إضافية
- `16_misc.jpg`                    — تعليمات متفرقة

Tip: shrink the JPEGs to WebP with `cwebp -q 85 input.jpg -o input.webp`
to cut the bundled size from ~80 MB to ~6 MB. Update the extensions in
`admin_instructions_data.dart` accordingly.

If a file is missing at runtime, the slideshow shows a graceful
"الصورة غير متوفرة" placeholder instead of crashing.
