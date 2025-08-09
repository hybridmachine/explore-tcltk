# Procedure to return an initialized playboard
package require struct::list

proc initializePlayBoard { width height initialPattern } {
    set rowList [string trim [string repeat "0 " $width]]
    set playBoard [list 0]  

    set initPatternHeight [llength $initialPattern] 
    set initPatternWidth [llength [lindex $initialPattern 0]]

    set patternRow [expr $height / 2 - ($initPatternHeight / 2)]
    set patternCol [expr $width / 2 - ($initPatternWidth / 2)]

    for {set row 0} {$row < $height} {incr row} {
        lset playBoard $row $rowList
    }

    for {set row 0} {$row < $initPatternHeight} {incr row} {
        set updateRowIdx [expr $row + $patternRow]
        set currentRow [lindex $playBoard $updateRowIdx]
        set updatedCols [lindex $initialPattern $row]
        set fromCol $patternCol
        set toCol [expr $patternCol + $initPatternWidth - 1]
        set updatedRow [lreplace $currentRow $fromCol $toCol $updatedCols]
        set flattenedUpdatedRow [struct::list flatten -full $updatedRow]

        lset playBoard $updateRowIdx $flattenedUpdatedRow
    }

    return $playBoard
}

proc testInitializePlayBoard {} {
    set r_pentomino {
        {0 1 1}
        {1 1 0}
        {0 1 0}
    }

    set glider_gun {
        {0 1 0}
        {0 0 1}
        {1 1 1}
    }

    set testBoard [ initializePlayBoard 32 32 $glider_gun ]
    set patternHeight [llength $testBoard]

    for {set row 0} {$row < $patternHeight} {incr row} {
        puts "$row-->\t[lindex $testBoard $row]"
    }
}