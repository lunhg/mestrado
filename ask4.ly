%=============================================
%   created by MuseScore Version: 1.3
%          sexta-feira, 22 de janeiro de 2016
%=============================================

\version "2.12.0"



#(set-default-paper-size "a5")

\paper {
  line-width    = 190\mm
  left-margin   = 0\mm
  top-margin    = 0\mm
  bottom-margin = 20\mm
  indent = 20 \mm 
  %%set to ##t if your score is less than one page: 
  ragged-last-bottom = ##t 
  ragged-bottom = ##f  
  %% in orchestral scores you probably want the two bold slashes 
  %% separating the systems: so uncomment the following line: 
  %% system-separator-markup = \slashSeparator 
  }

\header {
}

AvoiceAA = \relative c'{
    \set Staff.instrumentName = #""
    \set Staff.shortInstrumentName = #""
    \clef treble
    \key c \major  
    \time 2/4 
    c4 d8 r8 |
    c4 d8 r8 |
    d4 f8 r8 |
    f4 g8 r8 |
    d4 ees8 r8 |
    f4 c8 r8 |
    \bar "|." 
% end of last bar in partorvoice
}

AvoiceBA = \relative c{
    \set Staff.instrumentName = #""
    \set Staff.shortInstrumentName = #""
    \clef bass
    %staffkeysig
    \key c \major 
    %barkeysig: 
    \key c \major 
    %bartimesig: 
    \time 2/4 
    g'4-> \f f8-_ \p r8 |
    ees4-> \f f8-_\p r8 |
    f4-> \f f8-_ \p r8  |
    d4-> \f ees8-_\p r8 |
    f4-> \f g8-_\p r8   |
    d4-> \f ees8-_\p r8 \bar "|."
}% end of last bar in partorvoice




\score { 
    << 
        \context PianoStaff <<
        \set PianoStaff.instrumentName="Piano" 
            \context Staff = ApartA << 
               \context Voice = ApartA << \AvoiceAA >>
            >>

            \context Staff = ApartB << 
               \context Voice = ApartC << \AvoiceBA >>
            >>
        >> %end of PianoStaffA

  >>

  %% Boosey and Hawkes, and Peters, have barlines spanning all staff-groups in a score,
  %% Eulenburg and Philharmonia, like Lilypond, have no barlines between staffgroups.
  %% If you want the Eulenburg/Lilypond style, comment out the following line:
  \layout {\context {\Score \consists Span_bar_engraver}}
}%% end of score-block 
