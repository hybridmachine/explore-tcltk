######
# Calculate the next generation based on the rules of John Conway's Game of Life
# Any live cell with fewer than two live neighbours dies, as if by underpopulation.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overpopulation.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
proc getNextGeneration { playBoard } {
    set nextGeneration $playBoard
    set rowIdx 0
    set colIdx 0
    puts [info level 0]
    foreach row $playBoard {
        set colIdx 0
        foreach col $row {
            
            set currentBitValue [lindex $playBoard $rowIdx $colIdx]
            
            set neighbourCount 0
            for {set rowOffset -1} {$rowOffset <= 1} {incr rowOffset} {
                for {set colOffset -1} {$colOffset <= 1} {incr colOffset} {
                    # Skip the self cell
                    if {$colOffset != 0 || $rowOffset != 0} {
                        set neighborRow [expr $rowIdx + $rowOffset]
                        set neighborCol [expr $colIdx + $colOffset]
                        set neighborVal [lindex $playBoard $neighborRow $neighborCol]
                        if { $neighborVal == "" } { 
                            set neighborVal 0 
                        }
                        
                        set neighbourCount [expr $neighbourCount + $neighborVal]
                    }       
                }
            }

            if { $currentBitValue == 1} {
                puts "$currentBitValue -- $neighbourCount"
                # Any live cell with fewer than two live neighbours dies, as if by underpopulation.
                if { $neighbourCount < 2 } { set nextGeneration [lset nextGeneration $rowIdx $colIdx 0] }
                # Any live cell with two or three live neighbours lives on to the next generation.
                # NoOp, it's already set
                # Any live cell with more than three live neighbours dies, as if by overpopulation.
                if { $neighbourCount > 3 } { set nextGeneration [lset nextGeneration $rowIdx $colIdx 0] }
            } else {
                # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
                if { $neighbourCount == 3 } { set nextGeneration [lset nextGeneration $rowIdx $colIdx 1] }
            }
            set colIdx [ expr $colIdx + 1 ]
        }
        set rowIdx [ expr $rowIdx + 1 ]
    }
    return $nextGeneration
}

proc testGetNextGeneration {} {
    source startingPatternLibrary.tcl
    source initializePlayBoard.tcl

    set testBoard [ initializePlayBoard 16 16 $r_pentomino ]
    set patternHeight [llength $testBoard]
    set nextGeneration [ getNextGeneration $testBoard ]
    set nextNextGeneration [ getNextGeneration $nextGeneration ]

    for {set row 0} {$row < $patternHeight} {incr row} {
        puts "$row-->\t[lindex $testBoard $row]"
    }

    puts "\n\n---------------------------------------------\n\n"

    for {set row 0} {$row < $patternHeight} {incr row} {
        puts "$row-->\t[lindex $nextGeneration $row]"
    }

    puts "\n\n---------------------------------------------\n\n"

    for {set row 0} {$row < $patternHeight} {incr row} {
        puts "$row-->\t[lindex $nextNextGeneration $row]"
    }
}