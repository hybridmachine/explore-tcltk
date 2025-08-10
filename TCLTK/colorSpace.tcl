# Routines from https://wiki.tcl-lang.org/page/HSV+and+RGB?R=0
proc rgbToHsv {r g b} {
    set temp  [expr {min($r, $g, $b)}]
    set value [expr {max($r, $g, $b)}]
    set range [expr {$value-$temp}]
    if {$range == 0} {
        set hue 0
    } else {
        if {$value == $r} {
            set top [expr {$g-$b}]
            if {$g >= $b} {
                set angle 0
            } else {
                set angle 360
            }
        } elseif {$value == $g} {
            set top [expr {$b-$r}]
            set angle 120
        } elseif {$value == $b} {
            set top [expr {$r-$g}]
            set angle 240
        }
        set hue [expr { round( double($top) / $range * 60 + $angle ) }]
    }

    if {$value == 0} {
        set saturation 0
    } else {
        set saturation [expr { round( 255 - double($temp) / $value * 255 ) }]
    }
    return [list $hue $saturation $value]
 }

 proc hsvToRgb {h s v} {
    set Hi [expr { int( double($h) / 60 ) % 6 }]
    set f [expr { double($h) / 60 - $Hi }]
    set s [expr { double($s)/255 }]
    set v [expr { double($v)/255 }]
    set p [expr { double($v) * (1 - $s) }]
    set q [expr { double($v) * (1 - $f * $s) }]
    set t [expr { double($v) * (1 - (1 - $f) * $s) }]
    switch -- $Hi {
        0 {
            set r $v
            set g $t
            set b $p
        }
        1 {
            set r $q
            set g $v
            set b $p
        }
        2 {
            set r $p
            set g $v
            set b $t
        }
        3 {
            set r $p
            set g $q
            set b $v
        }
        4 {
            set r $t
            set g $p
            set b $v
        }
        5 {
            set r $v
            set g $p
            set b $q
        }
        default {
            error "Wrong Hi value in hsvToRgb procedure! This should never happen!"
        }
    }
    set r [expr {round($r*255)}]
    set g [expr {round($g*255)}]
    set b [expr {round($b*255)}]
    return [list $r $g $b]
 }


 proc hls2rgb {h l s} {
    # h, l and s are floats between 0.0 and 1.0, ditto for r, g and b
    # h = 0   => red
    # h = 1/3 => green
    # h = 2/3 => blue

    set h6 [expr {($h-floor($h)) * 6}]
    set r [expr {($h6 <= 3) ? (2-$h6) : ($h6-4)}]
    set g [expr {($h6 <= 2) ? ($h6) :
                 ($h6 <= 5) ? (4-$h6) : ($h6-6)}]
    set b [expr {($h6 <= 1) ? (-$h6) :
                 ($h6 <= 4) ? ($h6-2) : (6-$h6)}]
    set r [expr {max(0.0, min(1.0, double($r)))}]
    set g [expr {max(0.0, min(1.0, double($g)))}]
    set b [expr {max(0.0, min(1.0, double($b)))}]

    set r [expr {(($r-1) * $s + 1) * $l}]
    set g [expr {(($g-1) * $s + 1) * $l}]
    set b [expr {(($b-1) * $s + 1) * $l}]
    return [list $r $g $b]
 }