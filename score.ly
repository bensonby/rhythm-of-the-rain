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

meter-nine-four-plus-five = \overrideTimeSignatureSettings
        9/8        % timeSignatureFraction
        1/8        % baseMomentFraction
        #'(4 5)    % beatStructure
        #'()       % beamExceptions
meter-nine-three-plus-six = \overrideTimeSignatureSettings
        9/8        % timeSignatureFraction
        1/8        % baseMomentFraction
        #'(3 6)    % beatStructure
        #'()       % beamExceptions
meter-seven-four-plus-three = \overrideTimeSignatureSettings
        7/8        % timeSignatureFraction
        1/8        % baseMomentFraction
        #'(4 3)    % beatStructure
        #'()       % beamExceptions
meter-eleven-four-plus-three = \overrideTimeSignatureSettings
        11/8        % timeSignatureFraction
        1/8        % baseMomentFraction
        #'(4 4 3)    % beatStructure
        #'()       % beamExceptions
meter-five-episode = \overrideTimeSignatureSettings
        10/8        % timeSignatureFraction
        1/8        % baseMomentFraction
        #'(3 4 3)    % beatStructure
        #'()       % beamExceptions
meter-five-two-plus-three = \overrideTimeSignatureSettings
        5/4        % timeSignatureFraction
        1/4        % baseMomentFraction
        #'(2 3)    % beatStructure
        #'()       % beamExceptions

melody-intro = \relative c {
  \time 9/8
  r2 r4 r4.
  \time 4/4
  R1
  \time 7/8
  R2..
  R2..
  \time 9/8
  r2 r4 r4.

  r2 r4 r4.
  \time 4/4
  R1
  \time 7/8
  R2..
  R2..
}

melody-verse-one = \relative c' {
  \time 4/4
	r2 r4 r8
	a8\(
	\time 9/8
  % \time #'(4 2 3) 9/8
	b8 b b a b4 e cis8\)
	\time 7/8
	r2 r4 a8\(
	\time 9/8
	b8 b b a b4 e a,8\)
	\time 4/4
	r2 r8 e'4\( cis8\)
	\time 7/8
	r2 fis4\( b,8~
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

melody-bridge-two = \relative c' {
	\time 9/8
	r4 r8 cis\( d4 cis gis'8\)
	r4 r8 cis,\( d4 cis gis'8\)
	r4 r8 fis\( gis4 a cis8\)
	\time 4/4
	r2 r4 a8\( gis
	\time 5/4
	a4 d,8 cis d4 a' a
	r4 e8 cis e4 a a
  \time 11/8
	r4 a8 fis a4 cis cis4.(
	\time 4/4
	b4)\)  r4 r2
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
	b4)\)  r4 r4 r4.
	\time 4/4
}

melody-chorus-one = \relative c'' {
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
	r4 gis8 gis4 a a
}

melody-episode = \relative c' {
  \time 9/8
  \repeat unfold 3 {
    r2. r4.
  }
  \time 7/8
  \repeat unfold 2 {
    r2 r4.
  }
  \time 5/4
  r4. r2 r4.
  \time 9/8
  r4. r2.
  \time 5/4
  r4. r2 r4.
  \time 9/8
  r4. r2.
  \time 4/4
  R1
}

melody = \relative c' {
  \meter-nine-four-plus-five
  \meter-seven-four-plus-three
  \meter-eleven-four-plus-three
	\key a \major
	\time 7/8
  \tempo 4 = 92
  \melody-intro
  \melody-verse-one
  \melody-bridge-one
  \melody-chorus-one
  \melody-episode
  \melody-bridge-two
  \melody-chorus-one
}

