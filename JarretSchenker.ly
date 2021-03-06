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
    \new Staff = "RH" { % Right hand
      \clef treble
      \key c \major
      \relative c'' {
	\override Staff.NoteCollision.merge-differently-headed = ##t
	<<

	\\
	
	\\
	{
	    \override Beam.positions = #'(8 . 8)
	    \hide NoteHead
	    \override NoteHead.duration-log = #1
	    s1 ges'8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { b5 } }
	    }^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ (b2) } }
	    }
	    
	    \undo \hide Stem
	    s2.. f8^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 4 } }
	    }
	    s4. s2 e8]^\markup {
              % Add color to markup in top staff
	      \override #'(baseline-skip . 0.5)
	      \column { \with-color #red \small { ^ 3 } }
	    }
	    s4.
	    \revert Beam.positions
	    \undo \hide NoteHead
	    \revert NoteHead.duration-log
	  }
	\\
	  {
            % Add color to both Dashed Slurs in top staff
            \override Slur.color = #(x11-color "purple")
	    \hide Stem
	    s1
	    \I ges2 s2
	    \I f2 s2
	    \I e2
	    s2
	    \undo \hide Stem
	  }
	\\
	  {
            % Add color to both Dashed Slurs in top staff
            % Add color to all remaining Slurs in top staff
            \override Slur.color = #(x11-color "violet")
            \override PhrasingSlur.color = #(x11-color "violet")
	    \hide Stem
	    \override Stem.length = #0
	    s1 s16
	    \I ges,8\( bes8^\markup {
	      \override #'(baseline-skip . 0.25)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 7 } }
	    } ges8 bes8\)
	    s2
	    \I f8\( a8^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 6 } }
	    } f8 a8\) 
	    s2 s16
	    \I e8\( g8^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 5 } }
	    } e8 g8\) 
	    \undo \hide Stem
	  }
	  \override Staff.NoteCollision.merge-differently-headed = ##t
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
	    \I c,8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 1 } }
	    }_\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \bold \small { C: } }
	    }
            s2..
	    \I c8_\markup { \with-color #(x11-color "red") \bold bV/(add11+)}
            s2..
	    \I c8_\markup { \with-color #(x11-color "red") \bold IV64}
            s2..
            \I c8]_\markup { \with-color #(x11-color "red") \bold I7}
	    \revert Beam.positions
	    \undo \hide NoteHead
	  }
	  
	\\
	{
	    \override Slur.color = #(x11-color "violet")
            \override PhrasingSlur.color = #(x11-color "green")
	    \hide Stem
	    \override Stem.length = #0
	    s8
	    des'8_\( 
	    \stemDown 
	    bes c,\)
	  }
	  {
	    \hide Stem
	    \stemDown
	    \override TextScript.extra-offset = #'(-11.75 . -12.25)
	    \I c2 s2 \I c2 s2 \I c2 s2 \I c2 s2
	    \undo \hide Stem
	  }
	\\
	{
	    \hide Stem
	    \override TextScript.extra-offset = #'(-11.75 . -12.25)
	    s1 s16
	    \I des'8 s 
	    \I des s16 
	    \I c s2
	    \I bes8 s
	    \I bes s16
	    \I c s2 s8 s16
	    \I c8
	  }
	\\
	{
	    \override Beam.positions = #'(-4 . -4)
	    \hide NoteHead
	    \hide Stem
	    s8
	    \I des8^\markup{
	      \override #'(baseline-skip . 0.5)
	      \column{ \with-color #red \small{ ^ b2}}
	    }
	    \I  bes^\markup{
	      \override #'(baseline-skip . 0.5)
	      \column{ \with-color #red \small{ ^ 7}}
	    }
	    \I  c^\markup{
	      \override #'(baseline-skip . 0.5)
	      \column{ \with-color #red \small{ ^ 1}}
	    }
	    s2 s16
            % Add color to long beam text markups in bottom staff
	    \I des8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ b2 } }
	    }
	    \hide NoteHead 
	    c8^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 1 } }
	    }
            s4 s16 s4 s8 s32 s32
	    \I bes8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ b7 } }
	    }
            s16
	    \I c8]^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 1 } }
	    }
	    \undo \hide NoteHead
	    s2 s8 s8
	    \I bes8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ b7 } }
	    }
            s8
	    \I bes8]
	    
	    \undo \hide NoteHead
	  }
	  \\
	  {
	    \override Slur.color = #(x11-color "blue")
            \override PhrasingSlur.color = #(x11-color "blue")
	    \hide Stem
	    \override TextScript.extra-offset = #'(-11.75 . -12.25)
	    s4 s16 s16
	    s2 s16
	    \I \hide NoteHead c,8\(
	    s8 
	    \I \undo \hide NoteHead c'8\)
	    s2 s16
	    \I \hide NoteHead c,8\(
	    s4 
	    \I \undo \hide NoteHead c'8\)
	    s2
	    \I \hide NoteHead c,8\(
	    s2 s16
	    \I \undo \hide NoteHead c'8^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 1 } }
	    }\)
	  }
	  {
	    s4 s8 \parenthesize c8
	  }
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