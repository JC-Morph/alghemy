# Alghemy
### Transmute your data with ease.

## Synopsis

Alghemy is a Ruby library built to facilitate the manipulation of data for artistic purpose.
It is intended for use as a mini [domain-specific language](https://en.wikipedia.org/wiki/Domain-specific_language).
It can recognise multiple sound, video, and image formats, convert between them, and automate unpredictable processes.


## Installation

All functionality is available through your Ruby REPL once you download/clone this repository.
The gem version of the library is currently offline by intention, but can easily be built natively.

1. Clone this repository or download as zip and extract. Then, you may optionally:
   1. `cd` to directory and run:
   ```
   gem build alghemy.gemspec
   gem install alghemy-0.1.0.gem
   ```
   1. add alghemy/bin to your system path.


## Requirements

### Programs

Alghemy uses the following programs to process files, and expects them to be installed:

- [ffmpeg](https://ffmpeg.org) \- Video-based processes.
- [imagemagick](www.imagemagick.org/script/index.php) \- Image-based processes.
  - Alghemy currently uses the deprecated convert utility from imagemagick 6.9 or lower.
  If you are installing imagemagick 7.0 or above, make sure to include legacy utilities.
- [sox](sox.sourceforge.net) \- Sound-based processes.
- [mrswatson](https://github.com/teragonaudio/MrsWatson) \- VST-related processes.

NOTE: To perform image-based fast-fourier transforms, your version of ImageMagick must support the [fftw](www.fftw.org) delegate.
To check for this functionality, run `convert --version` and look for `fftw` in `Delegates (built-in):`.

### Gems

Alghemy uses the following gem:

- [listen](https://github.com/guard/listen) \- Used to monitor directories for changes.
  install with `gem install listen`


## Usage

Alghemy is intended to be used in a REPL environment. There are a couple of ways to make this happen:
- Start your Ruby REPL and run:
    `require_relative path/to/alghemy/lib/alghemy.rb`
  - If you built the gem:
    `require 'alghemy'`
- Run `alghemy` to open irb with library functionality enabled.
  This is only available if you built the gem or added bin to your path.

To demonstrate the capabilities of Alghemy, here is a simple use case:

### Initalising Matter
In Alghemy, the Matter class is a base representation of a file or files.
To manipulate a file, you should evoke Matter with the file to represent.

In this example we will use a typical image file with the name "ouroboros.png".
```ruby
fire = Matter.evoke 'ouroboros.png'
=> #<Image:0x0000000ff2df50 @sijil="ouroboros.png">
```
Now we have a representation of our file. One of the primary features of Alghemy is the sonification of data. This is the process of converting arbitrary data - in this case an image - into sound. This allows you to manipulate data in unpredictable ways. To do this, we can use the sonify method:
```ruby
air = fire.sonify
=> #<Sound:0x000000119d9048
 @mems=
  [[:sonify,
    {:ents=>[["un", 8], ["flo", 32]], :extype=>[".png", Image]}]],
 @sijil="Alghemy/ouroboros/son.wav">
```

Now we have a sound representation of our image. We could try and alter this data, but as it represents a compressed image format (png), the integrity of the image is at risk.  Instead, let's try converting our image to a raw format. We can do this with the sublimate method:
```ruby
earth = fire.sublimate
=> #<Element:0x00000010a18ff0
 @mems=
  [[:sublimate, {:space=>"757x746", :depth=>8, :extype=>[".png", Image]}]],
 @sijil="Alghemt/ouroboros/sub.rgb">
```

Notice the class of Matter is now Element; this signifies data that is unidentifiable, and includes all raw formatted data. Since we didn't pass any options, the default raw image format of rgb was used. The transform recorded the dimensions and bitdepth of the image for us; this will come in handy later.  For now, let's sonify our raw image.
```ruby
air = earth.sonify
=> #{Sound:0x000000107c5910
 @mems=
  [[:sonify,
    {:ents=>[["un", 8], ["flo", 32]], :extype=>[".rgb", Element]}]],
   [:sublimate, {:space=>"757x746", :depth=>8, :extype=>[".png", Image]}]],
 @sijil="Alghemy/ouroboros/sub-son.wav">
```

Great, now we have a robust representation of our image in the sound domain. Let's mutate that sound with a VST effect plugin. This requires that you install your own VST effects as required by [mrswatson](https://github.com/teragonaudio/MrsWatson).
```ruby
air = air.mutate
=> #<Sound:0x0000000f8c9ec0
 @mems=
  [[:mutate,
    {:vst=>#<Vst:0x0000000f8cb6f8 @sijil="sykk">,
     :extype=>[".wav", Sound]}],
  [[:sonify,
    {:ents=>[["un", 8], ["flo", 32]], :extype=>[".rgb", Element]}]],
   [:sublimate, {:space=>"757x746", :depth=>8, :extype=>[".png", Image]}]],
 @sijil="Alghemy/ouroboros/sub-son-(M).wav">
```

Here is our processed sound file, hot off the press. We didn't explicity choose which effect to use, so alghemy selected one at random for us. Now we're going to convert it back into an image, to see what we hath wrought.
```ruby
fire = air.revert
=> #<Image:0x000000117c1ff8 @sijil="Alghemy/ouroboros/sub-son-(M)(R2).png">
```

Transmutations always return new Matter:
```ruby
fire.sublimate.sonify.mutate.revert
=> #<Image:0x0000001188b9c0 @sijil="Alghemy/ouroboros/sub-son-(M)(R2).png">
```

## Development

Alghemy is under very active development, and all code should be considered volatile. If you are interested in contributing please contact me at m.reinhardt@gmx.co.uk.

## License

The entirety of this library is available as open source under the terms of the [GPLv3 License](https://www.gnu.org/licenses/gpl.html).
