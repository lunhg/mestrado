% -*-coding: utf-8 -*-

% See http://kris.shaffermusic.com/tech.html. for more information

% 'Add color...' sections are not the original author's, but added
% afterwards specifically for illustration in LilyPond's Documentation.
#(set-global-staff-size 20)
#(set-default-paper-size "a5")

I = \once \override NoteColumn.ignore-collision = ##t

\version "2.17.30"

staffPiano = \new PianoStaff {
  \set Score.timing = ##f
  \set PianoStaff.followVoice = ##t
  <<
    
    \new Staff = "RH" { % Left hand
      \key c \major
      \relative c' {
	\override Staff.NoteCollision.merge-differently-headed = ##t
	<<
	  {
	    \override Beam.positions = #'(8 . 8)
	    \hide NoteHead
	    \stemUp
            % Add color to long beam text markups in bottom staff
	    c8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 1 } }
	    }
            s4 s8
	    d8^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 2 } }
	    }
            s4 s8
	    c8]^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 1 } }
	    }
	    \undo \hide NoteHead
	  }
	  
	\\
	  {
	    \hide Stem
	    \stemDown
	    \override TextScript.extra-offset = #'(-11.75 . -12.25)
	    c2 d2 c2
	  }
	\\
	{
	    \hide Stem
	    \stemDown
	    \override TextScript.extra-offset = #'(-11.75 . -12.25)
	    
	    \hide NoteHead
	    s4 s4 s128 g'8\( 
	    \undo \hide NoteHead
	    s16 g16 f ees d \)
	    \hide NoteHead
	    
	  }
	\\
	>>
	\bar "|."
      }
    }

    \new Staff = "LH" { % Left hand
      \clef bass
      \key c \major
      \relative c' {
	\override Staff.NoteCollision.merge-differently-headed = ##t
	<<
	  {
	    \override Beam.positions = #'(-8 . -8)
	    \hide NoteHead
	    \stemDown
            % Add color to long beam text markups in bottom staff
	    \I g8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 5 } }
	    }_\markup { \with-color #(x11-color "red") \bold C:i64}
            s4 s8
	    \I b,8^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ (5) } }
	    }_\markup { \with-color #(x11-color "red") \bold 'v/iv}
            s4 s8
	    \I ees8]^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 3 } }
	    }_\markup { \with-color #(x11-color "red") \bold i6}
	    \revert Beam.positions
	    \undo \hide NoteHead
	  }
	  
	  
	\\
	  {
	    \hide Stem
	    \stemDown
	    \override TextScript.extra-offset = #'(-11.75 . -12.25)
	    g2 bes,2 ees2
	    \undo \hide Stem
	  }
	\\
	\\
	>>
	\bar "|."
      }
    }
  >>
}

\score {
  <<
    \staffPiano
  >>
  \layout {
    indent = 0.0
    ragged-right = ##f
    \context { \Staff \remove "Time_signature_engraver" }
  }
}