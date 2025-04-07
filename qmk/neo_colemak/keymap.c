/* clang-format off */
#include QMK_KEYBOARD_H
#include "action_layer.h"
#include "debug.h"
#include "version.h"
#include "keycodes/definitions.c"
#include "keycodes/unicode.c"
#include "keycodes/aliases.c"
#include "vim.h"

#define LEADER_PER_KEY_TIMING
// #define UNICODE_SELECTED_MODES UNICODE_MODE_MACOS

#define COLEMAK 0 // default layer
#define SYMBOL 1
#define NUM 2
#define NAV 3
#define FN 4

// Vim
/* #define TO_NORM TO(NORMAL_MODE) */

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [COLEMAK] = LAYOUT_ergodox(  // layer 0 : default
      /*
       * left hand
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |     |     |     |     |     |     |
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    | F18   |  Q  |  W  |  F  |  P  |  G  |     |
       *    +-------+-----+-----+-----+-----+-----+     |
       *    | F17   |SYM/A|GUI/R|ALT/S|CTL/T|  D  +-----+
       *    +-------+-----+-----+-----+-----+-----+     |
       *    | F16   |NUM/Z|  X  |  C  |  V  |  B  |     |
       *    +-+-----+-----+-----+-----+-----+-----+-----+
       *      |     |     |     |     |     |
       *      +-----+-----+-----+-----+-----+   +-----+--------+
       *                                        |DESK_L|DESK_R |
       *                                  +-----+-----+--------+
       *                                  |     |     |        |
       *                                  |SHFT/| ESC/+--------+
       *                                  |SPACE| NAV | TAB/FN |
       *                                  +-----+-----+--------+
       */
  _______, DM_REC1, DM_REC2, DM_PLY1, DM_PLY2, DM_RSTP,  _______,
  KC_F18,  KC_Q,    KC_W,    KC_F,    KC_P,    KC_G,     _______,
  KC_F17,  SYM_A,   GUI_R,   ALT_S,   CTL_KT,  KC_D,
  KC_F16,  NUM_Z,   KC_X,    KC_C,    KC_V,    KC_B,     _______,
  _______, _______, _______, _______, _______,
  DESK_L,  DESK_R,
  _______,
  LSFT_T(KC_SPC), LT(NAV, KC_ESC), LT(FN, KC_TAB),
  /* right hand
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |     |     |     |     |     |       |
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |  J  |  L  |  U  |  Y  |  ;  | F18   |
   *        |     +-----+-----+-----+-----+-----+-------+
   *        +-----+  H  |CTL/N|ALT/E|GUI/I|SYM/O| F17   |
   *        |     +-----+-----+-----+-----+-----+-------+
   *        |     |  K  |  M  |  ,  |  .  |NUM//| F16   |
   *        +-----+-----+-----+-----+-----+-----+-------+
   *                    |LEAD |     |     |     |     |
   *    +-----+-----+   +-----+-----+-----+-----+-----+
   *    |     |     |
   *    +-----+-----+-----+
   *    |     |     |SHFT/|
   *    +-----+BSPC | SPC |
   *    | LEAD|     |     |
   *    +-----+-----+-----+
   */
  _______, _______, _______, _______, _______, _______,  _______,
  _______, KC_J,    KC_L,    KC_U,    KC_Y,    KC_SCLN,  KC_F18,
           KC_H,    CTL_N,   ALT_E,   GUI_I,   SYM_O,    KC_F17,
  _______, KC_K,    KC_M,    KC_COMM, KC_DOT,  NUM_SLSH, KC_F16,
  QK_LEAD, _______, _______, _______,  _______,
  _______, _______,
  _______,
  QK_LEAD,  KC_BSPC, RSFT_T(KC_ENT)
    ),

  [SYMBOL] = LAYOUT_ergodox( // layer 1 : function layers
      /* left hand
       *    +-------+-----+-----+-----+-----+-----+-----+
   *        |       |     |     |     |     |     |     |
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
  _______, _______, _______,  _______,  _______,  _______, _______,
  _______, ELIP,    KC_UNDS,  KC_LBRC,  KC_RBRC,  KC_CIRC, _______,
  _______, KC_BSLS, GUI_SLSH, ALT_LCBR, CTL_RCBR, KC_ASTR,
  _______, KC_HASH, KC_DLR,   KC_PIPE,  KC_TILD,  KC_GRV,  _______,
  _______, _______, _______,  _______,  _______,
  _______, _______,
  _______,
  _______, _______, _______,
  /* right hand
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |     |     |     |     |     |       |
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |  !  |  <  |  >  |  =  |  &  |       |
   *        |     +-----+-----+-----+-----+-----+-------+
   *        +-----+  ?  |CTL/(|ALT/)|GUI/-|  '  |       |
   *        |     +-----+-----+-----+-----+-----+-------+
   *        |     |  +  |  %  |  ‽  |  @  |  /  |       |
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
  _______, _______,  _______,  _______,  _______,  _______, _______,
  _______, KC_EXLM,  KC_LT,    KC_GT,    KC_EQL,   KC_AMPR, _______,
  KC_QUES, CTL_LPRN, ALT_RPRN, GUI_MINS, KC_QUOT,  _______,
  _______, KC_PLUS,  KC_PERC,  BANG,     KC_AT,    _______, _______,
  _______, _______,  _______,  _______,  _______,
  _______, _______,
  _______,
  _______, _______, _______
    ),
  [NUM] = LAYOUT_ergodox(
      /* Left hand
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |     |     |     |     |     |     |
       *    +-------+-----+-----+-----+-----+-----+-----+
       *    |       |  ∞  |  ¢  |  ↑  |  ±  |  ⸮  |     |
       *    +-------+-----+-----+-----+-----+-----+     |
       *    |       | --  |  ←  |ALT/↓|CTL/→|  °  +-----+
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
  _______, _______, _______,  _______,  _______,  _______, _______,
  _______, INFI,    CENT,     ARRU,     PLMN,     IRONY,   _______,
  _______, EMDASH,  ARRL,     ALT_ARRD, CTL_ARRR, DEGR,
  _______, NSUM,    SQRT,     CHECK,    THFO,     BCUSE,   _______,
  _______, _______, _______,  _______,  _______,
  _______, _______,
  _______,
  _______, _______, _______,
  /* right hand
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |     |     |     |     |     |       |
   *        +-----+-----+-----+-----+-----+-----+-------+
   *        |     |  λ  |  7  |  8  |  9  |  =  |       |
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
  _______, _______, _______, _______, _______,  _______, _______,
  _______, LAMDA,   KC_7,    KC_8,    KC_9,     KC_EQL,  _______,
           KC_ASTR, KC_4,    KC_5,    KC_6,     KC_MINUS, _______,
  _______, KC_0,    KC_1,    KC_2,    KC_3,     DELT,    _______,
  KC_PLUS, KC_COMM, KC_DOT,  KC_SLSH, _______,
  _______, _______,
  _______,
  _______, _______, _______
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
  _______, _______, _______, _______, _______, _______, _______,
  _______, _______, VIM_W,   KC_PGDN, PASTE,   TOP,     _______,
  _______, END,     _______, _______, _______, VIM_D,
  _______, _______, KC_DEL,  _______, _______, VIM_B,   _______,
  _______, _______, _______,  _______, _______,
  _______, _______,
  _______,
  _______, _______, _______,
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
  _______, _______, _______, _______, _______, _______, _______,
  _______, VIM_J,   VIM_L,   KC_PGUP, VIM_Y,   _______, _______,
           VIM_H,   _______, VIM_E,   VIM_I,   _______, _______,
  _______, VIM_K,   _______, _______, _______, _______, _______,
  _______, _______, _______, _______, _______,
  _______, _______,
  _______,
  _______, _______, _______
    ),

  [FN] = LAYOUT_ergodox(
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
  _______, _______, _______, _______, _______, _______, _______,
  KC_F18,  QK_BOOT, KC_MPRV, KC_MPLY, KC_MNXT, KC_VOLU, _______,
  KC_F17,  KC_CAPP, KC_CAPW, KC_SLEP, KC_CPYW, KC_VOLD,
  KC_F16,  KC_CPYO, KC_BRID, KC_BRIU, KC_MCTL, KC_MUTE, _______,
  _______, _______, _______, _______, _______,
  _______, _______,
  _______,
  _______, _______, _______,
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
   *    |     |     |     
   *    +-----+     |     |
   *    |     |     |     |
   *    +-----+-----+-----+
   */
  _______, _______, _______, _______, _______, _______, _______,
  _______, KC_F12,  KC_F7,   KC_F8,   KC_F9,   KC_F15,  KC_F18,
           KC_F11,  KC_F4,   KC_F5,   KC_F6,   KC_F14,  KC_F17,
  _______, KC_F10,  KC_F1,   KC_F2,   KC_F3,   KC_F13,  KC_F16,
  _______, _______, _______, _______, _______,
  _______, _______,
  _______,
  _______, _______, _______
    ),
};

