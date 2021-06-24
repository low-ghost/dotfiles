#include QMK_KEYBOARD_H
#include "action_layer.h"
#include "debug.h"
#include "version.h"
#include "keycodes/definitions.c"
#include "keycodes/unicode.c"
#include "keycodes/aliases.c"
#include "vim.h"

#define LEADER_TIMEOUT 300
#define IGNORE_MOD_TAP_INTERRUPT
#define LEADER_PER_KEY_TIMING
#define KEY_MODE UC_OSX

#define COLEMAK 0 // default layer
#define SYMBOL 1
#define NUM 2
#define NAV 3

#include "dynamic_macro.h"

// Vim
/* #define TO_NORM TO(NORMAL_MODE) */

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [COLEMAK] = LAYOUT_ergodox(  // layer 0 : default
      /*
       * left hand
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |     |     |     |     |     |     |
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |  Q  |  W  |  F  |  P  |  G  |     |
       *    +-------+-----+-----+-----+-----+-----+     |
       *    |ESC/CTL|SYM/A|GUI/R|ALT/S|CTL/T|  D  +-----+
       *    +-------+-----+-----+-----+-----+-----+     |
       *    |       |NUM/Z|  X  |  C  |  V  |  B  |     |
       *    +-+-----+-----+-----+-----+-----+-----+-----+
       *      |     |     |     |     |     |
       *      +-----+-----+-----+-----+-----+   +-----+-----+
       *                                        |DESK_L|DESK_R|
       *                                  +-----+-----+-----+
       *                                  |     |     |     |
       *                                  |SHFT/| ESC/+-----+
       *                                  |SPACE| NAV | TAB |
       *                                  +-----+-----+-----+
       */
  KC_TRNS, DYN_REC_START1, DYN_REC_START2, DYN_MACRO_PLAY1, DYN_MACRO_PLAY2, DYN_REC_STOP, KC_TRNS,
  KC_TRNS, KC_Q,    KC_W,    KC_F,    KC_P,    KC_G,    KC_TRNS,
  KC_TRNS, SYM_A,   GUI_R,   ALT_S,   CTL_KT,  KC_D,
  KC_TRNS,  NUM_Z,   KC_X,    KC_C,    KC_V,    KC_B,    KC_TRNS,
  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
  DESK_L, DESK_R,
  KC_TRNS,
  LSFT_T(KC_SPC), LT(NAV, KC_ESC), KC_TAB,
  /* right hand
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |     |     |     |     |     |       |
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |  J  |  L  |  U  |  Y  |  ;  |dashes |
   *        |     +-----+-----+-----+-----+-----+-------+
   *        +-----+  H  |CTL/N|ALT/E|GUI/I|SYM/O|       |
   *        | RGUI+-----+-----+-----+-----+-----+-------+
   *        |     |  K  |  M  |  ,  |  .  |NUM//|   @   |
   *        +-----+-----+-----+-----+-----+-----+-------+
   *                    |LEAD |     |     |     |     |
   *    +-----+-----+   +-----+-----+-----+-----+-----+
   *    |  🔊 | 🔇  |
   *    +-----+-----+-----+
   *    |  🔈 |     |SHFT/|
   *    +-----+BSPC | SPC |
   *    | DEL |     |     |
   *    +-----+-----+-----+
   */
  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,
  KC_TRNS, KC_J,    KC_L,    KC_U,    KC_Y,    KC_SCLN,  KC_TRNS,
  KC_H,    CTL_N,   ALT_E,   GUI_I,   SYM_O,   KC_TRNS,
  KC_LGUI, KC_K,    KC_M,    KC_COMM, KC_DOT,  NUM_SLSH, KC_TRNS,
  KC_LEAD, KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,
  KC_VOLU, KC_MUTE,
  KC_VOLD,
  KC_DELT, KC_BSPC, RSFT_T(KC_ENT)
    ),

  [SYMBOL] = LAYOUT_ergodox( // layer 1 : function layers
      /* left hand
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    | RESET | f1  | f2  | f3  | f4  | f5  | f11 |
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |  …  |  _  |  [  |  ]  |  ^  |     |
       *    +-------+-----+-----+-----+-----+-----+     |
       *    |       |  \  |GUI//|ALT/{|CTL/}|  *  +-----+
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
    RESET, KC_F1,   KC_F2,    KC_F3,    KC_F4,    KC_F5,   KC_F11,
  KC_TRNS, ELIP,    KC_UNDS,  KC_LBRC,  KC_RBRC,  KC_CIRC, KC_TRNS,
  KC_TRNS, KC_BSLS, GUI_SLSH, ALT_LCBR, CTL_RCBR, KC_ASTR,
  KC_TRNS, KC_HASH, KC_DLR,   KC_PIPE,  KC_TILD,  KC_GRV,  KC_TRNS,
  KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,  KC_TRNS,
  KC_TRNS, KC_TRNS,
  KC_TRNS,
  KC_TRNS, KC_TRNS, KC_TRNS,
  /* right hand
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        | f12 | f6  | f7  | f8  | f9  | f10 | RESET |
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |  !  |  <  |  >  |  =  |  &  |       |
   *        |     +-----+-----+-----+-----+-----+-------+
   *        +-----+  ?  |CTL/(|ALT/)|GUI/-|  '  |       |
   *        |     +-----+-----+-----+-----+-----+-------+
   *        |     |  +  |  %  |  ‽  |  @  |     |       |
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
  KC_F12,  KC_F6,    KC_F7,    KC_F8,    KC_F9,    KC_F10,   RESET,
  KC_TRNS, KC_EXLM,  KC_LT,    KC_GT,    KC_EQL,   KC_AMPR,  KC_TRNS,
  KC_QUES, CTL_LPRN, ALT_RPRN, GUI_MINS, KC_QUOT,  KC_TRNS,
  KC_TRNS, KC_PLUS,  KC_PERC,  BANG,     KC_AT,    KC_TRNS,  CPYW,
  KC_TRNS, KC_TRNS,  KC_TRNS,  KC_TRNS,  KC_TRNS,
  KC_TRNS, KC_TRNS,
  KC_TRNS,
  KC_TRNS, KC_TRNS, KC_TRNS
    ),
  [NUM] = LAYOUT_ergodox(
      /* Left hand
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |     |     |     |     |     |     |
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |  ∞  |     |  ↑  |  ±  |  ⸮  |  ‽  |
       *    +-------+-----+-----+-----+-----+-----+     |
       *    |       |     |  ←  |ALT/↓|CTL/→|  °  +-----+
       *    +-------+-----+-----+-----+-----+-----+     |
       *    |       |  ∑  |  √  |  ✓  |  ∴  |  ∵  |     |
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
  KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,  KC_TRNS,  KC_TRNS, KC_TRNS,
  KC_TRNS, INFI,    KC_TRNS,  ARRU,     PLMN,     IRONY, BANG,
  KC_TRNS, KC_TRNS, ARRL,     ALT_ARRD, CTL_ARRR, DEGR,
  KC_TRNS, NSUM,    SQRT,     CHECK,    THFO,     BCUSE,   KC_TRNS,
  KC_TRNS, KC_TRNS, KC_TRNS,  KC_TRNS,  KC_TRNS,
  KC_TRNS, KC_TRNS,
  KC_TRNS,
  KC_TRNS, KC_TRNS, KC_TRNS,
  /* right hand
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |     |     |     |     |     |       |
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |     |  7  |  8  |  9  |  =  |       |
   *        |     +-----+-----+-----+-----+-----+-------+
   *        +-----+  *  |  4  |  5  |  6  |  -  |       |
   *        |     +-----+-----+-----+-----+-----+-------+
   *        |     |  0  |  1  |  2  |  3  |  Δ  |       |
   *        +-----+-----+-----+-----+-----+-----+-----+-+
   *                    |  +  |  ,  |  .  |  /  |     |
   *    +-----+-----+   +-----+-----+-----+-----+-----+
   *    |     |     |
   *    +-----+-----+-----+
   *    |     |     |     |
   *    +-----+     |     |
   *    |     |     |     |
   *    +-----+-----+-----+
   */
  KC_TRNS,  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
  KC_TRNS,  KC_TRNS, KC_7,    KC_8,    KC_9,    KC_EQL,  KC_TRNS,
  KC_ASTR, KC_4,    KC_5,    KC_6,    KC_MINUS, KC_TRNS,
  KC_TRNS,  KC_0,    KC_1,    KC_2,    KC_3,    DELT,    KC_TRNS,
  KC_PLUS, KC_COMM, KC_DOT,  KC_SLSH, KC_TRNS,
  KC_TRNS, KC_TRNS,
  KC_TRNS,
  KC_TRNS, KC_TRNS, KC_TRNS
    ),

  [NAV] = LAYOUT_ergodox(
      /* Left hand
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |     |     |     |     |     |     |
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |     |     |     |     |     |     |
       *    +-------+-----+-----+-----+-----+-----+     |
       *    |       |     |     |     |     |PGDN +-----+
       *    +-------+-----+-----+-----+-----+-----+     |
       *    |       |     |     |     |     |BACK |     |
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
  KC_TRNS, KC_TRNS, VIM_W, KC_PGDN, KC_TRNS, TOP, KC_TRNS,
  KC_TRNS, END, KC_TRNS, KC_TRNS, KC_TRNS, VIM_D,
  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, VIM_B, KC_TRNS,
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
  KC_TRNS,  VIM_J, VIM_L, KC_PGUP, VIM_Y, KC_TRNS, KC_TRNS,
  VIM_H, KC_TRNS,  VIM_E, VIM_I, KC_TRNS, KC_TRNS,
  KC_TRNS,  VIM_K, KC_TRNS,  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
  KC_TRNS,  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
  KC_TRNS, KC_TRNS,
  KC_TRNS,
  KC_TRNS, KC_TRNS, KC_TRNS
    ),
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  static uint16_t my_hash_timer;

  if (!process_record_dynamic_macro(keycode, record)) {
    return false;
  }

  bool SHIFTED = (keyboard_report->mods & MOD_BIT(KC_LSFT)) |
    (keyboard_report->mods & MOD_BIT(KC_RSFT));

  switch (keycode) {
    case EPRM:
      if (record->event.pressed) {
        eeconfig_init();
      }
      return false;
    case ALT_LCBR:
      if (record->event.pressed) {
        my_hash_timer = timer_read();
        register_code(KC_LALT);
      } else {
        unregister_code(KC_LALT);
        if (timer_elapsed(my_hash_timer) < TAPPING_TERM) {
          SEND_STRING("{");
        }
      }
      return false;
    case CTL_RCBR:
      if (record->event.pressed) {
        my_hash_timer = timer_read();
        register_code(KC_LCTL);
      } else {
        unregister_code(KC_LCTL);
        if (timer_elapsed(my_hash_timer) < TAPPING_TERM) {
          SEND_STRING("}");
        }
      }
      return false;
    case CTL_LPRN:
      if (record->event.pressed) {
        my_hash_timer = timer_read();
        register_code(KC_RCTL);
      } else {
        unregister_code(KC_RCTL);
        if (timer_elapsed(my_hash_timer) < TAPPING_TERM) {
          SEND_STRING("(");
        }
      }
      return false;
    case ALT_RPRN:
      if (record->event.pressed) {
        my_hash_timer = timer_read();
        register_code(KC_RALT);
      } else {
        unregister_code(KC_RALT);
        if (timer_elapsed(my_hash_timer) < TAPPING_TERM) {
          SEND_STRING(")");
        }
      }
      return false;
    case ALT_ARRD:
      if (record->event.pressed) {
        my_hash_timer = timer_read();
        register_code(KC_LALT);
      } else {
        unregister_code(KC_LALT);
        if (timer_elapsed(my_hash_timer) < TAPPING_TERM) {
          unicode_input_start();
          register_hex(ARRD_HEX);
          unicode_input_finish();
        }
      }
      return false;
    case CTL_ARRR:
      if (record->event.pressed) {
        my_hash_timer = timer_read();
        register_code(KC_LCTL);
      } else {
        unregister_code(KC_LCTL);
        if (timer_elapsed(my_hash_timer) < TAPPING_TERM) {
          unicode_input_start();
          register_hex(ARRR_HEX);
          unicode_input_finish();
        }
      }
      return false;

    case VIM_B:
      if (record->event.pressed) {
        switch(VIM_QUEUE) {
          case KC_NO: VIM_BACK(); break;
          case VIM_D: VIM_DELETE_BACK(); break;
        }
      }
      return false;
    case VIM_D:
      if (record->event.pressed) {
        switch(VIM_QUEUE) {
          case KC_NO: SHIFTED ? vim_delete_line(true) : VIM_LEADER(VIM_D); break;
          case VIM_D: vim_delete_line(false); break;
        }
      }
      return false;
    case VIM_E:
      if (record->event.pressed) {
        switch (VIM_QUEUE) {
          case KC_NO: VIM_END(); break;
          case VIM_D: VIM_DELETE_END(); break;
        }
      }
      return false;
    case VIM_I:
      if (record->event.pressed) {
        switch (VIM_QUEUE) {
          case KC_NO: cmd(KC_LEFT); break;
          case VIM_D: VIM_LEADER(VIM_DI); break;
          case VIM_Y: VIM_LEADER(VIM_YI); break;
        }
      }
      return false;
    case VIM_H:
    case VIM_J:
    case VIM_K:
    case VIM_L:
      if (record->event.pressed) {
        uint16_t dir = KC_NO;
        switch (keycode) {
          case VIM_H: dir = KC_LEFT; break;
          case VIM_L: dir = KC_RIGHT; break;
          case VIM_K: dir = KC_UP; break;
          case VIM_J: dir = KC_DOWN; break;
        }
        vim_dir(dir);
      }
      return false;
    case VIM_W:
      if (record->event.pressed) {
        switch (VIM_QUEUE) {
          case KC_NO: VIM_WORD(); break;
          case VIM_D: VIM_DELETE_WORD(); break;
          case VIM_DI: VIM_DELETE_INNER_WORD(); break;
          case VIM_Y: vim_yank_word(true); break;
          case VIM_YI: vim_yank_word(false); break;
        }
      }
      return false;
    case VIM_Y:
      if (record->event.pressed) {
        switch(VIM_QUEUE) {
          case KC_NO: SHIFTED ? vim_yank_line(true) : VIM_LEADER(VIM_Y); break;
          case VIM_Y: vim_yank_line(false); break;
        }
      }
      return false;
  }
  return true;
}

// Runs just one time when the keyboard initializes.
void matrix_init_user(void) {
  set_unicode_input_mode(KEY_MODE);
};

LEADER_EXTERNS();

// Runs constantly in the background, in a loop.
void matrix_scan_user(void) {

  uint8_t layer = biton32(layer_state);

  LEADER_DICTIONARY() {
    leading = false;
    leader_end();

    SEQ_ONE_KEY(KC_S) { // ¯\_(ツ)_/¯
      send_unicode_hex_string("00AF 005C 005F 0028 30C4 0029 005F 002F 00AF");
    }
    SEQ_ONE_KEY(KC_D) { // ಠ_ಠ
      send_unicode_hex_string("0CA0 005F 0CA0");
    }
    SEQ_ONE_KEY(KC_T) { // (╯°□°)╯ ︵ ┻━┻
      send_unicode_hex_string("0028 256F 00B0 25A1 00B0 0029 256F 0020 FE35 0020 253B 2501 253B");
    }
    SEQ_ONE_KEY(KC_N) { // Name
      SEND_STRING("Michael");
    }
    SEQ_ONE_KEY(KC_L) { // Last Name
      SEND_STRING("Bagwell");
    }
    SEQ_ONE_KEY(KC_E) { // Email
      SEND_STRING("mlbagwell1@gmail.com");
    }
    SEQ_ONE_KEY(KC_Q) { // Email
      SEND_STRING("mike@quotapath.com");
    }
    SEQ_ONE_KEY(KC_P) { // Password not_a_secret
      SEND_STRING("not_a_secret");
    }
  }

  ergodox_board_led_off();
  ergodox_right_led_1_off();
  ergodox_right_led_2_off();
  ergodox_right_led_3_off();
  switch (layer) {
    // TODO: Make this relevant to the ErgoDox EZ.
    case SYMBOL:
      ergodox_right_led_1_on();
      break;
    case NUM:
      ergodox_right_led_2_on();
      break;
    case NAV:
      ergodox_right_led_3_on();
      break;
    default:
      // none
      break;
  }
};
