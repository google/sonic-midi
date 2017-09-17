sonic-midi
====

This tool allows to programmatically define melodies that can be played in Sonic Pi via an external
command-line interface (CLI) while automatically exporting them to MIDI files to be consumed
elsewhere (such as in LMMS).

Note: this is not an official Google product.

Installation
-------

    gem install sonic-midi

Usage
-----

    sonic-midi sonic melody.rb

    sonic-midi midi melody.rb

    sonic-midi all melody.rb

Defining a melody
-----------------

    The melodies are defined by the means of simple Ruby programs (see the examples directory for
    some examples).
    At the very least, a melody file needs to contain a function that specifies a single melody.

    For example:

    def melody
      return [[60], [0.25]]
    end

    This will result in the 4th octave C note to be played for a quarter duration.

    In general, the simple melody is defined as an array containing two or three subarrays:
      - List of MIDI pitches
      - List of durations (as fractions of the measure)
      - Optional: List of volumes (in the 0..5 range, to match SonicPi)

    Note that pitch of 0 is reserved for silence

    In order to allow playing multiple notes at the same time, the melody function can return a
    dictionary of sub-melodies instead of a single melody.

    For example:

    def melody()
      return { m1: m1(), m2: m2(), m3: m3() }
    end

    (We're assuming m1(), m2() and m3() are defined as individual melodies)

    In addition to the actual melody, the melody file can specify BPM (via def mybmp()) and a synth to
    use in SonicPi (via def mysynth()). Note that mysynth() is ignored when generating the Midi file.

Importing Midi to LMMS
----------------------

    Once you've generated a melody and prototyped it in SonicPi, you can use the exported Midi file
    in LMMS. For this, simply do Project | Import in LMMS and select the resulting Midi file. Note that
    by default, LMMS will create a SoundFont track, but you can override it with any instrument.

    Tip: the Midi files can be used to generate a percussion track (the pitches will get ignored).
