#include QMK_KEYBOARD_H

extern keymap_config_t keymap_config;

#include "action_layer.h"
#include "debug.h"
#include "version.h"
#include "keycodes/definitions.c"
#include "keycodes/unicode.c"
#include "keycodes/aliases.c"
#include "vim.h"

#define KEY_MODE UC_OSX

#define COLEMAK 0 // default layer
#define SYMBOL 1
#define NUM 2
#define NAV 3

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* Qwerty
 *
 * ,----------------------------------.           ,----------------------------------.
 * |   Q  |   W  |   E  |   R  |   T  |           |   Y  |   U  |   I  |   O  |   P  |
 * |------+------+------+------+------|           |------+------+------+------+------|
 * |   A  |   S  |   D  |   F  |   G  |           |   H  |   J  |   K  |   L  |   ;  |
 * |------+------+------+------+------|           |------+------+------+------+------|
 * |   Z  |   X  |   C  |   V  |   B  |           |   N  |   M  |   ,  |   .  |   /  |
 * `----------------------------------'           `----------------------------------'
 *                  ,--------------------.    ,------,-------------.
 *                  | Ctrl | LOWER|      |    |      | RAISE| Shift|
 *                  `-------------| Space|    |BckSpc|------+------.
 *                                |      |    |      |
 *                                `------'    `------'
 */
[COLEMAK] = LAYOUT(
  KC_Q,    KC_W,    KC_F,    KC_P,    KC_G,      KC_J,    KC_L,    KC_U,    KC_Y,    KC_SCLN,
  SYM_A,   GUI_R,   ALT_S,   CTL_KT,  KC_D,      KC_H,    CTL_N,   ALT_E,   GUI_I,   SYM_O,
  NUM_Z,   KC_X,    KC_C,    KC_V,    KC_B,      KC_K,    KC_M,    KC_COMM, KC_DOT,  NUM_SLSH,
  KC_TAB,  LSFT_T(KC_SPC), LT(NAV, KC_ESC),      KC_BSPC, RSFT_T(KC_ENT), KC_DELT
),

/* Raise
 *
 * ,----------------------------------.           ,----------------------------------.
 * |   1  |   2  |   3  |   4  |   5  |           |   6  |   7  |   8  |   9  |   0  |
 * |------+------+------+------+------|           |------+------+------+------+------|
 * |  Tab | Left | Down |  Up  | Right|           |      |   -  |   =  |   [  |   ]  |
 * |------+------+------+------+------|           |------+------+------+------+------|
 * |  Ctrl|   `  |  GUI |  Alt |      |           |      |      |      |   \  |   '  |
 * `----------------------------------'           `----------------------------------'
 *                  ,--------------------.    ,------,-------------.
 *                  |      | LOWER|      |    |      | RAISE|      |
 *                  `-------------|      |    |      |------+------.
 *                                |      |    |      |
 *                                `------'    `------'
 */
[SYMBOL] = LAYOUT(
  ELIP,    KC_UNDS,  KC_LBRC,  KC_RBRC,  KC_CIRC,    KC_EXLM,  KC_LT,    KC_GT,    KC_EQL,   KC_AMPR,
  KC_BSLS, GUI_SLSH, ALT_LCBR, CTL_RCBR, KC_ASTR,    KC_QUES, CTL_LPRN, ALT_RPRN, GUI_MINS, KC_QUOT,
  KC_HASH, KC_DLR,   KC_PIPE,  KC_TILD,  KC_GRV,     KC_PLUS,  KC_PERC,  BANG,     KC_AT,    KC_TRNS,
                     _______, _______, _______,      _______, _______, _______
),




/* Lower
 *
 * ,----------------------------------.           ,----------------------------------.
 * |   !  |   @  |   #  |   $  |   %  |           |   ^  |   &  |   *  |   (  |   )  |
 * |------+------+------+------+------|           |------+------+------+------+------|
 * |  Esc |      |      |      |      |           |      |   _  |   +  |   {  |   }  |
 * |------+------+------+------+------|           |------+------+------+------+------|
 * |  Caps|   ~  |      |      |      |           |      |      |      |   |  |   "  |
 * `----------------------------------'           `----------------------------------'
 *                  ,--------------------.    ,------,-------------.
 *                  |      | LOWER|      |    |      | RAISE|  Del |
 *                  `-------------|      |    | Enter|------+------.
 *                                |      |    |      |
 *                                `------'    `------'
 */
[NUM] = LAYOUT(
  INFI,    KC_TRNS,  ARRU,     PLMN,     IRONY,     KC_TRNS, KC_7,    KC_8,    KC_9,    KC_EQL,
  KC_TRNS, ARRL,     ALT_ARRD, CTL_ARRR, DEGR,      KC_ASTR, KC_4,    KC_5,    KC_6,    KC_MINUS,
  NSUM,    SQRT,     CHECK,    THFO,     BCUSE,     KC_0,    KC_1,    KC_2,    KC_3,    DELT,
                    _______, _______, _______,      _______, _______, _______
),


/* Adjust (Lower + Raise)
 *
 * ,----------------------------------.           ,----------------------------------.
 * |  F1  |  F2  |  F3  |  F4  |  F5  |           |   F6 |  F7  |  F8  |  F9  |  F10 |
 * |------+------+------+------+------|           |------+------+------+------+------|
 * |  F11 |  F12 |      |      |      |           |      |      |      |Taskmg|caltde|
 * |------+------+------+------+------|           |------+------+------+------+------|
 * | Reset|      |      |      |      |           |      |      |      |      |      |
 * `----------------------------------'           `----------------------------------'
 *                  ,--------------------.    ,------,-------------.
 *                  |      | LOWER|      |    |      | RAISE|      |
 *                  `-------------|      |    |      |------+------.
 *                                |      |    |      |
 *                                `------'    `------'
 */
[NAV] =  LAYOUT(
  RESET, VIM_W, KC_PGDN, KC_TRNS, TOP,              VIM_J, VIM_L, KC_PGUP, VIM_Y, KC_TRNS,
  END, KC_TRNS, KC_TRNS, KC_TRNS, VIM_D,            VIM_H, KC_TRNS,  VIM_E, VIM_I, KC_TRNS,
  KC_TRNS, KC_TRNS, KC_TRNS, VIM_B, KC_TRNS,        VIM_K, KC_TRNS,  KC_TRNS, KC_TRNS, KC_TRNS,
                    _______, _______, _______,      _______,  _______, _______
)
};

void persistant_default_layer_set(uint16_t default_layer) {
  eeconfig_update_default_layer(default_layer);
  default_layer_set(default_layer);
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  static uint16_t my_hash_timer;

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