upper-intro = \relative c''' {
  \time 9/8
  <a cis,>2 gis4~ gis g8~ 
  \time 4/4
  g1
  \time 7/8
  fis2~ fis4.
  f2~ f4.
  \time 9/8
  dis2~ dis4. g8 gis

  <a cis,>2 gis4~ gis g8~ 
  \time 4/4
  g1
  \time 7/8
  fis2~ fis4.
  f2 b,8 cis d~
  \time 4/4
  <e d gis,>1
}

lower-intro = \relative c' {
  \clef treble
  \time 9/8
  a8 e' fis gis b e, cis' e, e'
  \time 4/4
  cis8 b a g e g a b
  \time 7/8
  cis8 b a g e d b
  a8 b f' a f a b
  \time 9/8
  a,8 dis fis a b dis fis4.

  a,,8 e' fis gis b e, cis' e, e'
  \time 4/4
  cis8 b a g e g a b
  \time 7/8
  cis8 b a g e d b
  a8 b f' a~ a4.
  \time 4/4
  e1
}

upper-verse-one = \relative c' {
  \time 9/8
  r2. r4.
  \time 7/8
  R2..
  \time 9/8
  r2. r4.
  \time 4/4
  R1
  \time 7/8
  R2..
  \time 9/8
  r2. r4.
  \time 7/8
  R2..
  R2..
}

upper-verse-one-b = \relative c'' {
  \time 9/8
  r4 e fis gis b8~
  \time 7/8
  b4 cis e4.
  \time 9/8
  r4 e, fis gis b8~
  \time 4/4
  b4 cis gis'2
  \time 7/8
  r4 e d4.~
  \time 9/8
  d4 gis, fis e d8~
  \time 7/8
  d4 gis a b8~
  \time 9/8
  b4 cis d e,16 fis gis a b bis
}

lower-verse-one = \relative c' {
  \time 9/8
  a8 e' a b cis e b cis e
  \time 7/8
  b8 a e d cis e b
  \time 9/8
  fis8 e' a b cis e b cis e
  \time 4/4
  b8 a e d cis a' gis e
  \time 7/8
  d8 b' cis e b cis e
  \time 9/8
  cis b e, b' a cis, a' gis a,
  \time 7/8
  b8 a' cis fis, a d gis,
  e8 fis a d e gis cis
}

lower-verse-one-b = \relative c' {
  \time 9/8
  a8 e' a b cis e b cis e
  \time 7/8
  b8 a e d cis e b
  \time 9/8
  fis8 e' a b cis e b cis e
  \time 4/4
  b8 a e d cis a' gis b,
  \time 7/8
  d8 b' cis e b cis e
  \time 9/8
  cis b e, b' a cis, a' gis a,
  \time 7/8
  b8 a' cis d fis cis d
  \time 9/8
  e,8 fis a d e gis, b d, eis,
}

upper-bridge-one = \relative c''' {
  \time 9/8
  cis4 r fis8 gis, f' a, e'
  r2 fis8 gis, f' a, e'
  r2 b8 e, bis' e, cis'
  \time 4/4
  r2 r8 fis, e' cis
  \time 5/4
  d4 r d,8 b' e, cis' fis, d'
  r2 e,8 cis' fis, d' gis, e'
  \time 11/8
  r2 fis,8 d' gis, e' a, \ottava #1 fis' cis'
  \time 9/8
  b16 a gis fis \ottava #0 e d cis b a gis fis e d cis b a gis fis
  \time 4/4
  e4 r r2
}

lower-bridge-one = \relative c {
  \time 9/8
  fis8 cis' gis' b~ b4~ b4.
  \clef bass
  eis,,8 \clef treble cis' gis' b~ b4 b4.
  \clef bass e,,8 \clef treble cis' gis' b~ b4 b4.
  \time 4/4
  \clef bass dis,,8 a' cis fis a2
  \time 5/4
  b,,8 a' d fis~ fis2 e8 b
  cis,8 a' e' gis~ gis4. fis8 e b
  \time 11/8
  d,8 a' cis fis~ fis8 cis e d b a b,
  \time 9/8
  e, 8 fis' a d~ d4~ d4.
  \time 4/4
  <e, fis a d>1
}

