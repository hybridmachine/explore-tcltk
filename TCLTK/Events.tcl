package require Tk
grid [ttk::frame .frame]
grid [ttk::label .frame.l -text "Starting..."]
grid [ttk::button .frame.b -text "Something..."]
.frame configure -borderwidth 2 -relief sunken
.frame configure -padding "5 7 10 12" ;# left: 5, top: 7, right: 10, bottom: 12
bind .frame.l <Enter> {.frame.l configure -text "Moved mouse inside"}
bind .frame.l <Leave> {.frame.l configure -text "Moved mouse outside"}
bind .frame.l <ButtonPress-1> {.frame.l configure -text "Clicked left mouse button"}
bind .frame.l <3> {.frame.l configure -text "Clicked right mouse button"}
bind .frame.l <Double-1> {.frame.l configure -text "Double clicked"}
bind .frame.l <B3-Motion> {.frame.l configure -text "right button drag to %x %y"}
bind . <KeyPress> {.frame.l configure -text "A B"}
vwait forever