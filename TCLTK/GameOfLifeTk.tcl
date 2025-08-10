###########################
# Game of Life in TCL rendered
# in a TK window
package require Tk

source initializePlayboard.tcl
source startingPatternLibrary.tcl
source getNextGeneration.tcl

set ::blockSquareSize 30
set playBoard [ initializePlayBoard 16 16 $glider_gun ]



proc drawOnCanvas {canvas playBoard} {
    set rowIdx 0
    set colIdx 0
    
    foreach row $playBoard {
        set colIdx 0
        foreach col $row {
            set bitValue [lindex $playBoard $rowIdx $colIdx]
            if { $bitValue == 1 } {
                set topLeft  "[expr ($::blockSquareSize * $colIdx)] [expr ($::blockSquareSize * $rowIdx)]" 
                set bottomRight  "[expr [lindex $topLeft 0] + $::blockSquareSize ] [expr [lindex $topLeft 1] + $::blockSquareSize ]"
                $canvas create rectangle "$topLeft $bottomRight" -fill red -outline white
                #puts "canvas create rectangle $topLeft $bottomRight -fill red -outline white"
            }
            set colIdx [ expr $colIdx + 1 ]
        }
        set rowIdx [ expr $rowIdx + 1 ]
    }
    
}

set canvasPixelHeight [expr [llength $playBoard] * $blockSquareSize + $blockSquareSize]
set canvasPixelWidth [expr [llength [lindex $playBoard 0]] * $blockSquareSize + $blockSquareSize]

ttk::frame .c -padding "3 3 12 12"
tk::canvas .c.canvas -borderwidth 5 -relief ridge -width $canvasPixelWidth -height $canvasPixelHeight
ttk::button .c.ok -text Okay
ttk::button .c.cancel -text Cancel

#.c.canvas create rectangle 10 10 30 30 -fill red -outline blue
drawOnCanvas .c.canvas $playBoard

grid .c -column 0 -row 0 -sticky nsew
grid .c.canvas -column 0 -row 0 -columnspan 2 -rowspan 2 -sticky nsew
grid .c.ok -column 0 -row 3
grid .c.cancel -column 1 -row 3


grid columnconfigure . 0 -weight 1
grid rowconfigure . 0 -weight 1
grid columnconfigure .c 0 -weight 1
grid columnconfigure .c 1 -weight 1
grid rowconfigure .c 1 -weight 1

