#(set-default-paper-size "a5")

\paper {
  line-width    = 190\mm
  left-margin   = 10\mm
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

AvoiceAA = \relative c'{
    \set Staff.instrumentName = #""
    \set Staff.shortInstrumentName = #""
    \clef treble
    \key c \major  
    \time 3/4 
    \repeat volta 2{
    r2.        | % 1
    r2.      |} % 2
    \repeat volta 2{
    r8 ges'\f\>  bes ges bes ges      | % 3
    bes ges bes ges bes ges  |% end of repeatactive
    bes2.\!\pp     | % 5
    r8\f\>  ges bes ges bes ges      | % 6
    bes ges bes ges bes ges\!\pp |       % 7
    r\f\>  f a f a f\pp\!      | % 8
    r\f\>  e g e g e |  % end of repeatactive
         %| % 9
    r8 e g e g e\pp\!\fermata  |}
    \bar "|." 
% end of last bar in partorvoice
}
 
AvoiceAC = \relative c'{
  \stemUp
  \slurUp
    s2.
    | % 1
    s2.      
    | % 2
    \repeat volta 2{
    ges''2.(  
    | % 3
    \stemDown ges)(  % end of repeatactive
    | % 4
    ges\fermata)       
    |
    }% 5
    \repeat volta 2{ges2.(      | % 6
    ges2.)      | % 7
    f2.      | % 8
    e2.(  % end of repeatactive
         | % 9
    e2.) \bar "|."} 
}% end of last bar in partorvoice


AvoiceBA = \relative c{
    \set Staff.instrumentName = #""
    \set Staff.shortInstrumentName = #""
    \clef bass
    %staffkeysig
    \key c \major 
    %barkeysig: 
    \key c \major 
    %bartimesig: 
    \time 3/4 
    \stemDown
    r8 \pp c4. r8 c~ 
     | % 1
    c4 r8 c4.\fermata      | % 2
    c2.      | % 3      | % 3
    r2.  | % end of repeatactive  %startrep 
    r2. \pp      | % 5
    r8 des' bes c bes des     | % 6
    bes c des c des c      | % 7
    \stemUp
    r8 bes c bes c bes      | % 8
    r8 bes c bes c bes  % end of repeatactive
         | % 9
    c bes c bes c bes \bar "|."
}% end of last bar in partorvoice

 
AvoiceBD = \relative c{
  \stemUp
    r4 des'8( bes c) r  
     | % 1
    des( bes c2\fermata) |
    \stemDown
    r8 \f des bes c bes des      | % 3 
    bes c des c des c~    |
    c2.      | % 5
    c,2.      | % 6
    s2.      | % 7
    c2.      | % 8
    c2.     | % 9
    s2. \bar "|." 
}% end of last bar in partorvoice



\score { 
    << 
        \context PianoStaff <<
        \set PianoStaff.instrumentName="Piano" 
            \context Staff = ApartA << 
               \context Voice = ApartA << \AvoiceAA >>
               \context Voice = ApartB << \AvoiceAC >>
            >>

            \context Staff = ApartB << 
              \context Voice = ApartD << \AvoiceBD >>
               \context Voice = ApartC << \AvoiceBA >>
               
            >>
        >> %end of PianoStaffA

  >>

  %% Boosey and Hawkes, and Peters, have barlines spanning all staff-groups in a score,
  %% Eulenburg and Philharmonia, like Lilypond, have no barlines between staffgroups.
  %% If you want the Eulenburg/Lilypond style, comment out the following line:
  \layout {\context {\Score \consists Span_bar_engraver}}
}%% end of score-block 
