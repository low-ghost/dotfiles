#include "config.h"
#include "print.h"
#include "keycode.h"
#include "quantum.h"
#include "quantum_keycodes.h"

#define press(keycode) register_code16(keycode)
#define release(keycode) unregister_code16(keycode)

uint16_t VIM_QUEUE = KC_NO;

void tap(uint16_t keycode) {
  press(keycode);
  release(keycode);
}

void tap_while(uint16_t mod, uint16_t keycode) {
  press(mod);
  tap(keycode);
  release(mod);
}

void cmd(uint16_t keycode) {
  tap_while(KC_LGUI, keycode);
}

void CTRL(uint16_t keycode) {
  tap_while(KC_LCTRL, keycode);
}

void shift(uint16_t keycode) {
  tap_while(KC_LSHIFT, keycode);
}

void ALT(uint16_t keycode) {
  tap_while(KC_LALT, keycode);
}

void vim_select_line(bool is_partial) {
  if (!is_partial) {
    cmd(KC_LEFT);
  }
  press(KC_LSHIFT);
  cmd(KC_RIGHT);
  release(KC_LSHIFT);
}

/**
 * Sets the `VIM_QUEUE` variable to the incoming keycode.
 * Pass `KC_NO` to cancel the operation.
 * @param keycode
 */
void VIM_LEADER(uint16_t keycode) {
  VIM_QUEUE = keycode;
}

/***
 *     #######  #     #  #######       #####   #     #  #######  #######
 *     #     #  ##    #  #            #     #  #     #  #     #     #
 *     #     #  # #   #  #            #        #     #  #     #     #
 *     #     #  #  #  #  #####         #####   #######  #     #     #
 *     #     #  #   # #  #                  #  #     #  #     #     #
 *     #     #  #    ##  #            #     #  #     #  #     #     #
 *     #######  #     #  #######       #####   #     #  #######     #
 *
 */

/**
 * Vim-like `back` command
 * Simulates vim's `b` command by sending ⌥←
 */
void VIM_BACK(void) {
  ALT(KC_LEFT);
}

/**
 * Vim-like `end` command
 * Simulates vim's `e` command by sending ⌥→
 */
void VIM_END(void) {
  ALT(KC_RIGHT);
}

/**
 * Vim-like `delete left` or `delete right` command.
 * Simulates vim's `dh` command by sending ⇧← then ⌘X.
 */
void vim_delete_dir(uint16_t dir) {
  VIM_LEADER(KC_NO);
  shift(dir);
  cmd(KC_X);
}

/**
 * Vim-like `delete whole line` command
 * Simulates vim's `dd` command by sending ⌘← to move to start of line,
 * selecting the whole line, then sending ⌘X to cut the line.
 * alternate method: ⌘⌫, ⌃K
 */
void vim_delete_line(bool is_partial) {
  VIM_LEADER(KC_NO);
  if (!is_partial) {
    cmd(KC_LEFT);
  }
  vim_select_line(false);
  tap(KC_DEL);
  if (!is_partial) {
    tap(KC_DEL);
  }
}

void vim_select_line_vert(uint16_t dir) {
  dir == KC_UP ? cmd(KC_RIGHT) : cmd(KC_LEFT);
  press(KC_LSHIFT);
  tap(dir);
  dir == KC_UP ? cmd(KC_LEFT) : cmd(KC_RIGHT);
  release(KC_LSHIFT);
}

void vim_dir(uint16_t dir) {
  bool to_move = !VIM_QUEUE;
  // To Copy
  if (VIM_QUEUE == VIM_Y) {
    if (dir == KC_LEFT || dir == KC_RIGHT) {
      // One char
      shift(dir);
      cmd(KC_C);
    } else {
      // This and line above/below
      vim_select_line_vert(dir);
      cmd(KC_C);
    }
  }

  // To Delete
  if (VIM_QUEUE == VIM_D) {
    if (dir == KC_LEFT || dir == KC_RIGHT) {
      vim_delete_dir(dir);
    } else {
      // Delete up/down by selecting this + next line, then deleting
      // it and the blank line
      vim_select_line_vert(dir);
      tap(KC_DEL);
      tap(KC_DEL);
    }
  }
  VIM_LEADER(KC_NO);
  if (to_move) {
    tap(dir);
  }
}