upper-chorus-one = \relative c' {
  \meter-nine-four-plus-five
  \time 9/8
  r2 fis'8 e gis e b'
  \time 4/4
  e,2 a4\( gis
  \time 9/8
  e2\) gis8 e a e cis'
  \time 4/4
  e2 fis4\( gis
  \time 7/8
  a4\) e8 a, d a cis~
  \time 4/4
  cis8 e, b' e, a b, fis' b,
  \time 7/8
  e4 d'8 e, cis' a \ottava #1 a'
  \time 4/4
  gis2 \ottava #0 r2
  \time 9/8
  r2 fis,8 e gis e b'
  \time 4/4
  e,2 a4\( gis
  \time 9/8
  e2\) gis8 e a e cis'
  \time 4/4
  e2 fis4\( gis
  \time 7/8
  a4\) e8 a, d a cis~
  \time 4/4
  cis8 e, b' e, a b, fis' b,
  \time 9/8
  e2 cis'8 e, e' e, cis'
  \meter-nine-three-plus-six
  \time 9/8
  <e, a d>4. d8 e fis gis a b
  \meter-nine-four-plus-five
  \time 9/8
}

lower-chorus-one = \relative c' {
  \time 9/8
  \clef treble
  a8 e' b' cis~ cis4~ cis4.
  \time 4/4
  cis,8 e b' cis~ cis2
  \time 9/8
  fis,,8  e' a b~ b4~ b4.
  \time 4/4
  cis,8 e gis b~ b2
  \time 7/8
  d,8 a' cis fis~ fis4.
  \time 4/4
  cis,8 e a b~ b2
  \time 7/8
  b,8 fis' a d~ d4.
  \time 4/4
  e8 d a fis e b a e
  \time 9/8
  a8 e' b' cis~ cis4~ cis4.
  \time 4/4
  cis,8 e b' cis~ cis2
  \time 9/8
  fis,,8  e' a b~ b4~ b4.
  \time 4/4
  cis,8 e gis b~ b2
  \time 7/8
  d,8 a' cis fis~ fis4.
  \time 4/4
  cis,8 e a cis~ cis2
  \time 9/8
  b,8 fis' a d~ d4~ d4.
  \clef bass
  <e,, fis'>4.~ q2.
}

