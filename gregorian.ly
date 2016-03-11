\include "gregorian.ly"

#(set-global-staff-size 52)
#(set-default-paper-size "a6")

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
      \[ c' c'\]
    }
    
    \new VaticanaVoice = "cantus2" {
      % bipunctus
      \clef "hufnagel-fa2"
       \[ g \flexa ees\]
    }
  >>
}