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
     \[ g g bes \flexa e \]
      \[ g \pes bes \]
      \[ ees \pes d \flexa ees \]
      \[ bes, \augmentum \pes ees \flexa c \]
      \[ ees \pes bes\]
      \[ g \pes aes \flexa g\]
      \[ \virga aes \inclinatum ees  \inclinatum d \]
      \[ g \flexa ees \]
    }
  >>
}