/* clang-format off */
#define TMUX     LCTL(KC_A)
#define CTL_ESC  CTL_T(KC_ESC)
#define SYM_A    LT(SYMBOL, KC_A)
#define ALT_S    ALT_T(KC_S)
#define CTL_KT   CTL_T(KC_T)
#define NUM_Z    LT(NUM, KC_Z)
#define GUI_R    GUI_T(KC_R)
#define LT_NAV   LT(NAV, LCTL(KC_A))
#define GUI_SLSH GUI_T(KC_SLSH)
#define PASTE    LGUI(KC_V)

#define CTL_N    RCTL_T(KC_N)
#define ALT_E    RALT_T(KC_E)
#define GUI_I    RGUI_T(KC_I)
#define SYM_O    LT(SYMBOL, KC_O)
#define NUM_SLSH LT(NUM, KC_SLSH)
#define GUI_MINS GUI_T(KC_MINS)
// Mac shortcuts
#define NEXT     RGUI(KC_TAB)
#define DESK_L   LCTL(KC_LEFT)
#define DESK_R   LCTL(KC_RIGHT)
#define HOME     RGUI(KC_LEFT)
#define END      RGUI(KC_RIGHT)
#define TOP      RGUI(KC_UP)
// Fns 
#define CHROME   SS_TAP(X_F14)
#define GITHUB   SS_LCMD(CHROME)
#define GPULLS   SS_LCTL(CHROME)
#define SLACK    SS_TAP(X_F15)
#define VSCODE   SS_TAP(X_F19)
#define VSCODE_DIR   KC_F19

// LCTL(kc)	C(kc)	Hold Left Control and press kc
// LSFT(kc)	S(kc)	Hold Left Shift and press kc
// LALT(kc)	A(kc), LOPT(kc)	Hold Left Alt and press kc
// LGUI(kc)	G(kc), LCMD(kc), LWIN(kc)	Hold Left GUI and press kc
// RCTL(kc)		Hold Right Control and press kc
// RSFT(kc)		Hold Right Shift and press kc
// RALT(kc)	ROPT(kc), ALGR(kc)	Hold Right Alt (AltGr) and press kc
// RGUI(kc)	RCMD(kc), RWIN(kc)	Hold Right GUI and press kc
// LSG(kc)	SGUI(kc), SCMD(kc), SWIN(kc)	Hold Left Shift and Left GUI and press kc
// LAG(kc)		Hold Left Alt and Left GUI and press kc
// RSG(kc)		Hold Right Shift and Right GUI and press kc
// RAG(kc)		Hold Right Alt and Right GUI and press kc
// LCA(kc)		Hold Left Control and Alt and press kc
// LSA(kc)		Hold Left Shift and Left Alt and press kc
// RSA(kc)	SAGR(kc)	Hold Right Shift and Right Alt (AltGr) and press kc
// RCS(kc)		Hold Right Control and Right Shift and press kc
// LCAG(kc)		Hold Left Control, Alt and GUI and press kc
// MEH(kc)		Hold Left Control, Shift and Alt and press kc
// HYPR(kc)		Hold Left Control, Shift, Alt and GUI and press kc
// KC_MEH		Left Control, Shift and Alt
// KC_HYPR		Left Control, Shift, Alt and GUI