upper-episode = \relative c''' {
  \time 9/8
  cis4. e2 cis4
  \meter-nine-three-plus-six
  fis4 e8~ e fis e d cis c
  \meter-nine-four-plus-five
  b2 d,8 f a f b
  \time 7/8
  c2 dis8
  \ottava #1
  b' a
  fis8 f \ottava #0 e dis d cis b
  \time 5/4
  ais4. eis2 eis'8[ cis eis,]
  \time 9/8
  e?4. b'4 ais gis
  \time 5/4
  <d fis>4 d8 fis d b' fis cis' b gis'
  \time 9/8
  <fis, c>4. dis8 c' fis, dis' a fis'
  \time 4/4
  <eis gis,>2 fis4 gis
}

lower-episode = \relative c' {
  \meter-nine-three-plus-six
  \time 9/8
  \clef treble
  a8 e' fis gis e b' e, cis' e,
  e'8 g, fis e2.
  \meter-nine-four-plus-five
  \time 9/8
  d8 f a b~ b4~ b4.
  \time 7/8
  dis,8 a' b c fis4.
  eis,8 b' dis eis gis4.
  \time 5/4
  fis,,8[ cis' eis] fis[ eis ais eis] bis' eis,4
  \meter-nine-three-plus-six
  \time 9/8
  fis,8 e'? gis cis e, b' e, ais e
  \meter-five-two-plus-three
  \time 5/4
  fis,8 b a' b~ b2.
  \time 9/8
  \clef bass d,,8 a' fis'~ fis2.
  \time 4/4
  cis,8 b' eis gisis~ gisis2

}

upper-bridge-two = \relative c'' {
  \time 9/8
  a8 <e b' e>4.~ q4~ q4.
  a8 <eis b' e>4.~ q4~ q4.
  a8 <fis gis e'>4.~ q4~ q4.
  \time 4/4
  a8 <b fis' a>4.~ q2
  \time 5/4
  r2 d8 b' e, cis' f, d'
  r2 e,8 cis' fis, d' gis, e'
  \time 11/8
  r2 fis,8 dis' gis, e' a, fis' \ottava #1 e'
  \time 4/4
  ees16 d c bes aes g c bes aes g f ees \ottava #0 d c bes aes
  g4 r4 r2
}

lower-bridge-two = \relative c {
  \clef bass
  \time 9/8
  fis8~ <fis gis'>4.~ q4~ q4.
  eis8~ <eis cis'>4.~ q4~ q4.
  e8~ <e cis'>4.~ q4~ q4.
  \time 4/4
  dis8~ <dis cis'>4.~ q2
  \time 5/4
  d8 b' f' a~ a2.
  cis,,8 b' e gis~ gis2.
  \time 11/8
  c,,8 a' dis fis~ fis2~ fis4.
  \time 4/4
  b,,8
  \clef treble
  c' ees aes~ aes2
  <d, a' c>2\arpeggio
  \clef bass <gis, d' e>
}

upper = \relative c' {
  \meter-nine-four-plus-five
  \meter-seven-four-plus-three
  \meter-eleven-four-plus-three
  \clef treble
  \tempo 4 = 92
  \key a \major
  \upper-intro
  \upper-verse-one
  \upper-verse-one-b
  \upper-bridge-one
  \upper-chorus-one
  \upper-episode
  \upper-bridge-two
  \upper-chorus-one
  % \bar "|."
}

lower = \relative c {
  \meter-nine-four-plus-five
  \meter-seven-four-plus-three
  \meter-eleven-four-plus-three
  \clef treble
  \time 7/8
  \key a \major
  \lower-intro
  \lower-verse-one
  \lower-verse-one-b
  \lower-bridge-one
  \lower-chorus-one
  \lower-episode
  \lower-bridge-two
  \lower-chorus-one
  % \bar "|."
}

pedals = {
  % verse one
  s2..
  s1\sustainOn
  s1
  s1\sustainOff\sustainOn
  s1
  s2..\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s4.
  s2..\sustainOff\sustainOn
  s2..\sustainOff\sustainOn

  s1\sustainOn
  s1
  s1\sustainOff\sustainOn
  s1
  s2..\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s4.
  s2..\sustainOff\sustainOn
  s2\sustainOff\sustainOn s4\sustainOff\sustainOn s4.

  % bridge
  s2.\sustainOff\sustainOn s4.
  s2.\sustainOff\sustainOn s4.
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s2
  s2.\sustainOff\sustainOn s2
  s2.\sustainOff\sustainOn s4 s4.
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff

  % chorus
  s2.\sustainOn s4.
  s1\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn
  s2..\sustainOff\sustainOn
  s1\sustainOff\sustainOn
  s2..\sustainOff\sustainOn
  s1\sustainOff\sustainOn

  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn
  s2..\sustainOff\sustainOn
  s1\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s4.
  s2.\sustainOff\sustainOn s4.

  % episode
  s2.\sustainOff\sustainOn s4.
  s2.\sustainOff\sustainOn s4.
  s2.\sustainOff\sustainOn s4.
  s2..\sustainOff\sustainOn
  s2..\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s2
  s2.\sustainOff\sustainOn s4.
  s2.\sustainOff\sustainOn s2
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn

  % bridge
  s2.\sustainOff\sustainOn s4.
  s2.\sustainOff\sustainOn s4.
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s2
  s2.\sustainOff\sustainOn s2
  s2.\sustainOff\sustainOn s4 s4.
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn

  % chorus
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn
  s2..\sustainOff\sustainOn
  s1\sustainOff\sustainOn
  s2..\sustainOff\sustainOn
  s1\sustainOff\sustainOn

  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s4.
  s1\sustainOff\sustainOn
  s2..\sustainOff\sustainOn
  s1\sustainOff\sustainOn
  s2.\sustainOff\sustainOn s4.
  s2.\sustainOff\sustainOn s4.

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
  默 默 的 陪 在 我 身 邊 態 度 堅 定
}

\paper {
  page-breaking = #ly:page-turn-breaking
}
\score {
  <<
    \new Staff = "melodystaff" <<
      \set Staff.instrumentName = #"Vocal"
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \upper
        % \articulate << \upper \pedals >>
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \lower
        % \articulate << \lower \pedals >>
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
}

\score {
  <<
    \new Staff = "melodystaff" <<
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.instrumentName = #"Vocal"
      \set Staff.midiMinimumVolume = #0.9
      \set Staff.midiMaximumVolume = #1
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        % \upper
        \articulate << \upper \pedals >>
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        % \lower
        \articulate << \lower \pedals >>
      }
    >>
  >>
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
        \articulate << \upper \pedals >>
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \lower \pedals >>
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
