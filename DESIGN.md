# Design System Specification: The Fluid Precision Framework

## 1. Overview & Creative North Star: "The Digital Curator"
This design system rejects the "templated" look of standard Material Design in favor of a **High-End Editorial** experience. Our Creative North Star is **"The Digital Curator."** 

This approach treats the Android interface as a high-end gallery space. It prioritizes intentional white space, rhythmic asymmetry, and tonal depth over rigid grids and containment lines. By moving away from "boxy" layouts and embracing "breathing" compositions, we create a mobile experience that feels bespoke, premium, and calm. The goal is not just utility, but a sense of effortless sophistication.

---

## 2. Colors & Surface Philosophy

The color palette is anchored by a deep, authoritative blue (`primary: #005bc4`) and supported by an expansive range of atmospheric neutrals. 

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1px solid borders for sectioning. Structural boundaries must be defined solely through background color shifts or subtle tonal transitions.
*   *Implementation:* Use `surface-container-low` for large section backgrounds sitting on a `surface` (`#faf9fe`) base.

### Surface Hierarchy & Nesting
Treat the UI as physical layers of fine paper or frosted glass. Depth is achieved through "Tonal Stacking":
*   **Base Layer:** `surface` (#faf9fe)
*   **Receded Sections:** `surface-container-low` (#f3f3fa)
*   **Active Elements/Cards:** `surface-container-lowest` (#ffffff)
*   **High-Impact Overlays:** `surface-container-highest` (#e0e2ed)

### The "Glass & Gradient" Rule
To escape the "flat" look, use Glassmorphism for floating elements (Bottom Sheets, Navigation Bars).
*   **Recipe:** Apply `surface` at 80% opacity with a 20px - 40px backdrop blur.
*   **Signature Textures:** For Hero CTAs, use a subtle linear gradient from `primary` (#005bc4) to `primary_container` (#4388fd) at a 135-degree angle. This adds a "lithographic" soul to the interface.

---

## 3. Typography: The Inter Editorial Scale

We utilize **Inter** not as a standard system font, but as a Swiss-inspired typographic tool. 

*   **Display & Headlines:** Use `display-lg` (3.5rem) and `headline-lg` (2rem) with tight tracking (-0.02em) to create an authoritative, editorial "poster" feel.
*   **Contrast as Hierarchy:** Pair a large `headline-sm` (1.5rem) with a tiny, all-caps `label-sm` (0.6875rem) in `secondary` color to create a sophisticated, high-contrast dynamic.
*   **Body Text:** `body-lg` (1rem) is the workhorse. Maintain a generous line-height (1.6) to ensure the "Minimalist" promise is kept through legibility and air.

---

## 4. Elevation & Depth: Tonal Layering

Traditional shadows are often "dirty." This system uses light and tone to imply height.

*   **The Layering Principle:** Avoid shadows for static cards. Place a `surface-container-lowest` card on a `surface-container-low` background. The subtle shift from #f3f3fa to #ffffff provides a soft, natural lift.
*   **Ambient Shadows:** For floating Action Buttons or triggered Menus, use a "Cloud Shadow":
    *   *Blur:* 32px | *Y-Offset:* 8px | *Color:* `on_surface` (#2f323a) at 6% opacity.
*   **The "Ghost Border" Fallback:** If accessibility requires a border, use `outline-variant` (#afb1bc) at **15% opacity**. Never use a 100% opaque border.
*   **Glassmorphism Depth:** Elements using `surface_tint` as a soft glow behind semi-transparent containers create a futuristic "glow-from-within" effect.

---

## 5. Components

### Buttons
*   **Primary:** Gradient (`primary` to `primary_container`), `xl` rounded corners (1.5rem). No shadow; use a subtle inner-glow on hover/press.
*   **Secondary:** `surface-container-high` background with `primary` text.
*   **Tertiary:** Pure text using `primary` with `label-md` styling, no container.

### Cards & Lists
*   **The Divider Ban:** Divider lines are forbidden. Separate list items using 16dp of vertical white space or by alternating background tones (`surface` to `surface-container-low`).
*   **Shape:** All cards must use `xl` (1.5rem) or `lg` (1rem) corner radius to maintain the "Smooth" style.

### Input Fields
*   **Style:** Minimalist underline style is prohibited. Use a "Filled" approach with `surface-container-high` and `sm` (0.25rem) corners. 
*   **State:** On focus, the background shifts to `surface-container-lowest` and an `outline` at 20% opacity appears.

### Interactive Chips
*   **Selection:** Use `primary_container` for active states. Use `surface-container-highest` for inactive. Ensure `full` rounding (9999px).

---

## 6. Do’s and Don’ts

### Do:
*   **Do** use asymmetrical padding (e.g., more padding at the top of a container than the bottom) to create a "custom-built" feel.
*   **Do** allow elements to "bleed" off the edge of the screen in horizontal carousels to suggest infinite content.
*   **Do** use `on_surface_variant` (#5c5f68) for secondary information to maintain a soft visual hierarchy.

### Don’t:
*   **Don’t** use pure black (#000000) for text. Use `on_surface` (#2f323a) to keep the "Minimalist" softness.
*   **Don’t** use standard Material "Drop Shadows." They break the editorial aesthetic.
*   **Don’t** crowd the edges. Maintain a minimum 24dp "safety margin" from the screen edge for all primary content.
*   **Don’t** use icons with varying stroke weights. All icons must be "Light" or "Thin" weight to match the Inter typography.

---

## 7. Signature Interaction: "The Elastic Glide"
All transitions should use a **Quartic Easing** (0.76, 0, 0.24, 1). Elements shouldn't just "appear"; they should slide into place with a subtle scale-up from 98% to 100%, mimicking the feel of a high-end physical publication being opened.