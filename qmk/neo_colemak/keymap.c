#include QMK_KEYBOARD_H
#include "debug.h"
#include "action_layer.h"
#include "version.h"

#define COLEMAK 0 // default layer
#define SYMBOL 1
#define NUM 2
#define NAV 3

#define SNEK  UC(0x1F40D) // 🐍
#define BANG  UC(0x203D)  // ‽
#define IRONY UC(0x2E2E)  // ⸮
#define ELIP  UC(0x2026)  // …
#define ARRU  UC(0x2191)  // ↑
#define ARRD  UC(0x2193)  // ↓
#define ARRL  UC(0x2190)  // ↓
#define ARRR  UC(0x2192)  // →
#define DEGR  UC(0x00B0)  // °
#define CHECK UC(0x2713)  // ✓
#define SQRT  UC(0x221A)  // √
#define PLMN  UC(0x00B1)  // ±
#define THFO  UC(0x2234)  // ∴
#define BCUSE UC(0x2235)  // ∵
#define INFI  UC(0x221E)  // ∞
#define NSUM  UC(0x2211)  // ∑
#define DELT  UC(0x0394)  // Δ

#define CTL_ESC  CTL_T(KC_ESC)
#define SYM_A    LT(SYMBOL, KC_A)
#define ALT_R    ALT_T(KC_R)
#define CTL_S    CTL_T(KC_S)
#define NUM_Z    LT(NUM, KC_Z)
#define LT_NAV   LT(NAV, KC_TRNS)
#define CTL_E    RCTL_T(KC_E)
#define ALT_I    RALT_T(KC_I)
#define SYM_O    LT(SYMBOL, KC_O)
#define NUM_SLSH LT(NUM, KC_SLSH)
// Tab /,/r0l1
// Tab /,\zs/l1

enum custom_keycodes {
  PLACEHOLDER = SAFE_RANGE, // can always be here
  EPRM,
  VRSN,
  RGB_SLD
};


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[COLEMAK] = LAYOUT_ergodox(  // layer 0 : default
/*
 * left hand
 *    +-------+-----+-----+-----+-----+-----+-----+
 *    |       |     |     |     |     |     |     |
 *    +-------+-----+-----+-----+-----+-----+-----+
 *    |       |  Q  |  W  |  F  |  P  |  G  |     |
 *    +-------+-----+-----+-----+-----+-----+     |
 *    |ESC/CTL|SYM/A|ALT/R|CTL/S|  T  |  D  +-----+
 *    +-------+-----+-----+-----+-----+-----+LGUI |
 *    |  NAV  |NUM/Z|  X  |  C  |  V  |  B  |     |
 *    +-+-----+-----+-----+-----+-----+-----+-----+
 *      |     |     |     |     |     |
 *      +-----+-----+-----+-----+-----+   +-----+-----+
 *                                        | 🔇  | 🔊  |
 *                                  +-----+-----+-----+
 *                                  |     |     | 🔈  |
 *                                  |SHFT/| TAB/+-----+
 *                                  |SPACE| NAV | ESC |
 *                                  +-----+-----+-----+
 */
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
        KC_TRNS, KC_Q,    KC_W,    KC_F,    KC_P,    KC_G,    KC_TRNS,
        CTL_ESC, SYM_A,   ALT_R,   CTL_S,   KC_T,    KC_D,
        LT_NAV,  NUM_Z,   KC_X,    KC_C,    KC_V,    KC_B,    KC_LGUI,
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
                                                     KC_MUTE, KC_VOLU,
                                                              KC_VOLD,
                             LSFT_T(KC_SPC), LT(NAV, KC_TAB),  KC_ESC,
/* right hand
 *        +-----+-----+-----+-----+-----+-----+------+
 *        |     |     |     |     |     |     |      |
 *        +-----+-----+-----+-----+-----+-----+------+
 *        |     |  J  |  L  |  U  |  Y  |  ;  |      |
 *        |     +-----+-----+-----+-----+-----+------+
 *        +-----+  H  |  N  |  E  |  I  |  O  |   '  |
 *        | RGUI+-----+-----+-----+-----+-----+------+
 *        |     |  K  |  M  |  ,  |  .  |  /  |      |
 *        +-----+-----+-----+-----+-----+-----+------+
 *                    |     |     |     |     |     |
 *    +-----+-----+   +-----+-----+-----+-----+-----+
 *    | RALT|RCTRL|
 *    +-----+-----+-----+
 *    | PGUP|     |SHFT/|
 *    +-----+BSPC | SPC |
 *    | DEL |     |     |
 *    +-----+-----+-----+
 */
             KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,
             KC_TRNS, KC_J,    KC_L,    KC_U,    KC_Y,    KC_SCLN,  KC_TRNS,
                      KC_H,    KC_N,    CTL_E,   ALT_I,   SYM_O,    KC_QUOT,
             KC_LGUI, KC_K,    KC_M,    KC_COMM, KC_DOT,  NUM_SLSH, KC_LALT,
                               KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,
             KC_MPLY, KC_MNXT,
             KC_MPRV,
             KC_DELT, KC_BSPC, RSFT_T(KC_ENT)
    ),