/**
 * Vim-like `word` command
 * Simulates vim's `w` command by moving the cursor first to the
 * end of the current word, then to the end of the next word,
 * then to the beginning of that word.
 */
void VIM_WORD(void) {
  VIM_LEADER(KC_NO);
  press(KC_LALT);
  tap(KC_RIGHT);
  tap(KC_RIGHT);
  tap(KC_LEFT);
  release(KC_LALT);
}

/**
 * Vim-like `yank line` command
 * Simulates vim's `y` command by sending ⌘← then ⇧⌘→ then ⌘C
 */
void vim_yank_line(bool is_partial) {
  VIM_LEADER(KC_NO);
  vim_select_line(is_partial);
  cmd(KC_C);
}

/**
 * Vim-like `yank line` command
 * Simulates vim's `y` command by sending ⌘← then ⇧⌘→ then ⌘C
 */
void vim_yank_word(bool is_partial) {
  VIM_LEADER(KC_NO);
  if (!is_partial) {
    VIM_BACK();
  }
  press(KC_LALT);
  shift(KC_RIGHT); // select to end of this word
  release(KC_LALT);
  cmd(KC_C);
}

/***
 *     ######       ######   ######   #######  #######  ###  #     #  #######  ######
 *     #     #      #     #  #     #  #        #         #    #   #   #        #     #
 *     #     #      #     #  #     #  #        #         #     # #    #        #     #
 *     #     #      ######   ######   #####    #####     #      #     #####    #     #
 *     #     #      #        #   #    #        #         #     # #    #        #     #
 *     #     #      #        #    #   #        #         #    #   #   #        #     #
 *     ######       #        #     #  #######  #        ###  #     #  #######  ######
 *
 */

/**
 * Vim-like `delete to end` command
 * Simulates vim's `de` command by sending ⌥⇧→ then ⌘X.
 */
void VIM_DELETE_END(void) {
  VIM_LEADER(KC_NO);
  press(KC_LALT);
  shift(KC_RIGHT); // select to end of this word
  release(KC_LALT);
  cmd(KC_X);
}

/**
 * Vim-like `delete word` command
 * Simulates vim's `dw` command by sending ⌥⇧→→← then ⌘X to select to the start
 * of the next word then cut.
 */
void VIM_DELETE_WORD(void) {
  VIM_LEADER(KC_NO);
  press(KC_LALT);
  shift(KC_RIGHT); // select to end of this word
  shift(KC_RIGHT); // select to end of next word
  shift(KC_LEFT); // select to start of next word
  release(KC_LALT);
  cmd(KC_X); // delete selection
}

/**
 * Vim-like `delete back` command
 * Simulates vim's `db` command by selecting to the end of the word then deleting.
 */
void VIM_DELETE_BACK(void) {
  VIM_LEADER(KC_NO);
  press(KC_LALT);
  shift(KC_LEFT); // select to start of word
  shift(KC_DEL); // delete selection
  release(KC_LSHIFT);
}

/***
 *     ######   ###      ######   ######   #######  #######  ###  #     #  #######  ######
 *     #     #   #       #     #  #     #  #        #         #    #   #   #        #     #
 *     #     #   #       #     #  #     #  #        #         #     # #    #        #     #
 *     #     #   #       ######   ######   #####    #####     #      #     #####    #     #
 *     #     #   #       #        #   #    #        #         #     # #    #        #     #
 *     #     #   #       #        #    #   #        #         #    #   #   #        #     #
 *     ######   ###      #        #     #  #######  #        ###  #     #  #######  ######
 *
 */

/**
 * Vim-like `delete inner word` command
 * Simulates vim's `diw` command by moving back then cutting to the end of the word.
 */
void VIM_DELETE_INNER_WORD(void) {
  VIM_LEADER(KC_NO);
  VIM_BACK();
  VIM_DELETE_END();
}
