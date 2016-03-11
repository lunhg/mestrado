\include "gregorian.ly"

#(set-global-staff-size 52)
#(set-default-paper-size "a5")
\paper {
  line-width    = 190\mm
  left-margin   = 0\mm
  top-margin    = 0\mm
  bottom-margin = 20\mm
  indent = 20 \mm 
  }
  
\score {
  <<
    \new VaticanaVoice = "cantus" {
      % bipunctus	
      \[ c' \pes d' c' \pes d' \]
      \[ d' \pes f' f' \pes g'\]
      \[ d' \pes ees' f' \flexa c'\]
    }
    \new VaticanaVoice = "cantus" {	
      \clef "hufnagel-fa2"
      \[ g \flexa f ees \pes f  \]
      \[ ees ees d \pes ees\]
      \[ f \pes g d \flexa ees\]
    }
  >>
}