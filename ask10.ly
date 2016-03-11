\include "gregorian.ly"

#(set-global-staff-size 42)
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
      \[ c' c' f' \flexa c' \]
      \[ ees' \flexa d' \flexa f' aes' \flexa g'\]
      \[ees' \pes f'  \flexa d' f' \flexa c'\]
      \[g' \pes a' \flexa d' ees' \flexa c'  \] 
      \[bes g' \flexa f' e' \flexa d' c' \]
    }
    \new VaticanaVoice = "cantus" {	
      \clef "hufnagel-fa2"
      \[ g g bes \flexa e \]
      \[ g \pes bes  ees \pes d \flexa ees \]
      \[ bes, \pes ees \flexa c \]
      \[ ees \pes bes g \pes aes \flexa g\]
      \[ \virga aes \inclinatum ees  \inclinatum d g \flexa ees \]
    }
  >>
}