[SYMBOL] = LAYOUT_ergodox( // layer 1 : function layers
/* left hand
 *    +-------+-----+-----+-----+-----+-----+-----+
 *    | RESET | f1  | f2  | f3  | f4  | f5  | f11 |
 *    +-------+-----+-----+-----+-----+-----+-----+
 *    |       |  …  |  _  |  [  |  ]  |  ^  |     |
 *    +-------+-----+-----+-----+-----+-----+     |
 *    |       |  \  |  /  |  {  |  }  |  *  +-----+
 *    +-------+-----+-----+-----+-----+-----+     |
 *    |       |  #  |  $  |  |  |  ~  |  `  |     |
 *    +-+-----+-----+-----+-----+-----+-----+-----+
 *      |     |     |     |     |     |
 *      +-----+-----+-----+-----+-----+   +-----+-----+
 *                                        |     |     |
 *                                  +-----+-----+-----+
 *                                  |     |     |     |
 *                                  |     |     +-----+
 *                                  |     |     |     |
 *                                  +-----+-----+-----+
 */
       RESET,   KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F11,
       KC_TRNS, ELIP,    KC_UNDS, KC_LBRC, KC_RBRC, KC_CIRC, KC_TRNS,
       KC_TRNS, KC_BSLS, KC_SLSH, KC_LCBR, KC_RCBR, KC_ASTR,
       KC_TRNS, KC_HASH, KC_DLR,  KC_PIPE, KC_TILD, KC_GRV,  KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
                                                    KC_TRNS, KC_TRNS,
                                                             KC_TRNS,
                                           KC_TRNS, KC_TRNS, KC_TRNS,
/* right hand
 *        +-----+-----+-----+-----+-----+-----+-------+
 *        | f12 | f6  | f7  | f8  | f9  | f10 |       |
 *        +-----+-----+-----+-----+-----+-----+-------+
 *        |     |  !  |  <  |  >  |  =  |  &  |       |
 *        |     +-----+-----+-----+-----+-----+-------+
 *        +-----+  ?  |  (  |  )  |  -  |  :  |       |
 *        |     +-----+-----+-----+-----+-----+-------+
 *        |     |  +  |  %  |  ‽  |  @  |  '  |       |
 *        +-----+-----+-----+-----+-----+-----+-----+-+
 *                    |     |     |     |     |     |
 *    +-----+-----+   +-----+-----+-----+-----+-----+
 *    |     |     |
 *    +-----+-----+-----+
 *    |     |     |     |
 *    +-----+     |     |
 *    |     |     |     |
 *    +-----+-----+-----+
 */
       KC_F12,  KC_F6,   KC_F7,   KC_F8,   KC_F9,    KC_F10,   RESET,
       KC_TRNS, KC_EXLM, KC_LT,   KC_GT,   KC_EQL,   KC_AMPR,  KC_TRNS,
                KC_QUES, KC_LPRN, KC_RPRN, KC_MINS,  KC_COLON, KC_TRNS,
       KC_TRNS, KC_PLUS, KC_PERC, BANG,    KC_AT,    KC_QUOT,  KC_TRNS,
                         KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,  KC_TRNS,
       KC_TRNS, KC_TRNS,
       KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS
),
[NUM] = LAYOUT_ergodox(
/* Left hand
 *    +-------+-----+-----+-----+-----+-----+-----+
 *    |       |     |     |     |     |     |     |
 *    +-------+-----+-----+-----+-----+-----+-----+
 *    |       |  ∞  |     |  ↑  |  ±  |     |     |
 *    +-------+-----+-----+-----+-----+-----+     |
 *    |       |     |  ←  |  ↓  |  →  |  °  +-----+
 *    +-------+-----+-----+-----+-----+-----+     |
 *    |       |  ∑  |  ✓  |  √  |  ∴  |  ∵  |     |
 *    +-+-----+-----+-----+-----+-----+-----+-----+
 *      |     |     |     |     |     |
 *      +-----+-----+-----+-----+-----+   +-----+-----+
 *                                        |     |     |
 *                                  +-----+-----+-----+
 *                                  |     |     |     |
 *                                  |     |     +-----+
 *                                  |     |     |     |
 *                                  +-----+-----+-----+
 */
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, INFI,    KC_TRNS, ARRU,    PLMN,    KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS, ARRL,    ARRD,    ARRR,    DEGR,
       KC_TRNS, NSUM,    CHECK,   SQRT,    THFO,    BCUSE,   KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
                                           KC_TRNS, KC_TRNS,
                                                    KC_TRNS,
                                  KC_TRNS, KC_TRNS, KC_TRNS,
/* right hand
 *        +-----+-----+-----+-----+-----+-----+-------+
 *        |     |     |     |     |     |     |       |
 *        +-----+-----+-----+-----+-----+-----+-------+
 *        |     |     |  7  |  8  |  9  |     |       |
 *        |     +-----+-----+-----+-----+-----+-------+
 *        +-----+     |  4  |  5  |  6  |     |       |
 *        |     +-----+-----+-----+-----+-----+-------+
 *        |     |  0  |  1  |  2  |  3  |  Δ  |       |
 *        +-----+-----+-----+-----+-----+-----+-----+-+
 *                    |     |     |     |     |     |
 *    +-----+-----+   +-----+-----+-----+-----+-----+
 *    |     |     |
 *    +-----+-----+-----+
 *    |     |     |     |
 *    +-----+     |     |
 *    |     |     |     |
 *    +-----+-----+-----+
 */
       KC_TRNS,  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS,  KC_TRNS, KC_7,    KC_8,    KC_9,    KC_TRNS, KC_TRNS,
                 KC_TRNS, KC_4,    KC_5,    KC_6,    KC_TRNS, KC_TRNS,
       KC_TRNS,  KC_0,    KC_1,    KC_2,    KC_3,    DELT,    KC_TRNS,
                          KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS,
       KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS
),

