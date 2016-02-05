%=============================================
%   created by MuseScore Version: 1.3
%          domingo, 31 de janeiro de 2016
%=============================================

\version "2.12.0"



#(set-default-paper-size "a5")

\paper {
  line-width    = 120\mm
  left-margin   = 20\mm
  top-margin    = 10\mm
  bottom-margin = 20\mm
  %%indent = 0 \mm 
  %%set to ##t if your score is less than one page: 
  ragged-last-bottom = ##t 
  ragged-bottom = ##f  
  %% in orchestral scores you probably want the two bold slashes 
  %% separating the systems: so uncomment the following line: 
  %% system-separator-markup = \slashSeparator 
  }

\header {
    }

house = \relative c,{
    \set Staff.instrumentName = #"House bass"
    \set Staff.shortInstrumentName = #"house"

    \clef "bass"
    %staffkeysig 
    %bartimesig: 
    \time 4/4 
    \repeat volta 2{r2 r8 a''4.|
                    r2 r8 a4.  |
                    r1     |
                    r4 a2.     |
    } % 8
}% end of last bar in partorvoice

 

snare = \relative c{
    \set Staff.instrumentName = #"Snare drum"
    \set Staff.shortInstrumentName = #"snare"
    \clef percussion
    %staffkeysig 
    %bartimesig: 
    \time 4/4 
    \repeat volta 2{r4 f8 r4. c'8 r      |
                    r4 f,8 r4. c'8 r     |% 2
                    r2 f,4 r4            |
                    r2 c'4 r4
    } % 8
}% end of last bar in partorvoice

 

bassthree = \relative c{
    \set Staff.instrumentName = #"bass3"
    \set Staff.shortInstrumentName = #"B.3"
    \clef "bass"
    %staffkeysig 
    %bartimesig: 
    \time 4/4 
    \repeat volta 2{a2 r2      | % 2
                    a2 r2      |
                    a1      |
                    r1       |
   } % 8
}% end of last bar in partorvoice


\score { 
    << 
        \context Staff = ACbpartA << 
            \context Voice = house \house
        >>


        \context Staff = ASnDrpartB << 
            \context Voice = snare \snare
        >>


        \context Staff = ABDrpartC << 
            \context Voice = bassthree \bassthree
        >>

  >>

  %% Boosey and Hawkes, and Peters, have barlines spanning all staff-groups in a score,
  %% Eulenburg and Philharmonia, like Lilypond, have no barlines between staffgroups.
  %% If you want the Eulenburg/Lilypond style, comment out the following line:
  \layout {\context {\Score \consists Span_bar_engraver}}
}%% end of score-block 

