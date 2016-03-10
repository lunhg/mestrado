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
              \column { \with-color #red \small { ^ b5 } }
	    }^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ (b2) } }
	    }
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
	    \I ges,8\( bes8 ges8 bes8\)
	    s2
	    \I f8\( a8 f8 a8\) 
	    s2
	    \I e8\( g8 e8 g8\) 
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
	    \I c,8[_\markup { \with-color #(x11-color "red") \bold ? }
            s2..
	    \I c8_\markup { \with-color #(x11-color "red") \bold bVb2}
            s2..
	    \I c8_\markup { \with-color #(x11-color "red") \bold ii2}
            s2..
            \I c8]_\markup { \with-color #(x11-color "red") \bold I7 }
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
	    \stemDown
	    \override TextScript.extra-offset = #'(-11.75 . -12.25)
	    s1 s16
	    \I des'4 s8 
	    \I des4  s4 s8 
	    \I c4 s8
	    \I d4 s4 s8
	    \I bes4 s8
	    \I bes4 s4
	    \undo \hide Stem
	  }
	\\
	{
	    \override Beam.positions = #'(-4 . -4)
	    \hide NoteHead
	    \stemDown
	    s8
	    \hide Stem
	    \hide NoteHead
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
	    \undo \hide Stem
	    s2 s16
            % Add color to long beam text markups in bottom staff
	    \I des8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ b2 } }
	    }
            s4
	    \I des8]
	    s2
	    \I c8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 1 } }
	    }
            s4
	    \I d8]^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 2 } }
	    }
	    s2
	    \I bes8[^\markup {
	      \override #'(baseline-skip . 0.5)
              % Add color to markup in top staff
              \column { \with-color #red \small { ^ 7 } }
	    }
            s4
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
	    s2 s8
	    \I \hide NoteHead c,8\(
	    s4 
	    \I \undo \hide NoteHead c8\)
	    s2
	    \I \hide NoteHead c8\(
	    s4 
	    \I \undo \hide NoteHead c8\)
	    s2
	    \I \hide NoteHead c8\(
	    s8
	    \I \undo \hide NoteHead c8\)
	  }
	  {
	    s4 s8 \parenthesize c'8
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