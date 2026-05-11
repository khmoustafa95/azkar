# Spec: Hajj Syria App - Home Screen Redesign

## 1. Overview
The goal is to create the main landing screen for the "Hajj Syria" app. This screen must combine the branding from `image_0.png` with the specific hotel and contact information from `image_1.png`, redesigning them into a functional mobile UI.

## 2. Visual Identity & Branding (Source: `image_0.png`)
* **Color Palette:**
    * Primary Green: Use the exact dark green from the logo.
    * Accent Gold/Bronze: Use the gold from the side stripes.
    * Background: Clean white.
* **Header Area:**
    * Place the "Hajj 1447" (حج 1447) green badge at the top right.
    * Display the main title "Hajj Syria" (حجاج سوريا) and subtitle "Al-Masi Coalition for Hajj Services" (تكتل الماسي لخدمات الحج) prominently in the upper section.
    * Include the main "Al-Masi Coalition" (تكتل الماسي) round logo (Kaaba and Minaret) appropriately, perhaps on the top left or centered below the title.

## 3. Core Feature: Dynamic Hotel Information Card (Source: `image_1.png`)
This section replaces the static printed card with a dynamic, stylized UI element.

* **Card Container:**
    * A stylized container that visually resembles a high-quality ID card or pass. It should not be a flat list. Use the green header area from `image_1.png` for the card's header.
    * **Text on Card Header (White text on green):**
        * "Hajj Syria" (حجاج سوريا)
        * "Narjes Al-Hadiqa Hotel" (فندق نرجس الحديقة)

* **Card Body (Information Grid):**
    * Use the bronze/gold color scheme and the specific icons from `image_1.png` to create a clean information panel. Use the exact text provided in `image_1.png`.
    * **Row 1 (User Icon):** "Coalition Leader: Mahmoud Radwan Al-Haddad" (رئيس التكتل: محمود رضوان الحداد).
    * **Row 2 (Phone Icon):** Display both numbers with proper formatting. Use the country flags visually near the numbers (+963, +966) if possible.
        * `+963 995 168 816`
        * `+966 542 380 552`
    * **Row 3 (Location Icon):** "Makkah Al-Mukarramah: Mansour St., behind Al-Khayyat Station, near Al-Nakkasa Roundabout" (مكة المكرمة: شارع المنصور خلف محطة الخياط - قرب دوار النكاسة).

## 4. Modified Action Button (Replaces QR Code)
Instead of a QR code, create a prominent action button within the Info Card section.

* **Button Text:** "View Details" (عرض التفاصيل) or "Open Application" (عرض التطبيق).
* **Action:** For now, this button should just have an empty `onPressed` callback, placeholder for navigation.
* **Styling:** Make it look like a clear action button, perhaps using the Accent Gold or Primary Green, to draw attention. It should clearly replace the QR code area in the layout hierarchy.

## 5. Partner Logos Section (Source: `image_0.png`)
* **Position:** Near the bottom of the screen.
* **Layout:** A horizontal, scrollable list (or a grid if preferred) of all the small round logos seen at the bottom of `image_0.png`. Ensure they are rendered clearly.

## 6. Footer (Source: `image_1.png`)
* Display the year text "Hajj 1447 - 2026" (حج 1447 - 2026) in small text at the very bottom of the screen.

## 7. Implementation Notes
* Prioritize using `image_0.png` for overall branding and top-level titles.
* Prioritize using `image_1.png` for specific, typed text data, numbers, and the information card's content structure.
* Ensure all text is in Arabic as specified in the images.
* Make the UI responsive for mobile.