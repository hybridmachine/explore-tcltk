package require Tk

grid [tk::canvas .canvas] -sticky nwes -column 0 -row 0
grid columnconfigure . 0 -weight 1
grid rowconfigure . 0 -weight 1

bind .canvas <1> "set lastx %x; set lasty %y"
bind .canvas <B1-Motion> "addLine %x %y"

#.canvas create rectangle 10 10 200 50 -fill red -outline blue
.canvas create polygon 10 10 200 50 90 150 50 80 120 55 -fill red -outline blue

proc addLine {x y} {
    .canvas create line $::lastx $::lasty $x $y
    set ::lastx $x; set ::lasty $y
}