[NAV] = LAYOUT_ergodox(
/* Left hand
 *    +-------+-----+-----+-----+-----+-----+-----+
 *    | FLASH |     |     |     |     |     |     |
 *    +-------+-----+-----+-----+-----+-----+-----+
 *    |       |     |     |     |     |     |     |
 *    +-------+-----+-----+-----+-----+-----+     |
 *    |       |     |     |     |     |PGDN +-----+
 *    +-------+-----+-----+-----+-----+-----+     |
 *    |       |     |     |     |     |     |     |
 *    +-+-----+-----+-----+-----+-----+-----+-----+
 *      |     |     |     |     |     |
 *      +-----+-----+-----+-----+-----+   +-----+-----+
 *                                        |     |     |
 *                                  +-----+-----+-----+
 *                                  |     |     |     |
 *                                  |     |     +-----+
 *                                  |     |     |     |
 *                                  +-----+-----+-----+
 */
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_PGDOWN,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
                                           KC_TRNS, KC_TRNS,
                                                    KC_TRNS,
                                  KC_TRNS, KC_TRNS, KC_TRNS,
/* right hand
 *        +-----+-----+-----+-----+-----+-----+-------+
 *        |     |     |     |     |     |     |       |
 *        +-----+-----+-----+-----+-----+-----+-------+
 *        |     |DOWN |RIGHT| PGUP|     |     |       |
 *        |     +-----+-----+-----+-----+-----+-------+
 *        +-----+LEFT |     | END | HOME|     |       |
 *        |     +-----+-----+-----+-----+-----+-------+
 *        |     | UP  |     |     |     |     |       |
 *        +-----+-----+-----+-----+-----+-----+-----+-+
 *                    |     |     |     |     |     |
 *    +-----+-----+   +-----+-----+-----+-----+-----+
 *    |     |     |
 *    +-----+-----+-----+
 *    |     |     |     |
 *    +-----+     |     |
 *    |     |     |     |
 *    +-----+-----+-----+
 */
       KC_TRNS,  KC_TRNS, KC_TRNS,  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS,  KC_DOWN, KC_RIGHT, KC_PGUP, KC_TRNS, KC_TRNS, KC_TRNS,
                 KC_LEFT, KC_TRNS,  KC_END,  KC_HOME, KC_TRNS, KC_TRNS,
       KC_TRNS,  KC_UP,   KC_TRNS,  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
                          KC_TRNS,  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS,
       KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS
),
};

const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt)
{
  // MACRODOWN only works in this function
      switch(id) {
        case 0:
        if (record->event.pressed) {
          SEND_STRING (QMK_KEYBOARD "/" QMK_KEYMAP " @ " QMK_VERSION);
        }
        break;
        case 1:
        if (record->event.pressed) { // For resetting EEPROM
          eeconfig_init();
        }
        break;
      }
    return MACRO_NONE;
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    // dynamically generate these.
    case EPRM:
      if (record->event.pressed) {
        eeconfig_init();
      }
      return false;
      break;
    case VRSN:
      if (record->event.pressed) {
        SEND_STRING (QMK_KEYBOARD "/" QMK_KEYMAP " @ " QMK_VERSION);
      }
      return false;
      break;
    case RGB_SLD:
      if (record->event.pressed) {
        #ifdef RGBLIGHT_ENABLE
          rgblight_mode(1);
        #endif
      }
      return false;
      break;
  }
  return true;
}

// Runs just one time when the keyboard initializes.
void matrix_init_user(void) {
  set_unicode_input_mode(UC_LNX);
};


// Runs constantly in the background, in a loop.
void matrix_scan_user(void) {

    uint8_t layer = biton32(layer_state);

    ergodox_board_led_off();
    ergodox_right_led_1_off();
    ergodox_right_led_2_off();
    ergodox_right_led_3_off();
    switch (layer) {
      // TODO: Make this relevant to the ErgoDox EZ.
        case 1:
            ergodox_right_led_1_on();
            break;
        case 2:
            ergodox_right_led_2_on();
            break;
        default:
            // none
            break;
    }

};
