#!/bin/bash
# this script takes the numpad home, pgup, end, pgdn keys and rotates them such that the normal
# 7 home 9 pgup 
# 1 end 3 pgdn
# become
# 7 pgup 9 pgdn
# 1 home 3 end
set -euf
set -x


echo "rotating numpad home, pgup, end, and pgdn keys"
cat > ~/.Xmodmap2 << EOF
! -*- coding: utf-8 -*-
! what it does:
! set kp top-left to pgup
! set kp top-rigth to pgdn
! set pk bottom-left to home
! set pk bottom-right to end

! original settings:
! keycode  79 = KP_Home KP_7 KP_Home KP_7    <- top-left
! keycode  81 = KP_Prior KP_9 KP_Prior KP_9  <- top-right
! keycode  87 = KP_End KP_1 KP_End KP_1      <- bottom-left
! keycode  89 = KP_Next KP_3 KP_Next KP_3    <- bottom-right

! new mapping:
! top-left to pgup
keycode  79 = KP_Prior KP_7 KP_Prior KP_7
! top-right to pgdn
keycode 81 = KP_Next KP_9 KP_Next KP_9
! bottom-left to home
keycode 87 = KP_Home KP_1 KP_Home KP_1
! bottom-right to end
keycode 89 = KP_End KP_3 KP_End KP_3
EOF
