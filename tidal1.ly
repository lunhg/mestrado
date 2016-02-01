%=============================================
%   created by MuseScore Version: 1.3
%          domingo, 31 de janeiro de 2016
%=============================================

\version "2.12.0"



#(set-default-paper-size "a5")

\paper {
  line-width    = 100\mm
  left-margin   = 32.5\mm
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

ASnDrvoiceBA = \relative c{
    \set Staff.instrumentName = #"Snare drum"
    \set Staff.shortInstrumentName = #"snare"
    \clef percussion
    \time 4/4 
    \repeat volta 2{
      r2. b'4   | % 2
      r2. b4    | % 4
    } % 8

}% end of last bar in partorvoice

 

ABDrvoiceCA = \relative c{
    \set Staff.instrumentName = #"bass3"
    \set Staff.shortInstrumentName = #"B.3"
    \clef "bass"
    \time 4/4 
    \repeat volta 2 {
      a4 r4 r8 a8 r4 | % 3
      a4 r4 r8 a8 r4| % 3
    } % 8
}% end of last bar in partorvoice


\score { 
    << 
        \context Staff = ASnDrpartB << 
            \context Voice = ASnDrvoiceBA \ASnDrvoiceBA
        >>

        \context Staff = ABDrpartC << 
            \context Voice = ABDrvoiceCA \ABDrvoiceCA
        >>
  >>

  %% Boosey and Hawkes, and Peters, have barlines spanning all staff-groups in a score,
  %% Eulenburg and Philharmonia, like Lilypond, have no barlines between staffgroups.
  %% If you want the Eulenburg/Lilypond style, comment out the following line:
  \layout {\context {\Score \consists Span_bar_engraver}}
}%% end of score-block 

