\include "gregorian.ly"

#(set-global-staff-size 36)
#(set-default-paper-size "a8")

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
      \[ g \flexa ees \]
      \[g \flexa d\]
      \[ g \flexa d\]
      \[ ees ees \]
    }
  >>
}