static uint16_t vim_dir_timer = 0;
static uint16_t vim_last_dir = 0;

void matrix_scan_user(void) {
  static uint16_t hash_timer;
  static int repeat_time;
  // allow for arrow key repeat
  if (vim_dir_timer && vim_last_dir) {
    hash_timer = timer_read();
    if (timer_expired(hash_timer, vim_dir_timer)) {
      if (vim_last_dir == VIM_B) {
        VIM_BACK();
      } else if (vim_last_dir == VIM_E) {
        VIM_END();
      } else {
        tap(vim_last_dir);
      }
      repeat_time = TAPPING_TERM / ((vim_last_dir == VIM_B || vim_last_dir == VIM_E) ? 1 : 4);
      // first repeat is tapping term, but subsequent are faster
      vim_dir_timer = hash_timer + repeat_time;
    }
  }
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  static uint16_t my_hash_timer;

  // if (!process_record_dynamic_macro(keycode, record)) {
  //   return false;
  // }

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
          case KC_NO:
            VIM_BACK();
            vim_dir_timer = (record->event.time + TAPPING_TERM) | 1;
            vim_last_dir = keycode;            
            break;
          case VIM_D: VIM_DELETE_BACK(); break;
        }
      } else {
        vim_dir_timer = 0;
        vim_last_dir = 0;
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
          case KC_NO:
            VIM_END();
            vim_dir_timer = (record->event.time + TAPPING_TERM) | 1;
            vim_last_dir = keycode;            
            break;
          case VIM_D: VIM_DELETE_END(); break;
        }
      } else {
        vim_dir_timer = 0;
        vim_last_dir = 0;
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
        if (vim_dir(dir)) {
          vim_last_dir = dir;
          vim_dir_timer = (record->event.time + TAPPING_TERM) | 1;
        }
      } else {
        vim_dir_timer = 0;
        vim_last_dir = 0;
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

// void alfred(const char program[]) {
//   SEND_STRING(SS_LGUI(" ") SS_DELAY(100));
//   send_string(program);
//   SEND_STRING("\n" SS_DELAY(100));
// }
void slack(bool with_k) {
  SEND_STRING(SLACK SS_DELAY(100));
  if (with_k) {
    SEND_STRING(SS_LCMD("k") SS_DELAY(100));
  }
}

void leader_end_user(void) {
  // e for emoji
  if (leader_sequence_two_keys(KC_E, KC_C)) {
    SEND_STRING(":white_check_mark:");
  }
  if (leader_sequence_two_keys(KC_E, KC_D)) { // dunno
    SEND_STRING(":shrug:");
  }
  else if (leader_sequence_two_keys(KC_E, KC_F)) {
    SEND_STRING(":fire:");
  }
  else if (leader_sequence_two_keys(KC_E, KC_U)) {
    SEND_STRING(":thumbsup:");
  }
  else if (leader_sequence_two_keys(KC_E, KC_S)) {
    SEND_STRING(":ship:");
  }
  if (leader_sequence_two_keys(KC_E, KC_T)) {
    SEND_STRING(":tada:");
  }
  else if (leader_sequence_two_keys(KC_E, KC_I)) { // ship<i>t
    SEND_STRING(":shipit:");
  }
  else if (leader_sequence_two_keys(KC_E, KC_R)) {
    SEND_STRING(":rocket:");
  }

   // applications
   // s for slack
  // else if (leader_sequence_two_keys(KC_S, KC_C)) { // cal via slack
  //   slack(true);
  //   SS_DELAY(100);
  //   SEND_STRING("cal\n");
  // }
  else if (leader_sequence_two_keys(KC_S, KC_K)) { // slack with cmd+k
    slack(true);
  }
//   else if (leader_sequence_two_keys(KC_S, KC_A)) { // unreads
//     slack(false);
//     SS_DELAY(100);
//     SEND_STRING(SS_LSFT(SS_LCMD("a")));
//   }
//   else if (leader_sequence_two_keys(KC_S, KC_S)) { // search slack
//     slack(false);
//     SS_DELAY(100);
//     SEND_STRING(SS_LCMD("g"));
//   }
  else if (leader_sequence_one_key(KC_S)) { // slack
    slack(false);
  }
  // g for google
  else if (leader_sequence_two_keys(KC_G, KC_G)) { // github
    SEND_STRING(GITHUB);
  }
  else if (leader_sequence_two_keys(KC_G, KC_P)) { // pull requests
    SEND_STRING(GPULLS);
  }
//   else if (leader_sequence_two_keys(KC_G, KC_S)) { // google search
//     SEND_STRING(CHROME SS_DELAY(100) SS_LGUI("t") SS_DELAY(100) SS_LCMD("l"));
//   }
  else if (leader_sequence_one_key(KC_G)) { // google
    SEND_STRING(CHROME);
  }
  else if (leader_sequence_one_key(KC_C)) { // cursor
    SEND_STRING(VSCODE);
  }

  else if (leader_sequence_three_keys(KC_T, KC_S, KC_E)) { // <e>scaped <s>hrug
    send_unicode_string("¯\\\\\\_(ツ)_/¯");
  }
  // else if (leader_sequence_three_keys(KC_T, KC_S, KC_S)) { // <s>lack <s>hrug
  //   send_unicode_string("¯\\_(ツ)_");
  //   SEND_STRING(SS_DELAY(200) SS_LCMD("z")); // or you get an italicized face
  //   send_unicode_string("/¯");
  // }
  else if (leader_sequence_two_keys(KC_T, KC_S)) {
    send_unicode_string("¯\\_(ツ)_/¯");
  }
  // not working…
  else if (leader_sequence_two_keys(KC_T, KC_D)) { 
    send_unicode_string("ಠ_ಠ");
  }
  else if (leader_sequence_two_keys(KC_T, KC_F)) {
    send_unicode_string("(╯°□°))╯ ︵ ┻━┻");
  }

  else if (leader_sequence_one_key(KC_N)) { // Name
    SEND_STRING("Michael");
  }
  else if (leader_sequence_one_key(KC_L)) { // Last Name
    SEND_STRING("Bagwell");
  }
  else if (leader_sequence_one_key(KC_M)) { // Email
    SEND_STRING("mlbagwell1@gmail.com");
  }
  else if (leader_sequence_one_key(KC_Q)) { // Work Email
    SEND_STRING("mike@quotapath.com");
  }

  else if (leader_sequence_one_key(KC_P)) { // Password not_a_secret
    SEND_STRING("not_a_secret");
  }
}

// Runs whenever there is a layer state change.
layer_state_t layer_state_set_user(layer_state_t state) {
    ergodox_board_led_off();
    ergodox_right_led_1_off();
    ergodox_right_led_2_off();
    ergodox_right_led_3_off();

    uint8_t layer = get_highest_layer(state);
    switch (layer) {
        case 0:
#ifdef RGBLIGHT_COLOR_LAYER_0
            rgblight_setrgb(RGBLIGHT_COLOR_LAYER_0);
#endif
            break;
        case 1:
            ergodox_right_led_1_on();
#ifdef RGBLIGHT_COLOR_LAYER_1
            rgblight_setrgb(RGBLIGHT_COLOR_LAYER_1);
#endif
            break;
        case 2:
            ergodox_right_led_2_on();
#ifdef RGBLIGHT_COLOR_LAYER_2
            rgblight_setrgb(RGBLIGHT_COLOR_LAYER_2);
#endif
            break;
        case 3:
            ergodox_right_led_3_on();
#ifdef RGBLIGHT_COLOR_LAYER_3
            rgblight_setrgb(RGBLIGHT_COLOR_LAYER_3);
#endif
            break;
        case 4:
            ergodox_right_led_1_on();
            ergodox_right_led_2_on();
#ifdef RGBLIGHT_COLOR_LAYER_4
            rgblight_setrgb(RGBLIGHT_COLOR_LAYER_4);
#endif
            break;
        case 5:
            ergodox_right_led_1_on();
            ergodox_right_led_3_on();
#ifdef RGBLIGHT_COLOR_LAYER_5
            rgblight_setrgb(RGBLIGHT_COLOR_LAYER_5);
#endif
            break;
        case 6:
            ergodox_right_led_2_on();
            ergodox_right_led_3_on();
#ifdef RGBLIGHT_COLOR_LAYER_6
            rgblight_setrgb(RGBLIGHT_COLOR_LAYER_6);
#endif
            break;
        case 7:
            ergodox_right_led_1_on();
            ergodox_right_led_2_on();
            ergodox_right_led_3_on();
#ifdef RGBLIGHT_COLOR_LAYER_7
            rgblight_setrgb(RGBLIGHT_COLOR_LAYER_7);
#endif
            break;
        default:
            break;
    }

    return state;
};

const uint16_t PROGMEM combo_tmux[] = {CTL_KT, KC_P, COMBO_END};
const uint16_t PROGMEM combo_vscode[] = {KC_L, CTL_N, COMBO_END};
combo_t key_combos[COMBO_COUNT] = {
    COMBO(combo_tmux, TMUX),
    COMBO(combo_vscode, VSCODE_DIR),
};
