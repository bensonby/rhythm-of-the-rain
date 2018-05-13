\version "2.18.2"
\include "articulate.ly"
#(set-global-staff-size 16)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

makeOctaves = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cr = \change Staff = "right"
cl = \change Staff = "left"
rhMark = \markup { 
  \path #0.1 #'((moveto -1 0)(rlineto 0 -1.5)(rlineto 0.5 0))
}

\header {
  title = "魏如昀 - 聽見下雨的聲音"
  subtitle = "For female vocal and piano accompaniment"
  arranger = "Arranged by Benson"
}

melody-verse-one = \relative c' {
	r2 r4
	a8\(
	\time 9/8
	b8 b b a b4 e cis8\)
	\time 7/8
	r2 r4 a8\(
	\time 9/8
	b8 b b a b4 e a,8\)
	\time 4/4
	r2 r8 e'4\( cis8
	\time 7/8
	r2 fis4 b,8~
	\time 9/8
	b8 cis4 a8~ a4 cis fis,8
	\time 7/8
	r2 cis'4 b8\)

	r2 r4 a8\(
	\time 9/8
	b8 b b a b4 e cis8\)
	\time 7/8
	r2 r4 a8\(
	\time 9/8
	b8 b b a b4 e a,8\)
	\time 4/4
	r2 r8 e'4\( cis8
	\time 7/8
	r2 fis4 b,8~
	\time 9/8
	b8 cis4 a8~ a4 cis fis,8
	\time 7/8
	r2 fis8 a e'~
	\time 9/8
	e8 cis b a e'4 gis, a8\)
}

melody-bridge-one = \relative c' {
	\time 9/8
	r4 r8 cis\( d4 cis gis'8\)
	r4 r8 cis,\( d4 cis gis'8\)
	r4 r8 fis\( gis4 a cis,8\)
	\time 4/4
	r2 r4 fis8\( gis
	\time 5/4
	a4 d,8 cis d4 a' a
	r4 e8 cis e4 a a
	\time 11/8
	r4 a8 fis a4 cis cis4.(
	\time 9/8
	b4)\)  r4 r4 r4 r8
}

melody-chorus-one = \relative c'' {
	\time 4/4
	r4 r8 b\( b a gis a~
	\time 9/8
	a4 cis,8 e~ e b'4 b\)
	\time 4/4
	r4 r8 b\( b a gis a~
	\time 9/8
	a4 cis,8 e~ e b'4 b\)
	\time 4/4
	r4 r8 a\( a b a cis~
	\time 7/8
	cis2 d8 cis a\)
	\time 4/4
	r4 r8 a\( a b a cis~
	\time 7/8
	cis2 fis,8 cis' b\)
	\time 4/4
	r4 r8 b\( b a gis a~
	\time 9/8
	a4 cis,8 e~ e b'4 b\)
	\time 4/4
	r4 r8 b\( b a gis a~
	\time 9/8
	a4 cis,8 e~ e b'4 b\)
	\time 4/4
	r4 r8 a\( a b a cis~
	\time 7/8
	cis2 d8 cis a\)
	\time 4/4
	r4 r8 a\( a b a cis~
	\time 9/8
	cis2 fis,4 cis' b8\)
	r4 a8 gis4 a a
}

melody = \relative c' {
	\key a \major
	\time 7/8
  \tempo 4 = 84
  \melody-verse-one
  \melody-bridge-one
  \melody-chorus-one
}

lower-verse-one = \relative c' {

  R2..

  \time 9/8
  a8 e' a b cis e b cis e
  \time 7/8
  b8 a e d cis e b
  \time 9/8
  fis8 e' a b cis e b cis e
  \time 4/4
  cis8 gis b fis a gis fis e
  \time 7/8
  d8 b' cis e a, fis b,
  \time 9/8
  cis8 e b' cis d, b' fis a a,
  \time 7/8
  b8 a' cis fis, a cis, d

  e gis a b cis d e
}

upper = \relative c' {
  \clef treble
  \tempo 4 = 84
  % \time 3/4
  \key a \major
  % \bar "|."
}

lower = \relative c {
  \clef treble
  \time 7/8
  \key a \major
  \lower-verse-one
  % \bar "|."
}

dynamics = {
}

lyricsmain = \lyricmode {
  竹 籬 上 停 留 著 蜻 蜓
  玻 璃 瓶 裡 插 滿 小 小 森 林
  青 春 嫩 綠 的 很 鮮 明
  百 葉 窗 折 射 的 光 影
  像 有 著 心 事 的 一 張 表 情
  而 你 低 頭 拆 信
  想 知 道 關 於 我 的 事 情
  青 苔 入 鏡 簷 下 風 鈴 搖 晃 曾 經
  回 憶 是 一 行 行 無 從
  剪 接 的 風 景 愛 始 終 年 輕
  而 我 聽 見 下 雨 的 聲 音
  想 起 你 用 唇 語 說 愛 情
  幸 福 也 可 以 很 安 靜
  我 付 出 一 直 很 小 心
  終 於 聽 見 下 雨 的 聲 音
  於 是 我 的 世 界 被 吵 醒
  就 怕 情 緒 紅 了 眼 睛
  不 捨 得 淚 在 彼 此 的 臉 上 透 明
  愛 在 過 境 緣 分 不 停 誰 在 擔 心
  窗 台 上 滴 落 的 雨 滴
  輕 敲 著 傷 心 淒 美 而 動 聽
  而 我 聽 見 下 雨 的 聲 音
  想 起 你 用 唇 語 說 愛 情
  熱 戀 的 時 刻 最 任 性
  不 顧 一 切 的 給 約 定
  終 於 聽 見 下 雨 的 聲 音
  於 是 我 的 世 界 被 吵 醒
  發 現 你 始 終 很 靠 近
  默 默 的 陪 在 我身邊 態 度 堅 定
}

\paper {
  page-breaking = #ly:page-turn-breaking
}
\score {
  <<
    \new Staff = "melodystaff" <<
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.instrumentName = #"Vocal"
      \set Staff.midiMinimumVolume = #0.7
      \set Staff.midiMaximumVolume = #0.8
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.9
        \set Staff.midiMaximumVolume = #1
        \upper
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.9
        \set Staff.midiMaximumVolume = #1
        \lower
      }
    >>
  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      % \Dynamics \RemoveEmptyStaves
    }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}

\book {
\bookOutputSuffix "no-vocal"
\score {
  <<
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \upper
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \lower
      }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}
}
