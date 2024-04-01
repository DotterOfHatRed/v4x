/*
 * Copyright (c) 2024 Rooks
 * 
 * SPDX-License-Identifier: MIT
 */

#include <behaviors.dtsi>
#include <dt-bindings/zmk/keys.h>
#include <dt-bindings/zmk/mouse.h>
#include <dt-bindings/zmk/bt.h>
#include <dt-bindings/zmk/outputs.h>

#define AS(keycode) &as LS(keycode) keycode     // Autoshift Macro
#define ASI(keycode) &as keycode LS(keycode)     // Autoshift Macro inverted
#define BAS_L 0
#define NAV_L 1
#define NUM_L 2
#define GAME_L 3
#define DONE_L 4
#define DTWO_L 5
#define DTHR_L 6

#define KEYS_L 0 1 2 3  4   12 13 14 15 16  24 25 26 27 28
#define KEYS_R 7 8 9 10 11  19 20 21 22 23  31 32 33 34 35

#define THUMBS 37 38 39 40 41 42

// Using layer taps on thumbs, having quick tap as well helps w/ repeating space/backspace
&lt { quick_tap_ms = <200>; };

#define BT(n) BT_SEL n

/ {
    chosen {
       zmk,matrix_transform = &ortho_transform;
    };

    behaviors {
        hml: hrm_left {
            compatible = "zmk,behavior-hold-tap";
            #binding-cells = <2>;
            flavor = "balanced";
            tapping-term-ms = <200>;
            quick-tap-ms = <150>;
            bindings = <&kp>, <&kp>;
            hold-trigger-key-positions = <KEYS_R THUMBS>;
            hold-trigger-on-release;
        };
        hmr: hrm_right {
            compatible = "zmk,behavior-hold-tap";
            #binding-cells = <2>;
            flavor = "balanced";
            tapping-term-ms = <200>;
            quick-tap-ms = <150>;
            bindings = <&kp>, <&kp>;
            hold-trigger-key-positions = <KEYS_L THUMBS>;
            hold-trigger-on-release;
        };
        as: auto_shift {
            compatible = "zmk,behavior-hold-tap";
            #binding-cells = <2>;
            tapping_term_ms = <135>;
            quick_tap_ms = <0>;
            flavor = "tap-preferred";
            bindings = <&kp>, <&kp>;
        };
    };

    keymap {
        compatible = "zmk,keymap";

        base_layer {
            label = "Base";
            bindings = <
&kp Q         &kp W         &kp F          &kp P           &kp B       &kp C_VOL_UP    &bt BT(0)     &kp J      &kp L          &kp U          &kp Y         &kp QUOT
&hml LGUI A   &hml LALT R   &hml LCTRL S   &hml LSHFT T    &kp G       &kp C_MUTE      &bt BT(1)     &kp M      &hmr LSHFT N   &hmr LCTRL E   &hmr LALT I   &hmr LGUI O   
&kp Z         &kp X         &kp C          &kp D           &kp V       &kp C_VOL_DN    &bt BT(2)     &kp K      &kp H          &kp COMMA      &kp DOT       &kp FSLH
                  &kp ESC        &lt NAV_L SPACE &lt NUM_L TAB        &to BAS_L                             &to GAME_L            &kp RET    &kp BKSP       &kp DEL
            >;
        };
        navigate_layer {
            label = "Navigate";
            bindings = <
&mmv MOVE_LEFT &mmv MOVE_DOWN &mmv MOVE_UP &mmv MOVE_RIGHT &kp HOME    &trans &trans     &kp PG_UP &none &none &none &none
&kp LEFT       &kp DOWN       &kp UP       &kp RIGHT       &none       &trans &trans     &none &kp LSHFT &kp LCTRL &kp LALT &kp LGUI
&msc SCRL_LEFT &msc SCRL_DOWN &msc SCRL_UP &msc SCRL_RIGHT &kp END     &trans &trans     &kp PG_DN &none    &none    &none    &none     
&none &none &none       &trans    &trans              &mkp LCLK &mkp MCLK &mkp RCLK 
            >;
        };
        number_layer {
            label = "Numbers";
            bindings = <
AS(GRAVE) AS(N7) AS(N8) AS(N9) ASI(EQUAL)   &trans &trans    &none &kp F7 &kp F8 &kp F9 &kp F10
AS(SEMI)  AS(N4) AS(N5) AS(N6) AS(N0)       &trans &trans    &none &kp F4 &kp F5 &kp F6 &kp F11
&kp PSCRN AS(N1) AS(N2) AS(N3) AS(MINUS)    &trans &trans    &none &kp F1 &kp F2 &kp F3 &kp F12

           &none &none &none    &trans    &trans             AS(LEFT_BRACKET) AS(BACKSLASH) AS(RIGHT_BRACKET)
            >;
        };
    };
};
